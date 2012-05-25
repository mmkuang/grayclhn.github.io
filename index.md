---
layout: default
title: Gray Calhoun's homepage
---
[CV]: gcalhoun-cv.html

<img src='http://www.gravatar.com/avatar/f3c9878eabc83410b2d9e380cc36dfcf?s=160' 
     style='float:right;margin:0 0 10px 20px;' alt='Profile picture' />
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

* [Refereed publications](/papers/): A list of publications along
  with supplemental appendices and supporting software and other files.

* [Undergraduate teaching](undergraduate.html): I'm still moving
  information here.  There probably isn't a lot right now, but there
  will be links for courses that I am teaching and have taught. I'll
  also put other information that I think will interest undergrads here.

* [Graduate teaching](graduate.html): This section will have links and
  handouts for the graduate courses I teach and will have other
  information that might interest grad students.  Right now it's
  pretty empty, though.

* [External presentations](/talks/): A list of external presentations 
  that I've given or that are scheduled, as well as slides and
  handouts for the talks.

* [Miscellaneous and informal documents](/essays/): Assorted
  short and under-edited essays.  Some might call them blog posts, but
  that would overstate how frequently I write them.

You can reach me by email at <gcalhoun@iastate.edu>.  My office is
Heady Hall, room 467, (515) 294-6271.  If you find any errors on my
website, please let me know.

Current working papers
----------------------

{% for doc in site.categories.working %}
* {{ doc.title }}. {{ doc.info }}  
  {{ doc.link }}  
  {{ doc.notes }}  
  {{ doc.content }}

{% endfor %}

Software development
--------------------

{% for doc in site.categories.software %}
* {{ doc.title }}.  {{ doc.info }}  
  {{ doc.link }}  
  {{ doc.notes }}  
  {{ doc.content }}

{% endfor %}

<!--  LocalWords:  Calhoun's gcalhoun html UC webpage GitHub Econom AIC Goyal
 -->
<!--  LocalWords:  Welch's Finan de Jong Jong's CLT overfit Diebold LM cv endif
 -->
<!--  LocalWords:  McCracken's endfor
 -->
