---
layout: default
title: External presentations
---

{% for doc in site.categories.talks %}
1. {{ doc.title }}. {{ doc.info }}  
    {% if doc.link %}<{{ doc.link }}>  {% endif %}
    {{ doc.content }}

{% endfor %}

