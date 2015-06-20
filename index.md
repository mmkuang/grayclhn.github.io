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

**Links:**
[Curriculum vitae](dl/calhoun-cv.pdf)
(or as [odt](dl/calhoun-cv.odt)),
[IDEAS](http://ideas.repec.org/f/pca491.html),
[Google Scholar](http://scholar.google.com/citations?hl=en&user=OS8d9ycAAAAJ),
[LinkedIn](https://linkedin.com/in/grayclhn),
[GitHub](https://github.com/grayclhn),
and [Twitter](https://twitter.com/grayclhn).
The CV is based on a template from
[lifeclever.com](http://www.lifeclever.com/give-your-resume-a-face-lift/).
Also, let me know if you want the password to my [family
blog](http://clhn.org). (Don’t feel left out, it’s mostly
pictures of my kids.)

This website was last updated on 2015-05-22.

<hr />

<a id="teaching">
Teaching
--------

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

<a id="students">
Current and former PhD students
-------------------------------

[Anwen Yin](http://anwenyin.weebly.com). 2015 PhD in Economics, [Helle
Bunzel](https://www.econ.iastate.edu/people/faculty/bunzel-helle) and
I were co-advisors. Starting in August as an Assistant Professor of
Economics at Texas A&M International University.

[Matt Simpson](http://www.themattsimpson.com/). 2015 PhD in Economics
and Statitstics, [Jarad Niemi](http://www.jarad.me/) and I were
co-advisors. Starting in August as a postdoc in Statistics at
University of Missouri.

<hr />

<a id="workingpapers">
Working papers
--------------

[Out-of-sample comparisons of overfit models](http://www.econ.iastate.edu/research/working-papers/p12462)
(2014-03-30, revise and resubmit at *Quantitative Economics*) with
[supplemental appendix](dl/calhoun_oosoverfit_appendix_v2014-03-30.pdf) and
[source code archive](dl/calhoun_oosoverfit_v2014-09-22.zip).
<!-- [Private git repository](https://git.ece.iastate.edu/gcalhoun/oos-overfit) -->

[Block bootstrap consistency under weak assumptions](http://www.econ.iastate.edu/research/working-papers/p14313)
(2014-10-06, revise and resubmit at *Econometric Theory*) with
[supplemental appendix](dl/calhoun_bootstrap_appendix_v2014-10-06.pdf).
<!-- [Private git repository](https://git.ece.iastate.edu/gcalhoun/statboot-paper) -->

[Improved stepdown methods for asymptotic control of generalized error rates](dl/calhoun_stepdown_v2015-04-27.pdf)
(2015-04-27, revise and resubmit at *Journal of Econometrics*) with
[source code archive](dl/calhoun_stepdown_v2015-04-27.zip).
<!-- [Private git repository](https://git.ece.iastate.edu/gcalhoun/stepdown-paper/) -->

[An asymptotically normal out-of-sample test based on mixed estimation windows](dl/calhoun_mixedwindow_v2015-01-09.pdf)
(2015-01-09, revise and resubmit at *Econometrica*) with
[appendix](dl/calhoun_mixedwindow_appendix_v2015-01-09.pdf) and
[source code archive](dl/calhoun_mixedwindow_v2015-04-23.zip).
<!-- [Private git repository](https://git.ece.iastate.edu/gcalhoun/mixedwindow) -->

[Causality in the Reinhart-Rogoff dataset, the plots thicken](dl/calhoun_rrgraphics_v2015-06-01.pdf)
(2015-06-01) with
[source code archive](dl/calhoun_rrgraphics_v2015-06-01.zip).
(This is a more formal version of a blog post I had written earlier.)
<!-- [Private git repository](https://git.ece.iastate.edu/gcalhoun/rr_graphics) -->

[Graphing better Impulse Response Functions for discrete-time linear models](dl/calhounpruitt_smoothirf_v2015-03-27.pdf),
joint with [Seth Pruitt](https://sites.google.com/site/sethpruittnet/)
(2015-03-27) with [source code archive](dl/calhounpruitt_smoothirf_v2015-03-27.zip).
<!-- [Private git repository](https://git.ece.iastate.edu/gcalhoun/smooth_irf) -->

[A simple block bootstrap for asymptotically normal out-of-sample test statistics](dl/calhoun_oosbootstrap_v2015-04-21.pdf)
(2015-04-21) [source code archive](dl/calhoun_oosbootstrap_v2015-05-08.zip).
<!-- [Private git repository](https://git.ece.iastate.edu/gcalhoun/oosbootstrap) -->

<a id="publications">
Publications
------------

Hypothesis testing in linear regression when k/n is large. *Journal
of Econometrics*, 165(2), 2011: 163–174.
[Link](http://www.econ.iastate.edu/research/working-papers/p12216),
[published version](http://www.sciencedirect.com/science/article/pii/S0304407611001448),
[R package](dl/ftestLargeK_1.0.tar.gz), and
[additional files](dl/calhoun_ftest_2010.tar.gz)

<hr />

<a id="ephemera">
Ephemera
--------

<ul>
{% for post in site.categories.blog %}
<li>
{% if post.link %}
<a href="{{ post.link }}">{{ post.title }}</a> (link, {{ post.date | date_to_string }})
{% else %}
<a href="{{ post.url }}">{{ post.title }}</a> (blog, {{ post.date | date_to_string }})
{% endif %}
</li>
{% endfor %}
</ul>

You can subscribe to the [site’s newsfeed]({{ site.main}}/feed.xml)
for updates.
