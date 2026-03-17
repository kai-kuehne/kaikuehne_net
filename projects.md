---
title: Projects
layout: index.njk
permalink: /projects/
---

<div class="project-grid">
{%- for project in collections.projects %}
<article class="card">
    <header>
        {%- if project.data.homepage %}
        <h2><a href="{{ project.data.homepage }}">{{ project.data.title }}</a></h2>
        {%- else %}
        <h2><a href="{{ project.url }}">{{ project.data.title }}</a></h2>
        {%- endif %}
    </header>
    <p>{{ project.data.description }}</p>
</article>
{%- endfor %}
</div>
