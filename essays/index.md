---
layout: display
title: Archived informal and short documents
---
All of the documents linked to on this page are available under the 
<a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/">
  Creative Commons Attribution-ShareAlike 3.0 Unported License</a>.

{% for doc in site.categories.essays %}
* [{{ doc.title }}]({{ doc.url }}): {% if doc.abstract %} {{ doc.abstract }} {% endif %} ({{ doc.date | date_to_string }})

{% endfor %}

		
	
	
