---
layout: display
title: "Archived posts and handouts"
---

<dl class="dl-horizontal">
{% for doc in site.categories.blog %}
<dt>{{ doc.date | date: "%d %b %Y" }}</dt>
<dd><p>
	<a href="{{ doc.url }}">{{ doc.title | xml_escape }}</a>
	{% if doc.tags contains "handout" %}
	<b> (handout)</b>
	{% endif %}
	</p></dd>
{% endfor %}
</dl>
