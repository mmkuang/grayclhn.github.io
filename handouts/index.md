---
layout: display
title: Handouts and other documents
---

Many of the documents linked to on this page are available under the
<a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/"> 
Creative Commons Attribution-ShareAlike 3.0 Unported License</a>, denoted 
\([CC][]\). This means that you can copy, edit, and redistribute the document 
as long as you credit me for my contribution and make your version available
under the same license if you redistribute it.

{% for doc in site.categories.handouts %}

[{{ doc.title }}]({{ doc.url }}) {% unless doc.nocc %}\([CC][]\){% endunless %}
--------------------------------------------------------------------------
{{ doc.content | truncatewords: 100 | strip_html }}  
Tags: {{ doc.tags | array_to_sentence_string }}  
Last edited: {{ doc.date | date_to_string }}

{% endfor %}

[CC]: http://creativecommons.org/licenses/by-sa/3.0/
