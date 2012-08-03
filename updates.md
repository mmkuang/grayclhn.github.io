---
layout: display
title: Website updates
---

I'm going to turn this into a microblog soon.  For now, it's just a
list of material on the site.

{% for post in site.posts %}
<hr>
<a href="{{ post.url }}">{{ post.title }}</a> {{ post.date | date_to_string}}  
Categories: {{ post.categories | array_to_sentence_string }}  
Tags: {{ post.tags | array_to_sentence_string }}  

{{ post.content | truncatewords: 30 | strip_html}}

{% endfor %}
