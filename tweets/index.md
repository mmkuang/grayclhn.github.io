---
layout: display
title: Microblog and site updates
---

This is not meant to be a comprehensive list of everything on the web,
everything I think is important, or even everything that Economics
students might or should find interesting. It's just a list of some
stuff. Let me know if there's anything else you think I'd like.

I'll also use this feed to announce papers, upcoming presentations, etc.
The feed is also available at <http://gray.clhn.co/rss.xml>.

{% for post in site.posts %}
<hr>
{% if post.categories contains "tweets" %}
  {{ post.content }} 
  {{ post.date | date_to_string}}, [permalink]({{ post.url }}),
  tags: {{ post.tags | array_to_sentence_string }} 
{% else %}
  [{{ post.title }}]({{ post.url }})  
  Categories: {{ post.categories | array_to_sentence_string }}  
  Tags: {{ post.tags | array_to_sentence_string }}  

  {{ post.content | truncatewords: 30 | strip_html}}
{% endif %}


{% endfor %}



