---
title: Kai Kühne
layout: index.njk
---

I’m a software engineer in Berlin. I build the infrastructure behind creative
software: the platforms, pipelines, and tooling between creative professionals
and what they make. I’ve done this at [SoundCloud](https://soundcloud.com) and
[Native Instruments](https://www.native-instruments.com), and independently for
games and audio.
{.lead}

If you’d like to work together, email me at
[mail@kaikuehne.net](mailto:mail@kaikuehne.net) or read my [CV](/cv.pdf).

## Now {.section-label}

Working on [Rhythm and Goose](https://rhythmandgoose.com) with [Emily
Bryner](https://emilyaudio.com/), a rhythm game approaching a Steam demo.
Also continuing work on [Chordel](/chordel/), a synthesizer and training tool
for the Ableton Push 2.

## Writing {.section-label}

<ul class="article-list" role="list">
{%- for article in collections.articles | slice(0, 3) %}
    <li>
        <a href="{{ article.url }}">{{ article.data.title }}</a>
        <time class="date" datetime="{{ article.data.updated | date:'%Y-%m-%d' }}">{{ article.data.updated | date:"%b %Y" }}</time>
    </li>
{%- endfor %}
</ul>
<a class="see-all" href="/writing/">All writing <span aria-hidden="true">→</span></a>

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
<a class="see-all" href="/projects/">All projects <span aria-hidden="true">→</span></a>
