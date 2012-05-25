---
layout: default
title: Peer-reviewed publications
---

{% for doc in site.categories.papers %}
1. [{{ doc.title }}]({{ doc.url }}). {{ doc.info }}  
   <{{ doc.link }}>
   {{ doc.notes }}

{% endfor %}

