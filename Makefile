# https://www.11ty.dev/docs/

CHROME_PATH := $(shell node scripts/chrome-path.cjs 2>/dev/null)
export CHROME_PATH

SITE_URL ?= http://localhost:8080
PAGES := / /writing/ /projects/ /found/ /chordel/

.DEFAULT_GOAL := help

.PHONY: help
help: ## Show available targets
	@awk 'BEGIN {FS = ":.*##"} /^[a-zA-Z0-9_-]+:.*##/ { printf "  %-15s %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

.PHONY: setup
setup: ## Install npm dependencies
	npm install

.PHONY: eleventy
eleventy: ## Serve the site locally with live reload
	npx @11ty/eleventy --serve

.PHONY: build
build: ## Build the Eleventy site
	npx @11ty/eleventy

$(CHROME_PATH):
	npx puppeteer browsers install chrome

.PHONY: check-server
check-server: ## Verify a local server is running at $(SITE_URL); run 'make eleventy' in another shell if not
	@curl --silent --fail $(SITE_URL) > /dev/null 2>&1 || ( \
	    echo "Error: no server at $(SITE_URL). Run 'make eleventy' in another shell." >&2; \
	    exit 1; \
	)

.PHONY: pa11y
pa11y: $(CHROME_PATH) check-server ## Run pa11y WCAG2AA checks against $(SITE_URL)
	@for page in $(PAGES); do \
	    npx pa11y --standard WCAG2AA $(SITE_URL)$$page; \
	done

.PHONY: pa11y-json
pa11y-json: $(CHROME_PATH) check-server ## Run pa11y WCAG2AA checks, write JSON to reports/
	mkdir -p reports
	rm -f reports/pa11y-*.json
	@for page in $(PAGES); do \
	    slug=$$(echo "$$page" | tr -d '/'); slug=$${slug:-index}; \
	    npx pa11y --reporter json --standard WCAG2AA $(SITE_URL)$$page > reports/pa11y-$$slug.json; \
	done

.PHONY: lighthouse
lighthouse: $(CHROME_PATH) check-server ## Run Lighthouse audits against $(SITE_URL)
	mkdir -p reports
	rm -f reports/*.html
	@for page in $(PAGES); do \
	    slug=$$(echo "$$page" | tr -d '/'); slug=$${slug:-index}; \
	    npx lighthouse $(SITE_URL)$$page --output html --output-path reports/$$slug --view; \
	done

.PHONY: lighthouse-json
lighthouse-json: $(CHROME_PATH) check-server ## Run Lighthouse audits, write JSON to reports/
	mkdir -p reports
	rm -f reports/*.json
	@for page in $(PAGES); do \
	    slug=$$(echo "$$page" | tr -d '/'); slug=$${slug:-index}; \
	    npx lighthouse $(SITE_URL)$$page --output json --output-path reports/$$slug; \
	done

.PHONY: axe
axe: $(CHROME_PATH) check-server ## Run axe accessibility checks against $(SITE_URL)
	@for page in $(PAGES); do \
	    npx pa11y --runner axe --standard WCAG2AA $(SITE_URL)$$page; \
	done

.PHONY: axe-json
axe-json: $(CHROME_PATH) check-server ## Run axe accessibility checks, write JSON to reports/
	mkdir -p reports
	rm -f reports/axe-*.json
	@for page in $(PAGES); do \
	    slug=$$(echo "$$page" | tr -d '/'); slug=$${slug:-index}; \
	    npx pa11y --runner axe --reporter json --standard WCAG2AA $(SITE_URL)$$page > reports/axe-$$slug.json; \
	done

.PHONY: a11y
a11y: pa11y lighthouse axe ## Run all accessibility audits, open Lighthouse reports in browser

.PHONY: a11y-json
a11y-json: pa11y-json lighthouse-json axe-json ## Run all accessibility audits, write JSON to reports/
