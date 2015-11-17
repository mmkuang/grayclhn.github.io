---
title: "Draft of a solution for Hayashi Chapter 2, empirical exercise 1 (Mishkin/Fama data)"
layout: blog
author: Gray Calhoun
---

Let's load the data set for Hayashi's Chapter 2 empirical exercise, which looks
at the efficient markets hypothesis, and turn it into a multivariate ts object.

{% highlight r %}
library(sandwich)
library(lmtest)
{% endhighlight %}

    ## Loading required package: zoo
    ## 
    ## Attaching package: 'zoo'
    ## 
    ## The following objects are masked from 'package:base':
    ## 
    ##     as.Date, as.Date.numeric

{% highlight r %}
td <- ts(read.delim(sep = "", head = FALSE,, nrows = 491,
    file = "http://fhayashi.fc2web.com/hayashi%20econometrics/ch2/MISHKIN.ASC")[,3:7],
    start = c(1950, 2), frequency = 12)
colnames(td) <- c("pai1", "pai3", "tb1", "tb3", "cpi")
{% endhighlight %}

(I know, not a very readable chunk of code and laced with magic numbers.) Here

-   `pai1` is 1 month inflation rate
-   `pai3` is 3 month inflation rate
-   `tb1` is 1 month T-bill rate
-   `tb3` is 3 month T-bill rate
-   `cpi` cpi price index

Construct real interest rates (note, R's lag takes the opposite sign from what I
expect.)

{% highlight r %}
pai <- 100 * ((td[,"cpi"] / lag(td[,"cpi"], -1))^12 - 1)
r <- td[,"tb1"] - pai
{% endhighlight %}

Question (d)
------------

Redo table 2.1

{% highlight r %}
acf(window(r, c(1953, 1), c(1971, 7)), 12, type = "correlation", plot=FALSE)
{% endhighlight %}

    ## 
    ## Autocorrelations of series 'window(r, c(1953, 1), c(1971, 7))', by lag
    ## 
    ## 0.0000 0.0833 0.1667 0.2500 0.3333 0.4167 0.5000 0.5833 0.6667 0.7500 
    ##  1.000 -0.101  0.172 -0.019 -0.004 -0.064 -0.021 -0.091  0.094  0.094 
    ## 0.8333 0.9167 1.0000 
    ##  0.019  0.004  0.207

{% highlight r %}
sapply(1:12, function(j) Box.test(window(r, c(1953, 1), c(1971, 7)), j, "Ljung-Box"))
{% endhighlight %}

    ##           [,1]                               
    ## statistic 2.312104                           
    ## parameter 1                                  
    ## p.value   0.1283702                          
    ## method    "Box-Ljung test"                   
    ## data.name "window(r, c(1953, 1), c(1971, 7))"
    ##           [,2]                               
    ## statistic 9.062178                           
    ## parameter 2                                  
    ## p.value   0.01076894                         
    ## method    "Box-Ljung test"                   
    ## data.name "window(r, c(1953, 1), c(1971, 7))"
    ##           [,3]                               
    ## statistic 9.142526                           
    ## parameter 3                                  
    ## p.value   0.02745473                         
    ## method    "Box-Ljung test"                   
    ## data.name "window(r, c(1953, 1), c(1971, 7))"
    ##           [,4]                               
    ## statistic 9.146098                           
    ## parameter 4                                  
    ## p.value   0.05754967                         
    ## method    "Box-Ljung test"                   
    ## data.name "window(r, c(1953, 1), c(1971, 7))"
    ##           [,5]                               
    ## statistic 10.08353                           
    ## parameter 5                                  
    ## p.value   0.07290269                         
    ## method    "Box-Ljung test"                   
    ## data.name "window(r, c(1953, 1), c(1971, 7))"
    ##           [,6]                               
    ## statistic 10.18888                           
    ## parameter 6                                  
    ## p.value   0.11692                            
    ## method    "Box-Ljung test"                   
    ## data.name "window(r, c(1953, 1), c(1971, 7))"
    ##           [,7]                               
    ## statistic 12.13318                           
    ## parameter 7                                  
    ## p.value   0.09626321                         
    ## method    "Box-Ljung test"                   
    ## data.name "window(r, c(1953, 1), c(1971, 7))"
    ##           [,8]                               
    ## statistic 14.21517                           
    ## parameter 8                                  
    ## p.value   0.07632656                         
    ## method    "Box-Ljung test"                   
    ## data.name "window(r, c(1953, 1), c(1971, 7))"
    ##           [,9]                               
    ## statistic 16.29702                           
    ## parameter 9                                  
    ## p.value   0.06093229                         
    ## method    "Box-Ljung test"                   
    ## data.name "window(r, c(1953, 1), c(1971, 7))"
    ##           [,10]                              
    ## statistic 16.37877                           
    ## parameter 10                                 
    ## p.value   0.08929096                         
    ## method    "Box-Ljung test"                   
    ## data.name "window(r, c(1953, 1), c(1971, 7))"
    ##           [,11]                              
    ## statistic 16.38244                           
    ## parameter 11                                 
    ## p.value   0.1275163                          
    ## method    "Box-Ljung test"                   
    ## data.name "window(r, c(1953, 1), c(1971, 7))"
    ##           [,12]                              
    ## statistic 26.54801                           
    ## parameter 12                                 
    ## p.value   0.008971044                        
    ## method    "Box-Ljung test"                   
    ## data.name "window(r, c(1953, 1), c(1971, 7))"

