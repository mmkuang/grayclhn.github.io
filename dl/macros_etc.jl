
function f(arg1, arg2)
    if isa(arg1, Int64)
        return arg1
    elseif isa(arg2, Function)
        return arg2(arg1)
    end
    arg1, arg2 # <- implicitly returned
end

f(17., x -> x^2)
#      ========
#> 289.0

g(arg1, arg2, arg3...) = arg1(arg2, arg3)

a, b  = g(17, 329, 932) do x, y # <- anon. fn as
            x, y, map(z -> x*z, y) # first arg.
        end[1:2] # <- discard third value returned
#> (17,(329,932))

# We would never want to write a function like
# this in Julia:
function f(arg1, arg2)
    if isa(arg1, Int64)
        return arg1
    elseif isa(arg2, Function)
        return arg2(arg1)
    end
    arg1, arg2 # <- implicitly returned
end

# A better way is to define methods
h(x::Int64, y) = x
h(x, g::Function) = g(x) # <- get a warning
h(x, y) = x, y # Fallback definition (the default)

# Should define this as well (first)
h(x::Int64, g::Function) = x

# Defining new objects is easy, use the
# 'type' keyword
type MyObject
    x::Integer
    y::Integer
end

a = MyObject(32, 59)
a + a
#> ERROR: `+` has no method matching
#> +(::MyObject, ::MyObject)

+(a::MyObject, b::MyObject) =
    MyObject(a.x+b.x, a.y+b.y)

a + a
#> MyObject(64,118)

# The `Symbol' object type is used for variable
# names. Symbols start with a `:'

:height
#> :height

typeof(:height)
#> Symbol

1 + :height
#> ERROR: `+` has no method matching +(::Int64, ::Symbol)

# Code is represented as an `Expr' object.
:(height + 23)
#> :(height + 23)

Expr(:call, :+, :height, 23)
#> :(height + 23)

# The code is run by evaluating it. This can
# be done manually through `eval'

eval(:(height + 23))
#> ERROR: height not defined
eval(:(height = 70))
height
#> 70
eval(:(height + 23))
#> 93

# `eval' always executes in the global (module)
# namespace, not the local namespace. AVOID eval!

f(height) = eval(:(height + 23))
f(12)
#> 93

# A useful idiom: if you absolutely _need_ local
# eval, you can create an anonymous function with
# eval and then call it

f_bad(height) = eval(:(height + 23))
f_bad(12)
#> 93

function f_good(height)
    tempf = eval(:(x -> x + 23))
    tempf(height)
end

f_good(12)
#> 35

# This should be a _last resort_, there are
# better alternatives

# Expressions have two (main) fields
# - head: the `type' of the expression
# - args: the terms that make up the expression

a = :(x < $height < y)
#> :(x < 70 < y)
a.head
#> :comparison
a.args
#> 5-element Array{Any,1}:
#>   :x
#>   :<
#> 70  
#>   :<
#>   :y
a.args[3] = :(2 * $height)
a
#> :(x < 2 * 70 < y)

using Devectorize
x = rand(100); y = randn(100)

#macro name
#-----
@devec r = exp(abs(x - y))
#      -------------------
#      Single expression passed to @devec

# @devec does the following:
#   1. writes an expression that has Julia code
#      to define `r'
#   2. writes a loop
#      - that iterates down `x' and `y'
#      - has `r[i] = exp(abs(x[i] - y[i]))' as
#        its body
# After @devec returns, Julia runs the new expression

macroexpand(:(@devec r = exp(abs(x - y))))
# returns (with some editing)
quote 
    _siz_16093 = Devectorize.ewise_shape(size(x),size(y))
    if _siz_16093 == () # <- `uniqified' var. names
        _tmp_16092 = exp(abs(x - y))
    else 
        _siz_16093 = Devectorize.ewise_shape(size(x),size(y))
        _ty_16094 = Devectorize.result_type(TFun{:exp}(),Devectorize.result_type(TFun{:abs}(),Devectorize.result_type(TFun{:-}(),eltype(x),eltype(y))))
        _tmp_16092 = Array(_ty_16094,_siz_16093)
        _len_16095 = length(_tmp_16092)
        for _i_16096 = 1:_len_16095
            _tmp_16092[_i_16096] = # <- assignment
               exp(abs(Devectorize.get_value(x,_i_16096)
                       - Devectorize.get_value(y,_i_16096)))
        end
    end
    r = _tmp_16092
end

# Dynamic models are annoying to work with!
# 
# Say we have an ARMA model

y[t+1] = a0 + a[1]*y[t] + a[2]*y[t-1] + e[t+1] + b*e[t]
e[t+1] ~ Normal(0, v)

# `Vectorizing' this is unpleasant
# Need to be careful about endpoints for loops

# Wouldn't this be nice?
@loop_ts 500 y[1:2] = (0,0) begin
  y[t+1] = a0 + a[1]*y[t] + a[2]*y[t-1] + e[t+1]+b*e[t]
  e[t] = Normal(0, v)
end
# Let a macro figure out the endpoints, etc.

# Let's leave `self initialization,' `robustness,'
# etc. as an optional homework exercise
y = zeros(500)
e = randn(500)

# Start with an example of the syntax we'd like:
@loop_ts y[t+1] = 0.8y[t] + 0.02y[t-2] + e[t+1]

# And the code we want it to generate:
for _t in 3:(length(y) - 1)
    y[_t+1] = 0.8y[_t] + 0.02y[_t-2] + e[_t+1]
end
# Our macro needs to:
# 1. determine which symbols are the vectors
# 2. extract the smallest and largest allowable index
# Other tasks (i.e. the loop body) are easy

macro loop_ts(ex)
    l, r = ex.args
    idx =
        if isexpr(l.args[2], :call)
            filter(x -> isa(x, Symbol),
                   l.args[2].args[2:end])[1]
        elseif isa(l.args[2], Symbol)
            l.args[2]
        end
    offsets = extrema(vcat(get_offsets(l),
                           get_offsets(r)))
    loopindex = :($(1 - offsets[1]):(length($(l.args[1]))
                                     - $(offsets[2])))
    quote
        for $idx in $loopindex
            $ex
        end
    end
end

function get_offsets(ex_::Expr)

    isexpr(ex_,:call) &&
        return [[get_offsets(a)
                 for a in ex_.args[2:end]]...]

    isexpr(ex_,:ref) &&
        return get_offset_from_ref(ex_.args[2])

    warning("Not expecting to be here")
    return Int64[]
end

get_offsets(x) = Int64[]

get_offset_from_ref(s::Symbol) = 0
get_offset_from_ref(x::Number) = x

function get_offset_from_ref(ex_::Expr)
     
  if isexpr(ex_,:call)
      ex_.args[1] == :+ &&
          return sum([get_offset_from_ref(a)
                      for a in ex_.args[2:end]])
     
      ex_.args[1] == :- &&
          return (get_offset_from_ref(ex_.args[2])
                  - sum([get_offset_from_ref(a)
                         for a in ex_.args[3:end]]))
  end
  warning("Didn't expect to get here")
  return(0)
end

# we define a macro like this:
macro mymacro(e1, e2, e3)
  # syntax-y stuff here
end

# mymacro can be called in two ways:
@mymacro(expr_1, expr_2, expr_3) # <- no space before
# or                                  `(' !!!
@mymacro expr_1 expr_2 expr_3

# We can also define a macro
macro m_str(p) # <- p is now going to be a string
  # syntax-y stuff here
end

# m_str gets called as
m"RU 1337 H4X0RZ!?!" # <- clearly a DSL
