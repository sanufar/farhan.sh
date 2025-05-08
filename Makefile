.PHONY: all

all: serve

serve: 
	npx tailwindcss -i ./src/css/app.css -o ./public/assets/styles.css --minify
	rsync -av --exclude='*.css' --exclude='/css/' src/ public/
	npx serve public
