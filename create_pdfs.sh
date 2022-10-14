#!/bin/bash

ESERCIZI=(it/capitolo-01/esercizi)
LEXICA=(it/capitolo-01/lexicon)
LANGS=(german english italian)

convert() {
  local pdf_folder="athenaze/$1/pdf"
  local md_folder="athenaze/$1/md"

  if ! mkdir "$pdf_folder" > /dev/null 2>&1; then
    printf "SKIP: Create pdf folder %s - it most likely exists already\n" "$pdf_folder"
  else
    printf: "OK: Create pdf folder %s\n" "$pdf_folder"
  fi

  for lang in "${LANGS[@]}"; do
    local lang_pdf_path="$pdf_folder/$lang.pdf"
    local lang_md_path="$md_folder/$lang.md"

    if ! pandoc --from markdown -o "$lang_pdf_path" --pdf-engine=xelatex -V mainfont="MesloLGS NF" "$lang_md_path" > /dev/null 2>&1; then
      printf "SKIP: Convert %s to %s - it most likely does not exist\n" "$lang_md_path" "$lang_pdf_path"
    else
      printf "OK: Convert %s to %s\n" "$lang_md_path" "$lang_pdf_path"
    fi
  done
}

main() {
  for esercizio in "${ESERCIZI[@]}"; do
    convert "$esercizio"
  done
  
  for lexicon in "${LEXICA[@]}"; do
    convert "$lexicon"
  done
  printf "Finished.\n"
}

main
