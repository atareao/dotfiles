EXTENSION := `cat metadata.json | jq -r '.uuid'`

default:
    @just --list

build:
    @pnpm install

compile:
    @tsc || true

schemas:
    @glib-compile-schemas schemas

make:
    @just clean build compile schemas
    @cp -r assets dist/
    @cp -r icons dist/
    @cp -r schemas dist/
    @cp stylesheet.css dist/
    @cp metadata.json dist/

install:
    @just make
    @rm -rf ~/.local/share/gnome-shell/extensions/{{ EXTENSION }}
    @mkdir -p ~/.local/share/gnome-shell/extensions/{{ EXTENSION }}
    @cp -r dist/* ~/.local/share/gnome-shell/extensions/{{ EXTENSION }}

clean:
    @rm -rf dist
    @mkdir dist

zip:
    @rm -f ../../{{ EXTENSION }}.zip
    @just make
    @(cd dist && zip -9r ../../{{ EXTENSION }}.zip .)

