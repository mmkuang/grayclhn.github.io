---
layout: display
title: Site feed and announcements
---

This feed is used to announce papers, upcoming presentations, etc.
and is available at <http://gray.clhn.co/rss.xml>. It's also a
microblog of short things I find interesting. This is not meant to be
a comprehensive list of everything on the web, everything I think is
important, or even everything that Economics students might or should
find interesting. It's just a list of some stuff. 

Let me know if there's anything else you think I'd like.

{% for post in site.posts %}
<hr>
{% if post.categories contains "clips" %}
  {{ post.content }} 
{% else %}
  [{{ post.title }}]({{ post.url }})  
  Categories: {{ post.categories | array_to_sentence_string }}  

  {{ post.content | truncatewords: 30 | strip_html}}
{% endif %}
{{ post.date | date_to_string}} // 
tags: {{ post.tags | array_to_sentence_string }} // [permalink]({{ post.url }})


{% endfor %}



