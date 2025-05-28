.PHONY: all serve build copy dev

export PATH := $(CURDIR)/node_modules/.bin:$(PATH)

TAILWIND := npx tailwindcss -i ./content/css/app.css \
                         -o ./public/assets/styles.css --minify --watch

all: serve

serve: tailwind-init copy
	npx serve public

build: tailwind-init copy format

tailwind-init: 
	npx tailwindcss -i ./content/css/app.css -o ./public/assets/styles.css --minify
	
copy:
	@cp -a content/. ./public/
	@cp -r ./assets ./public/
	@rm -rf public/css
	@find public -type f -name '*.css' -o -name '*.md' ! -path 'public/assets/*' -delete

format:
	@npm run format

sync:
	@rsync -a --delete --exclude='css' content/ public/
	@rsync -a assets/ public/assets/

dev:
	@concurrently -k \
	  "$(TAILWIND)" \
	  "chokidar 'content/**/*.{html,md}' 'assets/**/*' \
	      -i 'content/css/**' \
	      -d 200 \
	      -c 'make sync'" \
	  "browser-sync start --server public --files public \
	      --no-ui --no-notify" 
