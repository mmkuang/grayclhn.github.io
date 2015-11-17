---
title: "Draft of a solution for Hayashi Chapter 2, empirical exercise 2 (Nerlove data)"
layout: blog
author: Gray Calhoun
---

First load the data and packages.

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
nerlove.data <- read.delim(
    "http://fhayashi.fc2web.com/hayashi%20econometrics/ch1/NERLOVE.ASC",
    sep = "", head = FALSE, nrows = 145,
    col.names = c("TC", "Q", "PL", "PF", "PK"))
{% endhighlight %}

Question (i)
------------

{% highlight r %}
m4 <- lm(log(TC/PF) ~ poly(log(Q), 2) + log(PL/PF) + log(PK/PF),
    data = nerlove.data)
x <- model.matrix(m4)
x2 <- do.call(cbind, sapply(1:5, function(i) sapply(i:5, function(j) x[,i] * x[,j])))
summary(lm(resid(m4)^2 ~ x2))
{% endhighlight %}

    ## 
    ## Call:
    ## lm(formula = resid(m4)^2 ~ x2)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.59487 -0.04898 -0.00639  0.03018  1.34353 
    ## 
    ## Coefficients: (2 not defined because of singularities)
    ##             Estimate Std. Error t value Pr(>|t|)  
    ## (Intercept) -10.3048     8.7730  -1.175   0.2423  
    ## x21               NA         NA      NA       NA  
    ## x22          -9.1411     5.7908  -1.579   0.1168  
    ## x23           7.8682     6.0727   1.296   0.1974  
    ## x24          -3.9807     4.1388  -0.962   0.3379  
    ## x25           5.5423     3.6994   1.498   0.1365  
    ## x26               NA         NA      NA       NA  
    ## x27          -1.6668     1.9687  -0.847   0.3987  
    ## x28          -1.9104     1.3789  -1.385   0.1683  
    ## x29           1.3775     1.2517   1.101   0.2731  
    ## x210         -2.8039     2.1022  -1.334   0.1846  
    ## x211          1.6834     1.4268   1.180   0.2402  
    ## x212         -1.2491     1.3356  -0.935   0.3514  
    ## x213         -0.3961     0.4995  -0.793   0.4292  
    ## x214          1.0228     0.8312   1.231   0.2207  
    ## x215         -0.7485     0.4236  -1.767   0.0796 .
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.1765 on 131 degrees of freedom
    ## Multiple R-squared:  0.4589, Adjusted R-squared:  0.4052 
    ## F-statistic: 8.547 on 13 and 131 DF,  p-value: 2.27e-12

n times R-squared is 145 \* 0.4589 which is 66.54

Question (j)
------------

Y voila:

{% highlight r %}
wmodel <- lm(resid(m4)^2 ~ I(1/Q), data = nerlove.data)
m4gls <- lm(log(TC/PF) ~ poly(log(Q), 2) + log(PL/PF) + log(PK/PF),
    data = nerlove.data, weights = predict(wmodel))
summary(m4gls)
{% endhighlight %}

    ## 
    ## Call:
    ## lm(formula = log(TC/PF) ~ poly(log(Q), 2) + log(PL/PF) + log(PK/PF), 
    ##     data = nerlove.data, weights = predict(wmodel))
    ## 
    ## Weighted Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.73638 -0.05166 -0.00726  0.04467  0.77905 
    ## 
    ## Coefficients:
    ##                  Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)        0.2254     1.2316   0.183    0.855    
    ## poly(log(Q), 2)1  16.7474     0.4823  34.726  < 2e-16 ***
    ## poly(log(Q), 2)2   2.7693     0.4199   6.595 8.05e-10 ***
    ## log(PL/PF)         0.3938     0.2898   1.359    0.176    
    ## log(PK/PF)        -0.3613     0.2706  -1.335    0.184    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.151 on 140 degrees of freedom
    ## Multiple R-squared:  0.9322, Adjusted R-squared:  0.9303 
    ## F-statistic: 481.4 on 4 and 140 DF,  p-value: < 2.2e-16

You may have picked up a typo from my chapter 1 answer. (The weights there had a multiplication instead of an addition.)

Question (k)
------------

I just wanted one line for this:

{% highlight r %}
coeftest(m4gls, vcovHC)
{% endhighlight %}

    ## 
    ## t test of coefficients:
    ## 
    ##                  Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)       0.22543    1.46401  0.1540  0.87784    
    ## poly(log(Q), 2)1 16.74737    0.78025 21.4642  < 2e-16 ***
    ## poly(log(Q), 2)2  2.76928    1.38681  1.9969  0.04778 *  
    ## log(PL/PF)        0.39383    0.46764  0.8422  0.40113    
    ## log(PK/PF)       -0.36132    0.31290 -1.1547  0.25016    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
