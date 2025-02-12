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
                Lorem Ipsum is simply dummy text of the printing and typesetting
                industry. Lorem Ipsum has been the industry's standard dummy text
                ever since the 1500s, when an unknown printer took a galley of type
                and scrambled it to make a type specimen book. It has survived not
                only five centuries, but also the leap into electronic typesetting,
                remaining essentially unchanged. It was popularised in the 1960s
                with the release of Letraset sheets containing Lorem Ipsum passages,
                and more recently with desktop publishing software like Aldus
                PageMaker including versions of Lorem Ipsum.
            </p>
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

