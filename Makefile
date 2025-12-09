# Hugo version (should match .github/workflows/hugo.yml)
HUGO_VERSION := 0.128.0
HUGO_BIN := bin/hugo
HUGO_URL := https://github.com/gohugoio/hugo/releases/download/v$(HUGO_VERSION)/hugo_extended_$(HUGO_VERSION)_linux-amd64.tar.gz

# Detect OS for different download URLs if needed
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
	HUGO_URL := https://github.com/gohugoio/hugo/releases/download/v$(HUGO_VERSION)/hugo_extended_$(HUGO_VERSION)_darwin-universal.tar.gz
endif

.PHONY: help
help: ## Show this help message
	@echo "Available commands:"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36mmake %-15s\033[0m %s\n", $$1, $$2}'
	@echo ""

.DEFAULT_GOAL := help

.PHONY: serve
serve: $(HUGO_BIN) ## Run development server (auto-installs Hugo if missing)
	$(HUGO_BIN) server --disableFastRender --noHTTPCache --buildDrafts --cleanDestinationDir --bind=0.0.0.0

.PHONY: build
build: $(HUGO_BIN) ## Build the site
	$(HUGO_BIN) --minify

.PHONY: setup
setup: $(HUGO_BIN) ## Install all dependencies
	@echo "✓ Hugo $(HUGO_VERSION) installed"
	@echo "✓ Setup complete"

.PHONY: clean
clean: ## Remove generated files
	rm -rf public resources bin

$(HUGO_BIN):
	@echo "Installing Hugo $(HUGO_VERSION) extended..."
	@mkdir -p bin
	@curl -sL $(HUGO_URL) | tar xz -C bin hugo
	@chmod +x $(HUGO_BIN)
	@echo "✓ Hugo $(HUGO_VERSION) installed to $(HUGO_BIN)"
	@$(HUGO_BIN) version
