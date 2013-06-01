---
layout: blog
title: "Q: What's new in Bayesian time-series?"
---

Next week I start teaching a PhD elective on Macroeconometrics again
(I’m co-teaching the class with Helle Bunzel and I taught the first 4
weeks and will teach the last 3½ weeks of the class). We’ll cover
SVARs, cointegration, and stochastic DSGE models and prepping this
material has made me realize that I know very little about Bayesian
modeling for nonstandard problems (i.e. where asymptotic normality
would fail for a basic frequentist estimator).

My view on Bayesian econometrics right now is that, if we want to make
any sort of data-driven decision or recommendation, we need estimators
that incorporate both the point estimate and measures of its
uncertainty. Frequentist methods explicitly separate the two, so that
all has to be done informally; integrating over the posterior
distribution seems like a reasonable alternative to that informal
analysis. But I don’t trust myself to come up with reasonable priors;
I’d (almost) like to use the prior that would give me the asymptotic
distribution of a reasonable frequentist estimator as its posterior
density, which seems like the best of both worlds and so is probably
subtly wrong.

Some caveats, though, are:

1. Bayesian stats, at least as traditionally taught, requires you to
actually write down a likelihood function and believe in it. With
frequentist asymptotic theory, we can write down a likelihood function
but only believe aspects of it. Under various assumptions, the
resulting estimator is still consistent and asymptotically normal and
we can adjust the confidence interval so that it’s asymptotically
valid. I’m sure that something similar exists for Bayesian analysis
but I haven’t seen it yet (presumably you could use a quadratic
approximation to the likelihood function instead of the actual
likelihood, and that should in some sense be asymptotically correct
whenever the quasi-MLE is).

2. Often the density of a standard frequentist estimator changes
dramatically over the parameter space in a way that kills inference
(for example, think about confidence intervals for the autoregressive
coefficient ρ in an AR(1) when ρ is near 1). If the Bayesian estimator
is not badly behaved too, that makes me nervous.

3. The second point’s been debated in the past; see Sims and Uhlig
(1991), Phillips (1991), and Phillips and Ploberger (1994). But I
don’t know what’s happened since then. Sims and Uhlig argue that the
likelihood function is still well behaved in the unit root setting, so
report information about the likelihood, which makes sense
intellectually but is going to result in you reporting estimators that
look like confidence intervals but can be very poorly behaved as
confidence intervals; Sims and Zha (1999) still advocate that approach
and Sims still argues for it, [at least as of
2007](http://sims.princeton.edu/yftp/EmetSoc607/AppliedBayes.pdf). He
may be right, but that doesn’t help reconcile the posterior density
with the asymptotic density of a classical estimator.

The Bayesian DSGE people don’t seem to worry about unit roots, so that literature’s not a help. And I’m aware of a few other papers, but nothing that digs into non-normal estimators. I guess I should tentatively play around with Phillips’s results; but it seems like I’m missing something.

1. Sims, Christopher A., and Harald Uhlig. “[Understanding unit
rooters: A helicopter
tour](http://www.jstor.org/stable/10.2307/2938280).” Econometrica
(1991): 1591-1599.

2. Sims, Christopher A., and Tao Zha. “[Error bands for impulse
responses](http://sims.princeton.edu/yftp/imperrs/m4Web.pdf).”
Econometrica 67, no. 5 (1999): 1113-1155.

3. Phillips, Peter CB. “[To criticize the critics: An objective
Bayesian analysis of stochastic
trends](https://cowles.econ.yale.edu/P/cp/p07b/p0798.pdf).” Journal of
Applied Econometrics 6, no. 4 (1991): 333-364

4. Phillips, Peter CB, and Werner Ploberger. “[Posterior odds testing
for a unit root with data-based model
selection](http://korora.econ.yale.edu/phillips/pubs/art/a101.pdf).”
Econometric Theory 10, no. 3-4 (1994): 774-808.
