<?xml version="1.0" encoding="utf-8"?>
<feed xmlns="http://www.w3.org/2005/Atom">
    <title>Found; Not Lost</title>
    <subtitle>Lorem Ipsum is simply dummy text of the printing and typesetting industry...</subtitle>
    <link href="https://kaikuehne.net/found/feed.xml" rel="self"/>
    <link href="https://kaikuehne.net/found/"/>
    <id>https://kaikuehne.net/found/</id>
    <updated>{{.Updated}}</updated>
    <author>
        <name>Kai Kühne</name>
    </author>

    {{- range .Sections}}
    <entry>
        <title>{{ .Date }}</title>
        <link href="https://kaikuehne.net/found#{{ .Date }}"/>
        <id>https://kaikuehne.net/found/#{{ .Date }}</id>
        <content type="html">
            <![CDATA[
            <ul>
            {{- range .Entries }}
                <li><a href="{{ .Link }}">{{ .Title }}</a>: {{ .Description }}</li>
            {{- end }}
            </ul>
            ]]>
        </content>
    </entry>
    {{- end }}
</feed>
