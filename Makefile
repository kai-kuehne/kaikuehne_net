HUGO := /opt/homebrew/bin/hugo

all: $(HUGO)
	open http://localhost:1313/
	$(HUGO) serve --buildDrafts --buildExpired --buildFuture --noHTTPCache

publish: $(HUGO)
	rm -rf public/*
	$(HUGO) --buildDrafts --buildExpired --buildFuture
	scp -Or public/* kaiaaa@www610.your-server.de:/public_html

$(HUGO):
	brew install hugo

