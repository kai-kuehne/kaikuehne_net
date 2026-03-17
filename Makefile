# https://www.11ty.dev/docs/

.PHONY: setup
setup:
	npm init -y
	npm install @11ty/eleventy

.PHONY: eleventy
eleventy:
	npx @11ty/eleventy --serve


