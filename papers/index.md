---
layout: default
title: Peer-reviewed publications
---

{% for doc in site.categories.papers %}
1. {{ doc.title }}. {{ doc.info }}  
    <{{ doc.link }}>

{% endfor %}

