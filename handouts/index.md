---
layout: display
title: Handouts and short essays
---
All of the documents linked to on this page are available under the 
<a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/">
  Creative Commons Attribution-ShareAlike 3.0 Unported License</a>.

{% for doc in site.categories.handouts %}

[{{ doc.title }}]({{ doc.url }})
--------------------------------
{{ doc.content | truncatewords: 100 | strip_html }}  
Tags: {{ doc.tags | array_to_sentence_string }}  
Last edited: {{ doc.date | date_to_string }}

{% endfor %}

		
	
	
