---
layout: default
title: Website updates
---

<ul class="unstyled">
{% for post in site.posts %}
<li><p><a href="{{ post.url }}"><strong>{{ post.title }}</strong></a> {{ post.date | date_to_string}}<br>
{% if post.categories %}Categories: {{ post.categories | array_to_sentence_string }}<br>{% endif %}
{% if post.tags %}Tags: {{ post.tags | array_to_sentence_string }}{% endif %}<br>
{{ post.content | truncatewords: 50 | strip_html}}
</p></li>

{% endfor %}

</ul>