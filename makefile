MAIN=blog-syntax
TENSAKU= tensaku
TEXPARTS= *.tex
FLAGS=-shell-escape -synctex=1 -interaction=nonstopmode

BIBPARTS= BIB/*.bib
# LPR= pspr # or change to 'qpr -q ps3'
# POSTSCRIPT= dvips -P cmz -t letter  #dvips -f
FIGPARTS= FIG/*.fig FIG/*.png
STYPARTS= *.sty
OTHER= dotest makefile README
ALLPARTS= $(MAIN).tex $(TEXPARTS) $(BIBPARTS) $(FIGPARTS) $(OTHER) $(STYPARTS)

# use *this*, to have the svn version within latex
# $(MAIN).pdf: $(MAIN).tex $(TEXPARTS) svnset


$(MAIN).pdf: $(MAIN).tex $(TEXPARTS) 
	pdflatex $(FLAGS) $(MAIN).tex
	bibtex $(MAIN)
	pdflatex $(FLAGS) $(MAIN).tex
	bibtex $(MAIN)
	pdflatex $(FLAGS) $(MAIN).tex

svnset:
	svn propset svn:keywords 'HeadURL LastChangedDate LastChangedRevision LastChangedBy' *.tex
	touch svnset



try: $(MAIN).tex
	pdflatex $(MAIN)

clean:
	\rm -f *.dvi $(MAIN).ps *.bbl *.aux *.log *.blg *.toc all.tar* uu \
	*~ *.bak *.lbl *.brf *.out

spotless: clean
	\rm -f $(MAIN).ps $(MAIN).pdf $(MAIN).svn svnset
	\rm -f final.ps final.pdf final.svn 
	\rm -rf TST

all.tar:
	tar cvfh all.tar $(ALLPARTS)

	# tar cvfh all.tar makefile $(MAIN).tex $(TEXPARTS) $(BIBPARTS) \
	$(FIGPARTS) $(STYPARTS) README

