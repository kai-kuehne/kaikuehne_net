---
title: Kai Kühne
layout: index.njk
---

I’m a software engineer from Berlin. I build the infrastructure behind creative software — the platforms, pipelines, and tooling that sit between creative professionals and what they make. I’ve done this at [SoundCloud](https://soundcloud.com) and [Native Instruments](https://www.native-instruments.com), and independently for game engines and audio production tools.

I care as much about how I work with people as what I build. The best technical decision is worthless if you can’t bring a team along with you.

If you’d like to work together, email me at [mail@kaikuehne.net](mailto:mail@kaikuehne.net).

## Selected work {.section-label}

- Built a high-performance [FMOD-Godot audio plugin](/projects/rhythmandgoose/) on its own clock, solving a timing problem existing solutions couldn’t handle
- Designed and maintained SoundCloud’s tiered content fingerprinting pipeline, optimizing for cost across progressively more expensive identification services
- Owned the backend platform powering Native Instruments’ desktop client, product activation, and software delivery
- Wrote the operational runbooks used company-wide by SoundCloud’s on-call engineers

## Now {.section-label}

Working on [Rhythm and Goose](https://rhythmandgoose.com) with [Emily Harrison](https://emilyaudio.com/) — a rhythm game approaching a Steam demo. Also continuing work on [Chordel](/chordel/), a synthesizer and training tool for the Ableton Push 2.

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
