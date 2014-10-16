
slides.md: slides.Rmd
	R -e 'library(knitr); knit("$<")'

slides.tex: slides.md preamble-slides.tex 
	    pandoc slides.md \
	    -t beamer \
	    -H preamble-slides.tex \
	    --latex-engine xelatex \
	    --filter ./overlay_filter.py \
	    -o $@

notes.tex: slides.md preamble-notes.tex
	pandoc --latex-engine xelatex \
	    -t beamer \
	    -H preamble-notes.tex \
	    -V fontsize=8pt \
	    --filter ./overlay_filter.py \
	    -o $@ \
	    slides.md

pdfs := slides.pdf notes.pdf

$(pdfs): %.pdf: %.tex
	latexmk -xelatex $(basename $<)

all: $(pdfs)

.DEFAULT_GOAL := all

.PHONY: all deploy deploy_git
