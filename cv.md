---
layout: handout
title: "Curriculum Vitae"
subtitle: Gray Calhoun, Assistant Professor of Economics, Iowa State University
nocc: true
permalink: /cv/index.html
---

Contact Information
-------------------

* Office: 467 Heady Hall, Iowa State University
* Phone: (515) 294-6271
* Email: <gcalhoun@iastate.edu>
* Web: <http://gray.clhn.co>

Academic positions
------------------

* 2009-present: Assistant Professor of Economics at Iowa State
  University.

Education
---------

* PhD in Economics from UC San Diego, 2003-2009  
  Thesis title: *Limit theory for overfit models*  
  Advisors: Graham Elliott and Allan Timmermann

* MS in Statistics from UC San Diego, 2003-2006

* BA in Mathematics from Tufts University, 1997-2001

Research interests
------------------

Econometric Theory, Forecasting and Time Series Econometrics, and
Applied Macroeconomics

Grants and awards
-----------------

* Iowa State University Strategic Initiative, Graphical Processing
  Units (GPU) for Parallel Computing, with Helle Bunzel, Jarad Niemi,
  and Mervyn Marasinghe, 2012. ($87,727.39)

* Walter P. Heller Award for Outstanding Third-Year Paper, UCSD
  Economics Department, 2006

<a name="papers"> </a>
Publications
------------

{% for doc in site.categories.research %} {% if doc.tags contains 'paper' %}
1. [{{ doc.title }}]({{ doc.url }}). {{ doc.info }}  
    <{{ doc.link }}>

{% endif %}{% endfor %}

Working papers
--------------

{% for doc in site.categories.research %} {% if doc.tags contains 'working' %}
1. [{{ doc.title }}]({{ doc.url }}). {{ doc.info }}  
    <{{ doc.link }}>

{% endif %}{% endfor %}

Other research in progress
--------------------------

1. Forecasting with STAR models, 2012 (joint with Graham Elliott).

1. Out-of-sample comparisons under instability, 2012 (joint with Helle Bunzel).

1. A bootstrap procedure for real-time out-of-sample comparisons, 2013
   (joint with Todd Clark and Michael McCracken).

Software development
--------------------

{% for doc in site.categories.research %} {% if doc.tags contains 'software' %}
1. [{{ doc.title }}]({{ doc.url }}).  {{ doc.info }}  
   <{{ doc.link }}>

{% endif %}{% endfor %}

External presentations
----------------------

{% for doc in site.categories.research %} {% if doc.tags contains 'talk' %}
* [{{ doc.info }}]({{ doc.url }}).  <i>{{ doc.title }}</i>
{% endif %} {% endfor %}


Teaching
--------

### Iowa State University
* PhD Macroeconometrics (Econ 674), Spring 2013
* PhD Econometrics 1 (Econ 671), Fall 2009-2012
* Principles of Macroeconomics (Econ 102), Spring 2010-2013

### UC San Diego  
* Undergraduate Econometrics 3 (Econ 120 C), Spring 2009

Graduate student committees
---------------------------
### Advisor
* [Anwen Yin](https://sites.google.com/site/anweny/) (co-advisor with Helle Bunzel), current student.

### Committee member
* [Xiying Liu](http://www.econ.iastate.edu/people/graduate-students/liu-xiying) (Economics PhD), current student
* [Jeremiah Richey](http://sites.google.com/a/iastate.edu/jeremiah-richey) (Economics PhD), graduated 2012
* Ozgu Serttas (Economics PhD), graduated 2010
* [Yihui Xie](http://yihui.name/) (Statistics PhD), current student
* [Matthew Clancy](http://www.econ.iastate.edu/people/graduate-students/clancy-matthew) (Economics PhD), current student
* [Deung Yong Heo](http://www.econ.iastate.edu/people/graduate-students/heo-deung-yong) (Economics PhD), current student

Professional activities
-----------------------
### Journal referee
* *American Journal of Agricultural Economics* (2011)
* *Communications in Statistics—Theory and Methods* (2012)
* *Computational Statistics and Data Analysis* (2012)
* *Econometrica* (2012)
* *Handbook of Economic Forecasting* (2011)
* *International Journal of Forecasting* (2007, 2009, 2010, 2012)
* *Journal of Business & Economic Statistics* (2011, 2012)
* *Manchester School* (2012)

### Professional membership
* American Economic Association
* Econometric Society
* Institute of Mathematical Statistics
* American Statistical Association
* Midwest Economics Association

### Departmental service
* Computer support staff hiring committee, 2012 & 2013
* Graduate Student Admissions Committee, 2009-present
* Computer Committee, 2009-present

<!--  LocalWords:  UC overfit Advisors GPU Helle Bunzel Jarad Niemi Mervyn UCSD
 -->
<!--  LocalWords:  Marasinghe NBER dbframe SQL oosanalysis Advisor Anwen Xiying
 -->
<!--  LocalWords:  advisor Liu Richey Ozgu Serttas Yihui Xie Econometrica endif
 -->
<!--  LocalWords:  endfor
 -->
