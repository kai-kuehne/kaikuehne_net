---
title: Writing
layout: index.njk
permalink: /writing/
---

<ul class="article-list">
{%- for article in collections.articles %}
    <li>
        <a href="{{ article.url }}">{{ article.data.title }}</a>
        <time class="date" datetime="{{ article.data.updated | date:'%Y-%m-%d' }}">{{ article.data.updated | date:"%b %Y" }}</time>
    </li>
{%- endfor %}
</ul>
