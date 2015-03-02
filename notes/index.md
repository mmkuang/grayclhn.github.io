---
title: Gray Calhoun’s academic homepage — blog
layout: front
---

<ul>
{% for post in site.posts %}
<li>
{% if post.link %}
<a href="{{ post.link }}">{{ post.title }}</a> (link, {{ post.date | date_to_string }})
{% else %}
<a href="{{ site.url}}{{ post.url }}">{{ post.title }}</a> (blog, {{ post.date | date_to_string }})
{% endif %}
</li>
{% endfor %}
</ul>
