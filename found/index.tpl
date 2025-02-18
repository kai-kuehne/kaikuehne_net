<html>
<head>
    <meta charset="utf-8">
    <title>Found; Not Lost</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="alternate" type="application/atom+xml" title="Atom Feed" href="/found/feed.xml">
    <link rel="stylesheet" href="/raster2.css">
    <link rel="stylesheet" href="/style.css">
</head>
<body>
    <r-grid columns="9">
        <r-cell span="1-3">
            <h1>Found;<br>Not Lost</h1>
            <br>
            <p>
                Welcome to <b><i>Found; Not Lost</i></b> where I share links to cool things I find online.
                What's cool? Programming, Design, Game Development, Music Production and everything in between.
                There will probably be an occasional random link as well, and maybe even artwork or a super insightful
                quote.
            </p>
            <p><a href="/found/feed.xml">There's an RSS feed variant of this page.</a></p>
        </r-cell>
        <r-cell span="4-8">
        {{- range .}}
            <section id="{{.Date}}">
                <h2>{{.Date}}</h2>
                {{- range .Entries}}
                    <p><a href="{{.Link}}">{{.Title}}</a> &horbar; {{.Description}}</p>
                {{- end}}
            </section>
        {{- end}}
        </r-cell>
    </r-grid>
</body>
</html>

