.PHONY: all serve build copy

all: serve

serve: tailwind-init copy
	npx serve public

build: tailwind-init copy format

tailwind-init: 
	npx tailwindcss -i ./content/css/app.css -o ./public/assets/styles.css --minify
	
copy:
	@cp -a content/. public/
	@rm -rf public/css
	@find public -type f -name '*.css' -o -name '*.md' ! -path 'public/assets/*' -delete

format:
	@npm run format
