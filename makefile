#
# Makefile
#

.PHONY: help
.DEFAULT_GOAL := help


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

release: ## Builds a PROD version and creates a ZIP file
	mkdir -p ./.build
	zip -qq -r -0 ./.build/MollieChromeExtension.zip . -x '*.git*' '*..github*' '*.idea*' '*.build*' '*node_modules*' '*makefile*' '*.eslintrc.json*' '*.prettierrc.json*' '*package.json*' '*package-lock.json*'

