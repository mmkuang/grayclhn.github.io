---
layout: display
title: "Misc. notes and short documents"
---

{% for doc in site.categories.notes %}
* [{{ doc.title }}]({{ doc.url }}) ({{ doc.date | date_to_long_string }})

{% endfor %}

<!--  LocalWords:  UC overfit Advisors GPU Helle Bunzel Jarad Niemi Mervyn UCSD
 -->
<!--  LocalWords:  Marasinghe NBER dbframe SQL oosanalysis Advisor Anwen Xiying
 -->
<!--  LocalWords:  advisor Liu Richey Ozgu Serttas Yihui Xie Econometrica endif
 -->
<!--  LocalWords:  endfor
 -->
