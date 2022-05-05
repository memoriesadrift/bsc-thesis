#!/bin/bash

echo "Watching for changes..."

makepdf() {
  cd src/
  latexmk -pdf -bibtex main.tex
  cd ..
}

inotifywait -rm --exclude "aux|bib|tex~|log|blg|fdb_latexmk|fls|glo|ist|out|pdf|swp|git\/" -e modify src/ | while read change; do
  makepdf
  echo "Change detected: "
  echo $change
done
