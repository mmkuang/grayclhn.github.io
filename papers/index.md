---
layout: default
title: Peer-reviewed publications
---

{% for doc in site.posts %} {% if doc.category == 'papers' %}
1. {{ doc.title }}. {{ doc.info }}  
    <{{ doc.link }}>

{% endif %} {% endfor %}

