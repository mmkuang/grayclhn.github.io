---
title: "Gray Calhoun's website"
layout: empty
---

<div class="row-fluid">
  <div class="span12">
    <div class="page-header" align = "center">
      <h1>gray.clhn.co: {{ page.title }}</h1>
    </div>
</div></div>

<div class="row-fluid">
  <div class="span3"><h1>Information</h1><br> <p>This is Gray Calhoun's
    homepage.  I'm an Assistant Professor in the Economics Department
    at Iowa State.  I work on Econometric theory, especially time
    series and applications to forecasting and forecast evaluation.  I
    graduated with a PhD from UC San Diego in 2009, where I worked
    with Graham Elliott and Allan Timmermann.</p>
    <hr>
    <ul class="unstyled">
      <li><a href="/gcalhoun-cv.html">Curriculum Vitae</a></li>
      <li>Contact Information<ul>
	  <li>467 Heady Hall (office at Iowa State)</li>
	  <li>(515) 294-6271 (office phone)</li>
	  <li><a href="mailto:{% include univ_email %}">{% include univ_email %}</a> (unviersity email)</li>
	  <li><a href="mailto:{% include main_email %}">{% include main_email %}</a> (all other email)</li>
	  <li>I do not have office hours in the Summer, so please email me
	    to set up meetings. I'll start holding regular office hours when
	    the 2012 Fall semester starts.</li>
      </ul></li>
      <li><a href="/talks/">Presentations</a> with slides</li>
      <li><a href="/updates.html">Site updates and news</a> 
	(<a href="/rss.xml">RSS/XML</a>)</li>
      <li><a href="/info.html">More information</a> and links</li>
      <li>Jump to <a href="#Teaching">Teaching</a>, <a href="#Research">Research</a>, or <a href="#Software">Software</a> (for mobile)</li>
    </ul>
  </div>

  <a name="Teaching"> </a>
  <div class="span3"><h1>Teaching</h1><br>
    <ul class="unstyled">
      <li><strong>PhD Econometrics 1 (Econ 671)</strong>
	<p>I teach PhD Econometrics 1 (Economics 671) in the Fall. Material for the 2012
	  Fall semester will be available soon.</p></li>
      
      <li><strong>Principles of Macroeconomics (Econ 102)</strong>
	<p>I typically teach Principles of Macroeconomics each Spring and am
	  scheduled to teach it again in Spring, 2013. I’ll put relevant
	  material here as we get closer.</p></li>
	
      <li><strong>PhD Macroeconometrics (Econ 674)</strong>
	<p>Helle Bunzel and I will teach PhD Macroeconometrics (Economics 674) in
	  Spring, 2013. I’ll post information and material for that class as I
	  develop it.</p></li>

      <li><strong>Courses before Fall, 2012</strong> are not online. Please
	contact me if you need material.</li>
  </ul></div>

  <a name="Research"> </a>
  <div class="span3">
    <h1>Research</h1><br>
      <p> <strong><a href="/papers/">List of
	  publications</a></strong> with source code.</p>
    <hr>
    <h2>Current working papers:</h2>
    <ul class="unstyled">
      {% for doc in site.categories.working %}
      <li><p> <strong>{{ doc.title }}</strong>. {{ doc.info }}
	  <ul><li><a href="{{ doc.url }}">More details</a></li>
	    <li><a href="{{ doc.link }}">Download the paper</a> 
	      (external link)</li></ul>
      </p></li>
      {% endfor %}
    </ul>
    <hr>
      <p>Citation counts and other information at 
	<a href="http://ideas.repec.org/f/pca491.html">
	  <strong>IDEAS</strong></a> and 
	<a href="http://scholar.google.com/citations?hl=en&user=OS8d9ycAAAAJ">
	  <strong>Google Scholar</strong></a></p>

  </div>

  <a name="Software"> </a>
  <div class="span3"><h1>Software</h1><br>
    <p>Only stand-alone software packages are listed here.  Follow
      this link for <a href="/papers/">source code for my publications</a>
      and go to the details of each working paper for that paper's source
      code.</p>

    <ul class="unstyled">{% for doc in site.categories.software %}
      <li><p> <strong>{{ doc.title }}</strong>.  {{ doc.info }}  
	  <ul>
	    <li><a href="{{ doc.url }}">Details</a></li>
	    <li><a href="{{ doc.link }}">Download the source code</a> 
	      (at Github)</li>
	  </ul>
      </p></li>
      
      {% endfor %}
    </ul>
  </div>

</div>
