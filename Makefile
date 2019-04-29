PKGNAME = beamertheme-tuni
NAME  = beamerthemetuni
SHELL = bash
TEXMFHOME = $(shell kpsewhich --var-value TEXMFHOME)

sty: $(NAME).dtx
	etex $(NAME).dtx
all: logo $(NAME) example clean
	@exit 0
logo: tau-logo-*.eps
	find . -name 'tau-logo-*.eps' -exec epstopdf {} \;
$(NAME): $(NAME).dtx
	pdflatex --shell-escape $(NAME).dtx
	makeindex -s gglo.ist -o $(NAME).gls $(NAME).glo
	makeindex -s gind.ist -o $(NAME).ind $(NAME).idx
	pdflatex $(NAME).dtx
	pdflatex $(NAME).dtx
example: $(NAME)
	pdflatex beamerthemetuni-example.tex
	biber beamerthemetuni-example
	pdflatex beamerthemetuni-example.tex
	pdflatex beamerthemetuni-example.tex
clean:
	rm -f $(NAME).{aux,glo,gls,idx,ilg,ind,log,out,toc}
	rm -f $(NAME)-example.{aux,bbl,bcf,bib,blg,log,nav,out,run.xml,snm,toc}
	rm -f mwe.*
distclean: clean
	rm -f $(NAME).{pdf,sty,ins} beamercolorthemetuni.sty
	rm -f $(NAME)-example.{tex,pdf}
	rm -f tau-logo-{fin,eng}.pdf
	rm -rf $(PKGNAME).tds.zip
install: all
	mkdir -p $(TEXMFHOME)/{tex,source,doc}/latex/$(PKGNAME)
	cp $(NAME).dtx $(NAME).ins $(TEXMFHOME)/source/latex/$(PKGNAME)
	cp $(NAME).sty beamercolorthemetuni.sty $(TEXMFHOME)/tex/latex/$(PKGNAME)
	mkdir -p $(TEXMFHOME)/tex/generic/tuni-logos
	cp tau-logo-{fin,eng}.{eps,pdf} $(TEXMFHOME)/tex/generic/tuni-logos
	cp $(NAME).pdf $(TEXMFHOME)/doc/latex/$(PKGNAME)
	mktexlsr
uninstall:
	rm -r $(TEXMFHOME)/{tex,source,doc}/latex/$(PKGNAME)
	rm $(TEXMFHOME)/tex/generic/tuni-logos/tau-logo-{fin,eng}.{eps,pdf}
	mktexlsr
release: all
	mkdir -p {tex,source,doc}/latex/$(PKGNAME)
	cp $(NAME).dtx $(NAME).ins source/latex/$(PKGNAME)
	cp $(NAME).sty beamercolorthemetuni.sty tex/latex/$(PKGNAME)
	mkdir -p tex/generic/tuni-logos
	cp tau-logo-{fin,eng}.{eps,pdf} tex/generic/tuni-logos
	cp $(NAME).pdf $(NAME)-example.{tex,pdf} doc/latex/$(PKGNAME)
	zip -rm $(PKGNAME).tds.zip tex source doc
