---
title: An unsolicited comment on Diebold's (2015) JBES article
layout: blog
author: Gray Calhoun
---
[1]:

I'm writing this on my way back from the [CIREQ time-series
econometrics conference][1] where I presented a paper on bootstrapping
out-of-sample statistics. And in the talk I emphasized that I was
operating pretty firmly in the framework of West's (1996) paper ---
asymptotic normality, and testing a null hypothesis about the true (or
pseudotrue) data generating process. In the Q&A section, I was asked
the (understandable) question, "Why do we want to use OOS tests to
test these null hypotheses anyway? Won't an in-sample test be better?"
And I was asked something pretty similar after the last talk I gave as
well. So I should write something up.

Before we start, since the math matters here, maybe we should spend a
paragraph on notation. The basic idea is that we want to learn
something about our statistical models, so we split up the data into a
"test sample" and a "training sample." We estimate the models' unknown
parameters recursively over the training sample, as though we were
producing a sequence of estimates in real time. (Dear internet
smartasses, I am aware that there are other estimation strategies.) If
we use OLS to estimate the parameters, this gives us
\[
\hat\beta_t = \Big(\sum_{s=1}^t x_t x_t'\Big)^{-1} \sum_{s=1}^t x_s y_s
\]
for $t = R, R+1, \dots, T-1$. We then use the information in each
period $t+1$ to evaluate the parameters, so $f_{t+1}(\hat\beta_t)$
depends on period-$t+1$ data (implicitly) and the estimat that could
have been made in period $t$. The "out-of-sample" statistic is an
average of $f_{t+1}(\hat\beta_t)$ over the test sample:
\[
\bar f = \tfrac{1}{P} \sum_{t=R+1}^{T-1} f_{t+1}(\hat\beta_t).
\]
A common example is to look at the models' mean squared error, in
which case we would have
\[
f_{t+1}(\hat\beta_t) = (y_{t+1} - x_{1,t+1}'\hat\beta_{1t})^2 - (y_{t+1} - x_{2,t+1}'\hat\beta_{2t})^2
\]
where $\hat\beta_{1t}$ are the parameter estimates for the first model
and $\hat\beta_{2t}$ are the estimates for the second.

Now, Diebold and Mariano (1995) is a fairly straightforward paper that
looks at the asymptotic behavior of statistics like $\bar f$ when
there are no parameters that need to be estimated, and West (1996)
looks at these statistics when the parameters *do* need to be
estimated. West shows that
\[
\sqrt{P} (\bar f - E f_t(\beta^*)) \to^d N(0, \Sigma)
\]
where $\beta^*$ is the limit of $\hat\beta_T$ as $T \to \infty$ and
$\Sigma$ may or may not reflect parameter estimation error in the
$\hat\beta_t$s, depending on specific aspects of functional form.

The issue is that, under the assumptions that West makes, there are
much better ways to test hypotheses about $E f_t(\beta^*)$.

Diebold has recently written a retrospective on the DMW test for the
JBES that argues that this statistic was never intended to test these
null hypotheses, which I find a little puzzling, but that it might be
useful for other hypotheses. And that was essentially the gist of the
two questions I've been asked. But I think that's misreading West's
results a bit. West's results are *not* very useful for testing the
hypothesis $E f_t(\beta^*) = 0$ because of degeneracy issues that
Clark and McCracken explore in their 2013 paper. In short, if the true
DGP can be expressed as a particular parameterization of both models
(say it's white noise), then they'll give identical forecasts in the
limit, $\sqrt{P} \bar f$ will converge to zero, and the asymptotic
normality results break down. So you can almost never use West's
results for testing. But West does establish, irrefutably, that the
asymptotic mean of these statistics is $E f_t(\beta^*)$, so if you
want to test something like $E f_t(\hat\beta_t) = 0$, you can, but
only because $E f_t(\hat\beta_t)$ is asymptotically indistinguishable
from $E f_t(\beta^*)$.

So how could we formalize their arguments? We're never going to show
that $\sqrt{P} (\bar f - \Delta)$ is asymptotically mean-zero normal
for any constant $\Delta$ other than one that's very close to $E
f_t(\beta^*)$. But we may be able to show that $\sqrt{P} (\bar f -
\Delta)$ is asymptotically mean-zero normal if $\Delta$ is a random
variable with mean $E f_t(\beta^*)$. (And, lo and behold, I've done
this in other research.)

One candidate is
\[
\Delta = \tfrac{1}{P} \sum_{t=R}^{T-1} E_t f_{t+1}(\hat\beta_t)
\]
where $E_t$ is the conditional expectation that conditions on all
of the time-$t$ information (including $\hat\beta_t$). Then
\[
\sqrt{P} (\bar f - \Delta) =
\tfrac{1}{\sqrt{P}} \sum_{t=R}^{T-1} \big[f_{t+1}(\hat\beta_t) - E_t f_{t+1}(\hat\beta_t)\big]
\]
is the normalized sum of a martingale difference sequence and it obeys
a CLT, so
\[
\sqrt{P} (\bar f - \Delta) \to^d N(0, \Omega).
\]

Even nicer, if we define
\[
\sigma_t = E_t(f_{t+1}(\hat\beta_t) - E_t(f_{t+1}(\hat\beta_t) ))^2
\]

then $(f_{t+1}(\hat\beta_t) - E_t f_{t+1}(\hat\beta_t)) / \sigma_t$ is
a martingale difference sequence with variance 1, even if
$f_{t+1}(\hat\beta_t)$ is degenerate because of nesting or overlapping
models. And I bet that you can show that you don't need to do West's
variance correction through standard MDS arguments.

So after formalizing those arguments, you can use the original
Diebold-Mariano statistic to test a direct hypothesis about which of
the models was more accurate on average over the test sample --- you
can construct a confidence interval for
\[
\tfrac{1}{P} \sum_{t=R}^{T-1} E_t f_{t+1}(\hat\beta_t).
\]

But let's get more ambitious. Suppose we instead want an interval for
$E_T f_{T+1}(\hat\beta_T)$ --- i.e. we want to know which model will
be more accurate if we start using it in the future. Then we have
\[
\sqrt{P} (\bar f - E_T f_{T+1}(\hat\beta_T)) = 
\sqrt{P} (\bar f - \Delta) +
\tfrac{1}{\sqrt{P}} \sum_{t=R}^{T-1} (E_t f_{t+1}(\hat\beta_t) - E_T f_{T+1}(\hat\beta_T)).
\]
The first term we've already dealt with.
Let $g(b) = E_t(f_{t+1}(b) \mid \hat\beta_t = b).
We can borrow from West and expand $g(\hat\beta_t)$ around $\hat\beta_T$, giving
\[
\tfrac{1}{\sqrt{P}} \sum_{t=R}^{T-1} (E_t f_{t+1}(\hat\beta_t) - E_T f_{T+1}(\hat\beta_T))
= \tfrac{1}{\sqrt{P}} \sum_{t=R}^{T-1} g'(b_t) (\hat\beta_t - \hat\beta_T)
\]
for some value of $b_t$ between $\hat\beta_t$ and $\hat\beta_T$.
We can apply the rest of West's arguments, and get
\[
\sqrt{P} (\bar f - E_T f_{T+1}(\hat\beta_T)) \to^d N(0, \Sigma)
\]
where $\Sigma$ will not necessarily be the Diebold-Mariano variance
estimator, but may be 