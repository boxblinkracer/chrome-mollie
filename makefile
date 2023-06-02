#
# Makefile
#

.PHONY: help
.DEFAULT_GOAL := help

release: ## Builds a PROD version and creates a ZIP file
	mkdir -p ./.build
	zip -qq -r -0 ./.build/MollieChromeExtension.zip . -x '*.git*' '*..github*' '*.idea*'  '*.build*'

