.PHONY: all

all: serve

serve: 
	rsync -av --exclude='*.css' --exclude='/css/' src/ public/
	npx serve public
