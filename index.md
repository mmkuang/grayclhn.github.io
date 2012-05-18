---
layout: default
title: Gray Calhoun's homepage
---
[CV]: gcalhoun-curriculum-vitae.html

I've been an Assistant Professor in Iowa State's Economics Department
since August, 2009. Before that, I attended UC San Diego for graduate
school. I'm studying econometrics and am particularly interested in
settings where we are considering using a complicated model that may
be estimated imprecisely, as often happens in forecasting,
macroeconomics, and finance. See [my CV][CV] for more details.

I'm in the process of moving my webpage from its old address to
GitHub.  The old page is available at
<http://www.econ.iastate.edu/~gcalhoun>.  You might be interested in
the following items:

* Publicly-available projects that I'm currently working on are
  listed on this page.  You can also find projects at
  <http://github.com/gcalhoun>.

* [Curriculum vitae][CV]: This is an especially tedious version
  of my CV for internal departmental use.

* [Refereed publications](publications.html)

* [Undergraduate teaching](undergraduate.html)

* [Graduate teaching](graduate.html)

* [Miscellaneous and informal documents](documents.html): Assorted
  short and under-edited essays.  Some might call them blog posts, but
  that would overstate how frequently I write them.  You can get a
  list of all of the documents [here](/essays/).

You can reach me by email at <gcalhoun@iastate.edu>.  My office is
Heady Hall, room 467, (515) 294-6271.  If you find any errors on my
website, please let me know directly or open a new issue at
<https://github.com/gcalhoun/gcalhoun.github.com/issues>.

Current working papers
----------------------

[An asymptotically normal out-of-sample statistic of equal predictive ability for nested models.](http://www.econ.iastate.edu/~gcalhoun/calhoun-oos-2011.pdf) (September 2011)

This paper proposes a modification of Clark and West's (2007,
*J. Econom.*) adjusted out-of-sample t-test. The alternative model is
still estimated with a fixed-length rolling window, but the benchmark
is estimated with a recursive window. The resulting statistic is
asymptotically normal even when the models are nested. Moreover, the
alternative model can be estimated using common model selection
methods, such as the AIC or BIC. This paper also presents a method to
compare multiple models simultaneously while controlling family-wise
error, and substantially improves existing block bootstrap methods for
out-of-sample statistics. This procedure is then used to analyze Goyal
and Welch's (2008, *Rev. Finan. Stud.*) excess returns dataset.

[Block bootstrap consistency under weak assumptions.](http://www.econ.iastate.edu/sites/default/files/publications/papers/p14313-2011-09-23.pdf) (September 2011)

This paper weakens the size and moment conditions needed for typical
block bootstrap methods (i.e. the moving blocks, circular blocks, and
stationary bootstraps) to be valid for the sample mean of
Near-Epoch-Dependent functions of mixing processes; they are
consistent under the weakest conditions that ensure the original
process obeys a Central Limit Theorem (those of de Jong, 1997,
*Econometric Theory*). In doing so, this paper extends de Jong's method
of proof, a blocking argument, to hold with random and unequal block
lengths. This paper also proves that bootstrapped partial sums satisfy
a Functional CLT under the same conditions.

[Out-of-sample comparisons of overfit models](http://www.econ.iastate.edu/sites/default/files/publications/papers/p12462-2011-02-10.pdf) (February, 2011) [(R package)](http://www.econ.iastate.edu/~gcalhoun/software/fwPackage_1.0.tar.gz) [(Additional Files)](http://www.econ.iastate.edu/~gcalhoun/software/calhoun-2010-overfit.tar.gz)

This paper uses dimension asymptotics to study why overfit linear
regression models should be compared out-of-sample; we let the number
of predictors used by the larger model increase with the number of
observations so that their ratio remains uniformly positive. Under
this limit theory, the naive Diebold-Mariano-West out-of-sample test
can test hypotheses about a key quantity for evaluating forecasting
models---a time series analogue to the generalization error---as long
as the out-of-sample period is small relative to the total sample
size. Moreover, tests that are designed to reject if the larger model
is true, such as the usual in-sample Wald and LM tests and also Clark
and McCracken's (2001, 2005a), McCracken's (2007) and Clark and West's
(2006, 2007) out-of-sample statistics, will choose the larger model
too often when the smaller model is more accurate.

Software development
--------------------

[The dbframe R package](https://www.github.com/gcalhoun/dbframe-R-library)

This library sets up an interface between R and an SQL database using
the DBI library. dbframe is designed to make writing queries
easier. This package is written as a literate program (see, e.g.,
[this
description](http://vasc.ri.cmu.edu/old_help/Programming/Literate/literate.html))
using [noweb](http://www.cs.tufts.edu/~nr/noweb/); the most immediate
implication of that statement is that you should not edit the R or Rd
files in the package because they are automatically generated by the
.rw files (in the "source" directory). The documentation and scripts
can be generated from these files using the tord noweb backend
([available
here](http://www.econ.iastate.edu/~gcalhoun/software/tord)), which is
a slightly modified version of noweb's original totex. The dbframe
library is available under version 3 of the GPL.

<!--  LocalWords:  Calhoun's gcalhoun html UC webpage GitHub Econom AIC Goyal
 -->
<!--  LocalWords:  Welch's Finan de Jong Jong's CLT overfit Diebold LM
 -->
<!--  LocalWords:  McCracken's
 -->
