package main

import (
	"bufio"
	"io"
	"os"
	"regexp"
	"strings"
	"text/template"
)

func main() {
	// 1) Read index.tpl.
	r, err := os.Open("index.tpl")
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

	// 2) Read found.txt.
	var sections []Section
	sections, err = parseFile("found.txt")
	if err != nil {
		panic(err)
	}

	// 3) Write index.html.
	err = tmpl.Execute(os.Stdout, sections)
	if err != nil {
		panic(err)
	}
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
	urlRegex := regexp.MustCompile(`^https?://`) // Match http or https links

	for scanner.Scan() {
		line := scanner.Text()

		if dateRegex.MatchString(line) {
			// Save previous section if it exists
			if currentSection.Date != "" {
				if len(entryLines) > 0 {
					currentEntry = parseEntry(entryLines, urlRegex)
					currentSection.Entries = append(currentSection.Entries, currentEntry)
				}
				sections = append(sections, currentSection)
			}

			// Start new section
			currentSection = Section{
				Date:    strings.TrimSuffix(line, ":"),
				Entries: []Entry{},
			}
			entryLines = nil // Reset entry lines for new section

		} else if strings.TrimSpace(line) == "" {
			// Empty line indicates end of an entry
			if len(entryLines) > 0 {
				currentEntry = parseEntry(entryLines, urlRegex)
				currentSection.Entries = append(currentSection.Entries, currentEntry)
				entryLines = nil // Reset for next entry
			}
		} else {
			// Collect lines for the current entry
			entryLines = append(entryLines, line)
		}
	}

	// Add the last section and entry if any
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
