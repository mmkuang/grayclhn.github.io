---
title: Gray Calhoun’s academic homepage
layout: front
---

I’m Gray Calhoun, an Assistant Professor in the Economics Department
at Iowa State. I work on Econometric theory, especially time series
and applications to forecasting and forecast evaluation. I graduated
with a PhD from UC San Diego in 2009, where I worked with Graham
Elliott and Allan Timmermann.

**Email:** «gcalhoun at iastate dot edu» (university) and «gray at clhn
dot org» (personal email and IM)

**Office:** 467 Heady Hall, (515) 294-6271.

**Links:** [Curriculum vitae][cv],
[IDEAS](http://ideas.repec.org/f/pca491.html),
[Google Scholar](http://scholar.google.com/citations?hl=en&user=OS8d9ycAAAAJ),
[LinkedIn](https://linkedin.com/in/grayclhn),
[GitHub](https://github.com/grayclhn),
and [Twitter](https://twitter.com/grayclhn).

Also check out the [Econometrics Free Library Project][EFLP],
a free/open-access textbook development project that you
should contribute to.

This page is available at <http://www.econ.iastate.edu/~gcalhoun> or
<http://gray.clhn.org>. They should be identical.

[cv]: http://www.econ.iastate.edu/sites/default/files/profile/cv/calhoun-cv.pdf
[EFLP]: http://www.econometricslibrary.org

<hr />

## PhD Students on the 2014 job market

**Anwen Yin** (Econ PhD, [Helle Bunzel](https://www.econ.iastate.edu/people/faculty/bunzel-helle) and I are co-advisors)  
[CV](http://anwenyin.weebly.com/cv.html),
[job market paper](http://anwenyin.weebly.com/uploads/4/1/6/0/41609955/cv_model_averaging_20141104.pdf),
[homepage](http://anwenyin.weebly.com/),
[LinkedIn](http://www.linkedin.com/pub/anwen-yin/27/650/970).  
Anwen’s taken a position as an Assistant Professor of Economics at
Texas A&M International University and is no longer on the job market.

**Matt Simpson** (Econ and Stats PhD; [Jarad Niemi](http://www.jarad.me/) and I are co-advisors)  
[CV](http://www.themattsimpson.com/wp-content/uploads/2014/10/CV.pdf),
[research](http://www.themattsimpson.com/research-2/),
[homepage](http://www.themattsimpson.com/).  
Matt’s taken a postdoc at University of Missouri and is no longer on the job market.

<hr />

<!--more-->

## Teaching
* [Principles of Macroeconomics (Econ 102)](102)
* [PhD Econometrics 1 — introduction to statistics
  and regression (Econ 671)](671)
* [PhD Macroeconometrics (Econ 674)](674)
* [Topics in statistical computing (Stat 590f)][590f] ([Heike Hofmann][]
  is teaching it; I’m attending.)
* MA Creative Component (Econ 599): Section CG,
  reference number 3154027
* Research for thesis or dissertation (Econ 699): Section CG,
  reference number 3171027

[590f]: https://github.com/heike/stat590f
[Heike Hofmann]: http://hofmann.public.iastate.edu/

<hr />

<!--more-->

## Working papers

* [Out-of-sample comparisons of overfit
  models](http://www.econ.iastate.edu/research/working-papers/p12462)
  (2014-03-30, submitted) with [Git repository](https://github.com/grayclhn/oos-overfit/tree/REStud) and
  [supplemental appendix](dl/calhoun-oosoverfit-appendix.pdf)
* [Block bootstrap consistency under weak
  assumptions](http://www.econ.iastate.edu/research/working-papers/p14313)
  (2014-10-06, submitted) with [supplemental appendix](dl/calhoun-bootstrap-appendix.pdf) and
  [Git repository](https://github.com/grayclhn/statboot-paper/tree/ET_submission_3)
* [Improved stepdown methods for asymptotic control of generalized
  error rates](dl/calhoun-stepdown.pdf) (2014-09-24, submitted) with
  [Git repository](https://git.ece.iastate.edu/gcalhoun/stepdown-paper/tree/jeconom_submission)
* [An asymptotically normal out-of-sample test based on mixed
  estimation windows](dl/calhoun-mixed-window.pdf) (2015-01-09, submitted) with
  [appendix](dl/calhoun-mixed-window-appendix.pdf)
  and [Git repository](https://git.ece.iastate.edu/gcalhoun/mixedwindow/tree/ecma-sub2)
* [Causality in the Reinhart-Rogoff dataset, the plots thicken](dl/calhoun-rr-graphics.pdf)
  (2015-02-06, submitted) with [source code archive](dl/calhoun-rr-graphics.zip) and
  [Git repository](https://git.ece.iastate.edu/gcalhoun/rr_graphics/tree/v2015-02-06).
  (This is a more formal version of a blog post I had written earlier.)
* [Graphing better Impulse Response Functions for discrete-time linear models](dl/calhoun-smooth-irf.pdf)
  (2015-02-22b) with [source code archive](dl/calhoun-smooth-irf.zip) and
  [Git repository](https://git.ece.iastate.edu/gcalhoun/smooth_irf/tree/2015-02-22b)

## Publications
* Hypothesis testing in linear regression when k/n is large. *Journal
  of Econometrics*, 165(2), 2011: 163–174.
  [Link](http://www.econ.iastate.edu/research/working-papers/p12216),
  [R package](dl/ftestLargeK_1.0.tar.gz), and [additional
  files](dl/calhoun-2010-ftest.tar.gz)

<hr />

## Ephemera

<ul>
{% for post in site.categories.notes %}
<li>
{% if post.link %}
<a href="{{ post.link }}">{{ post.title }}</a> (link, {{ post.date | date_to_string }})
{% else %}
<a href="{{ site.url}}{{ post.url }}">{{ post.title }}</a> (blog, {{ post.date | date_to_string }})
{% endif %}
</li>
{% endfor %}
</ul>

* [Miscellaneous notes]({{ site.main }}/blog)
* You can subscribe to the [site’s newsfeed]({{ site.main}}/feed.xml)
  for updates.