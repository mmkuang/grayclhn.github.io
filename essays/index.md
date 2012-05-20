---
layout: default
title: Archived informal and short documents/essays
---

{% for doc in site.posts %} {% if doc.category == "essays" %}
* [{{ doc.title }}]({{ doc.url }}): {% if doc.abstract %} {{ doc.abstract }} {% endif %}

{% endif %} {% endfor %}