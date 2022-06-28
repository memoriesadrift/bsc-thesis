#!/bin/bash

echo "Watching for changes..."

makepdf() {
  latexmk -pdf -bibtex main.tex
}

inotifywait -rm --exclude "aux|bib|tex~|log|blg|fdb_latexmk|fls|glo|ist|out|pdf|swp|git\/" -e modify . | while read change; do
  makepdf
  echo "Change detected: "
  echo $change
done
