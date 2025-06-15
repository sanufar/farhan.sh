.PHONY: all serve build build-prod copy sync dev watch 

export PATH := $(CURDIR)/node_modules/.bin:$(PATH)

all: dev

build-prod: tailwind-init copy format

tailwind-init: 
	npx tailwindcss -i ./content/css/app.css -o ./public/assets/styles.css --minify
	
copy:
	@cp -a content/. ./public/
	@cp -r ./assets ./public/
	@rm -rf public/css
	@find public -type f -name '*.css' -o -name '*.md' ! -path 'public/assets/*' -delete

format:
	@npm run format

TAILWIND_BUILD = tailwindcss \
                   -i ./content/css/app.css \
                   -o ./public/assets/styles.css > /dev/null 2>&1

RSYNC_FLAGS    = --delete \
                 --filter='P assets/styles.css' \
                 --filter='P assets/styles.css.map'

BS_PORT        = 3000         

build:       
	@rsync -a $(RSYNC_FLAGS) content/ public/
	@rsync -a assets/        public/assets/
	@$(TAILWIND_BUILD)

serve:      
	@browser-sync start --server public \
	        --files 'public/**/*.html' 'public/assets/styles.css' \
	        --no-ui --no-notify --port $(BS_PORT)

watch:     
	@$(MAKE) -s build
	@chokidar 'content/**/*.{html,md}' 'assets/**/*' 'content/css/**/*' \
	          -i 'content/css/**/_*.css' \
	          -d 0 \
	          -c '$(MAKE) build && \
	              curl -s "http://localhost:$(BS_PORT)/__browser_sync__?method=reload" >/dev/null'

dev:       
	@$(MAKE) -j2 serve watch 2>/dev/null