Question (e)
------------

Reproduce (2.11.9)

{% highlight r %}
d <- data.frame(
    pai = window(pai, c(1953, 1), c(1971, 7)),
    tb1 = window(td[,"tb1"], c(1953,1), c(1971, 7)))
m <- lm(pai ~ tb1, data = d)
coeftest(m, vcovHC)
{% endhighlight %}

    ## 
    ## t test of coefficients:
    ## 
    ##             Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept) -0.86777    0.43621 -1.9893   0.0479 *  
    ## tb1          1.01470    0.11379  8.9174   <2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Question (f)
------------

Degree of freedom correction

{% highlight r %}
coeftest(m, vcovHC(m, "HC1"))
{% endhighlight %}

    ## 
    ## t test of coefficients:
    ## 
    ##             Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept) -0.86777    0.43317 -2.0033  0.04637 *  
    ## tb1          1.01470    0.11271  9.0029  < 2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Formula (2.5.5) with d = 1

{% highlight r %}
coeftest(m, vcovHC(m, "HC2"))
{% endhighlight %}

    ## 
    ## t test of coefficients:
    ## 
    ##             Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept) -0.86777    0.43371 -2.0008  0.04664 *  
    ## tb1          1.01470    0.11299  8.9803  < 2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Formula (2.5.5) with d = 2

{% highlight r %}
coeftest(m, vcovHC(m, "HC3"))
{% endhighlight %}

    ## 
    ## t test of coefficients:
    ## 
    ##             Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept) -0.86777    0.43621 -1.9893   0.0479 *  
    ## tb1          1.01470    0.11379  8.9174   <2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Question (g)
------------

{% highlight r %}
summary(m)
{% endhighlight %}

    ## 
    ## Call:
    ## lm(formula = pai ~ tb1, data = d)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -7.1928 -1.9386 -0.2488  1.8967  8.4651 
    ## 
    ## Coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)  -0.8678     0.4326  -2.006   0.0461 *  
    ## tb1           1.0147     0.1227   8.271 1.24e-14 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 2.843 on 221 degrees of freedom
    ## Multiple R-squared:  0.2364, Adjusted R-squared:  0.2329 
    ## F-statistic: 68.41 on 1 and 221 DF,  p-value: 1.242e-14

Question (h)
------------

{% highlight r %}
bgtest(m, 12)
{% endhighlight %}

    ## 
    ##  Breusch-Godfrey test for serial correlation of order up to 12
    ## 
    ## data:  m
    ## LM test = 27, df = 12, p-value = 0.007727

Question (i)
------------

{% highlight r %}
d$m <- factor(rep_len(1:12, nrow(d)))
summary(lm(pai ~ tb1 + m - 1, data = d))
{% endhighlight %}

    ## 
    ## Call:
    ## lm(formula = pai ~ tb1 + m - 1, data = d)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -5.6997 -1.8032 -0.3117  1.6411  8.4274 
    ## 
    ## Coefficients:
    ##      Estimate Std. Error t value Pr(>|t|)    
    ## tb1  1.024559   0.113824   9.001  < 2e-16 ***
    ## m1  -2.400232   0.710971  -3.376 0.000876 ***
    ## m2  -1.685401   0.710892  -2.371 0.018653 *  
    ## m3  -0.228333   0.701930  -0.325 0.745284    
    ## m4   0.003571   0.697950   0.005 0.995923    
    ## m5  -1.271318   0.704815  -1.804 0.072702 .  
    ## m6   1.054809   0.697043   1.513 0.131716    
    ## m7   1.135892   0.699939   1.623 0.106123    
    ## m8  -2.564703   0.710668  -3.609 0.000384 ***
    ## m9  -1.227519   0.721790  -1.701 0.090487 .  
    ## m10 -0.049813   0.727579  -0.068 0.945481    
    ## m11 -1.685205   0.717566  -2.349 0.019778 *  
    ## m12 -2.030943   0.709809  -2.861 0.004646 ** 
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 2.632 on 210 degrees of freedom
    ## Multiple R-squared:  0.592,  Adjusted R-squared:  0.5668 
    ## F-statistic: 23.44 on 13 and 210 DF,  p-value: < 2.2e-16

Question (k)
------------

{% highlight r %}
d$pai <- window(td[,"pai1"], c(1953, 1), c(1971,7))
coeftest(lm(pai ~ tb1, data = d))
{% endhighlight %}

    ## 
    ## t test of coefficients:
    ## 
    ##              Estimate Std. Error t value  Pr(>|t|)    
    ## (Intercept) -0.484202   0.342663 -1.4131     0.159    
    ## tb1          0.807465   0.097165  8.3103 9.666e-15 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Question (l)
------------

{% highlight r %}
d2 <- data.frame(
    pai = window(td[,"pai1"], c(1979, 11)),
    tb1 = window(td[,"tb1"], c(1979, 11)))
coeftest(lm(pai ~ tb1, data = d2))
{% endhighlight %}

    ## 
    ## t test of coefficients:
    ## 
    ##             Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept) 0.395753   0.851840  0.4646    0.643    
    ## tb1         0.564369   0.098434  5.7335 6.38e-08 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
