---
layout: default
title: Archived informal and short documents/essays
---

{% for doc in site.categories.essays %}
* [{{ doc.title }}]({{ doc.url }}): {% if doc.abstract %} {{ doc.abstract }} {% endif %} ({{ doc.date | date_to_string }})

{% endfor %}