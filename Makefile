# https://www.11ty.dev/docs/

.PHONY: setup
setup:
	npm init -y
	npm install @11ty/eleventy

.PHONY: eleventy
eleventy:
	npx @11ty/eleventy --serve

.PHONY: build
build: ## Build the Eleventy site
	npx @11ty/eleventy

.PHONY: test
test: build ## Build and run pa11y WCAG2AA checks on key pages
	npx pa11y --standard WCAG2AA _site/index.html
	npx pa11y --standard WCAG2AA _site/writing/index.html
	npx pa11y --standard WCAG2AA _site/projects/index.html
	npx pa11y --standard WCAG2AA _site/found/index.html
	npx pa11y --standard WCAG2AA _site/chordel/index.html


