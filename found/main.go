package main

import (
	"bufio"
	"io"
	"os"
	"regexp"
	"strings"
	"text/template"
	"time"
)

func main() {
	sections, err := parseFile("found.txt")
	if err != nil {
		panic(err)
	}

	updated := time.Now().UTC().Format(time.RFC3339)
	feed := Feed{updated, sections}

	renderFile("index.tpl", "index.html", sections)
	renderFile("feed.tpl", "feed.xml", feed)
}

type Feed struct {
	Updated  string
	Sections []Section
}

type Section struct {
	Date    string
	Entries []Entry
}

type Entry struct {
	Title       string
	Description string
	Link        string
}

func renderFile(templatePath, outPath string, data any) {
	// Open Template
	r, err := os.Open(templatePath)
	if err != nil {
		panic(err)
	}
	templateContent, err := io.ReadAll(r)
	if err != nil {
		panic(err)
	}
	tmpl, err := template.New("").Parse(string(templateContent))
	if err != nil {
		panic(err)
	}

	// Write outfile
	html, err := os.Create(outPath)
	if err != nil {
		panic(err)
	}
	defer html.Close()
	err = tmpl.Execute(html, data)
	if err != nil {
		panic(err)
	}
}

func parseFile(filename string) ([]Section, error) {
	file, err := os.Open(filename)
	if err != nil {
		return nil, err
	}
	defer file.Close()

	var sections []Section
	var currentSection Section
	var currentEntry Entry
	var entryLines []string

	scanner := bufio.NewScanner(file)
	dateRegex := regexp.MustCompile(`^\d{4}-\d{2}-\d{2}:$`)
	urlRegex := regexp.MustCompile(`^https?://`)

	for scanner.Scan() {
		line := scanner.Text()

		if dateRegex.MatchString(line) {
			if currentSection.Date != "" {
				if len(entryLines) > 0 {
					currentEntry = parseEntry(entryLines, urlRegex)
					currentSection.Entries = append(currentSection.Entries, currentEntry)
				}
				sections = append(sections, currentSection)
			}

			currentSection = Section{
				Date:    strings.TrimSuffix(line, ":"),
				Entries: []Entry{},
			}
			entryLines = nil

		} else if strings.TrimSpace(line) == "" {
			if len(entryLines) > 0 {
				currentEntry = parseEntry(entryLines, urlRegex)
				currentSection.Entries = append(currentSection.Entries, currentEntry)
				entryLines = nil
			}
		} else {
			entryLines = append(entryLines, line)
		}
	}

	if len(entryLines) > 0 {
		currentEntry = parseEntry(entryLines, urlRegex)
		currentSection.Entries = append(currentSection.Entries, currentEntry)
	}
	if currentSection.Date != "" {
		sections = append(sections, currentSection)
	}

	if err := scanner.Err(); err != nil {
		return nil, err
	}

	return sections, nil
}

func parseEntry(lines []string, urlRegex *regexp.Regexp) Entry {
	entry := Entry{}

	if len(lines) > 0 {
		entry.Title = lines[0]
	}

	for _, line := range lines[1:] {
		if urlRegex.MatchString(line) {
			entry.Link = line
		} else {
			if entry.Description != "" {
				entry.Description += " "
			}
			entry.Description += line
		}
	}

	return entry
}
