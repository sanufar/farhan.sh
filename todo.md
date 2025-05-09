ideally have header and footer templates

then frontpage.html (index?? idk) => this covers the homepage, nothing else
then base.html => the barebones (i.e navbar, title settings) for blog...misc

then blog.html => needs to have templating for list of articles + metadata

projects.html => might just do that myself.
now => ''
linkroll => simple list/parse from a md file

manageable!

structure:

keep static assets in static/ dir

static/
fonts/
css/
js/
favicon.ico

use bacon to watch (stretch goal so far)
stretches (phase 2)

-> simple server with axum or miniserver => serves dir at :3000
-> tower-livereload triggers upon save (bacon trigger) websockets!
