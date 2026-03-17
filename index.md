---
title: Kai Kühne
layout: index.njk
---

I'm a software engineer from Berlin. I tend to work at the edges of things — between systems, between teams, between disciplines. What usually draws me to a problem is friction that shouldn't be there: a gap between a tool and the workflow it's supposed to serve, a missing piece that forces workarounds.

I've worked on backend infrastructure at [SoundCloud](https://soundcloud.com/) and [Native Instruments](https://www.native-instruments.com/). These days I'm independent, spending most of my time on game development and audio tooling.

## Now {.section-label}

Working on [Rhythm and Goose](https://rhythmandgoose.com) with [Emily Harrison](https://emilyaudio.com/) — a rhythm game approaching a Steam demo. Also continuing work on [Chordel](/chordel/), a synthesizer and training tool for the Ableton Push 2. Based in Berlin and open to backend engineering work.

## Writing {.section-label}

<ul class="article-list">
{%- for article in collections.articles | slice(0, 3) %}
    <li>
        <a href="{{ article.url }}">{{ article.data.title }}</a>
        <time class="date" datetime="{{ article.data.updated | date:'%Y-%m-%d' }}">{{ article.data.updated | date:"%b %Y" }}</time>
    </li>
{%- endfor %}
</ul>
<a class="see-all" href="/writing/">All writing →</a>

## Projects {.section-label}

<div class="project-grid">
{%- for project in collections.projects %}
<article class="card">
    <header>
        {%- if project.data.homepage %}
        <h3><a href="{{ project.data.homepage }}">{{ project.data.title }}</a></h3>
        {%- else %}
        <h3><a href="{{ project.url }}">{{ project.data.title }}</a></h3>
        {%- endif %}
    </header>
    <p>{{ project.data.description }}</p>
</article>
{%- endfor %}
</div>
<a class="see-all" href="/projects/">All projects →</a>
