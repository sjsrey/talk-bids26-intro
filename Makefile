# Makefile for Beamer: clean + presenter (pympress notes) PDFs
# Usage:
#   make cleanpdf
#   make presenterpfd
#   make all
#   make clean

TEX       = bids26.tex
BASENAME  = $(basename $(TEX))
ENGINE    = pdflatex
LATEXOPTS = -interaction=nonstopmode -halt-on-error -file-line-error

CLEAN_PDF     = $(BASENAME)-clean.pdf
PRESENTER_PDF = $(BASENAME)-presenter.pdf

.PHONY: all cleanpdf presenterpfd clean veryclean

all: cleanpdf presenterpfd

# Build clean PDF (no notes). Requires your TeX to default to hide notes when \shownotes is undefined.
cleanpdf:
	$(ENGINE) $(LATEXOPTS) $(TEX)
	$(ENGINE) $(LATEXOPTS) $(TEX)
	mv -f $(BASENAME).pdf $(CLEAN_PDF)

# Build presenter PDF with notes-on-second-screen. Requires your TeX to enable notes when \shownotes is defined.
presenterpfd:
	$(ENGINE) $(LATEXOPTS) "\def\shownotes{1} \input{$(TEX)}"
	$(ENGINE) $(LATEXOPTS) "\def\shownotes{1} \input{$(TEX)}"
	mv -f $(BASENAME).pdf $(PRESENTER_PDF)

clean:
	rm -f $(BASENAME).aux $(BASENAME).log $(BASENAME).nav $(BASENAME).out \
	      $(BASENAME).snm $(BASENAME).toc $(BASENAME).vrb $(BASENAME).fls \
	      $(BASENAME).fdb_latexmk

veryclean: clean
	rm -f $(CLEAN_PDF) $(PRESENTER_PDF)
