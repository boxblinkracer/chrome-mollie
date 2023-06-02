#
# Makefile
#

.PHONY: help
.DEFAULT_GOAL := help


help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

install: ## Installs all dependencies
	npm install

# ---------------------------------------------------------------------------------------------

eslint: ## Starts the ESLinter
	./node_modules/.bin/eslint --config ./.eslintrc.json .

prettier: ## Starts Prettier
	./node_modules/.bin/prettier --check "./**/*.js"

pr: ## Prepares everything for a Pull Request
	./node_modules/.bin/prettier --write "./**/*.js"
	@make eslint -B
	@make prettier -B

# ---------------------------------------------------------------------------------------------

build: ## Builds a PROD version and creates a ZIP file
	mkdir -p ./.build
	rm -rf ./.build/mollie-chrome-extension.zip || true;
	zip -qq -r -0 ./.build/mollie-chrome-extension.zip . -x '*.git*' '*..github*' '*.idea*' '*.build*' '*node_modules*' '*makefile*' '*.eslintrc.json*' '*.prettierrc.json*' '*package.json*' '*package-lock.json*'

