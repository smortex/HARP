all: harp.pdf

harp.pdf: harp.md Makefile
	pandoc --pdf-engine=xelatex --shift-heading-level-by=1 --top-level-division=part --number-sections harp.md -o harp.pdf

harp.md: HARP-TdM-Livre-des-Joueurs-Textes-export HARP-TdM-Livre-des-Joueurs-Textes-export/*/*.md Makefile titleize
	cat header.md HARP-TdM-Livre-des-Joueurs-Textes-export/*/*.md > harp.md
	cp HARP-TdM-Livre-des-Joueurs-Textes-export/*/*.png .
	sed -i '' -e 's/16-06-annexe-magie-cristaux-runiques-cristaux-runiques-\([12]\).png/16-06-annexe-magie-cristaux-runiques-\1.png/g' harp.md
	sed -i '' -e 's/&#8239;//g' -e 's/&nbsp;//g' harp.md
	./titleize harp.md

HARP-TdM-Livre-des-Joueurs-Textes-export: HARP-TdM-Livre-des-Joueurs-Textes-export.rar
	unrar x HARP-TdM-Livre-des-Joueurs-Textes-export.rar
	# Add missing new-line at end of some file
	for f in HARP-TdM-Livre-des-Joueurs-Textes-export/*/*.md; do echo >> $$f; done
	# unrar kept the old date
	touch HARP-TdM-Livre-des-Joueurs-Textes-export

HARP-TdM-Livre-des-Joueurs-Textes-export.rar:
	fetch http://loridan.info/rpg/harp-tdm-regles/fichiers/HARP-TdM-Livre-des-Joueurs-Textes-export.rar
