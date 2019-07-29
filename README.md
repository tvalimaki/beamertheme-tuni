# A theme for Tampere Universities presentations

The LaTeX package `beamertheme-tuni` provides a theme for [Beamer] presentations that follows the graphical guidelines of [Tampere Universities][tuni] (TUNI).

## Installation

### Using the provided Makefile

An automated way for installation uses the Make utility:

- Running `make` generates only the derived files
  + `beamerthemetuni.sty` and
  + `beamercolorthemetuni.sty`
- Running `make all` generates the above and
  + the user guide `beamerthemetuni.pdf` and
  + example slides `beamerthemetuni-example.pdf` and
  + runs conversion on the graphics files
- Running `make install` installs the files on the `texmf` tree in `TEXMFHOME`. To undo, run `make uninstall`.

### Manually

If for some reason the provided Makefile does not work for you, it is possible to install the files manually. First, extract the package definition by running

```bash
etex beamerthemetuni.dtx
```

This creates the files `beamerthemetuni.sty` and `beamercolorthemetuni.sty`.

Next generate pdf versions of the graphics by running

```bash
find . -name ’*.eps’ -exec epstopdf --gsopt=-dCompatibilityLevel=1.5 {} \;
```

In order for TeX to find the package, it needs to be on the `texmf` tree. By default, TeX looks for files in three different locations:

- The root `texmf` tree, which is usually located at `/usr/share/texmf/`, `/usr/local/texlive/texmf/`, `c:\texmf\`, or `c:\texlive\texmf\`.
- The local `texmf` tree, which is usually located at `/usr/local/share/texmf/`, `/usr/local/texlive/texmf-local/`, `c:\localtexmf\`, or `c:\texlive\texmf-local\`.
- Your personal `texmf` tree, which is usually located in your home directory at `~/texmf/` or `~/Library/texmf/`.

You should install the package in your personal tree, or if you prefer, to the local tree. Installation in the root tree can cause problems, since an update of the whole TeX installation will replace this entire tree.

Inside whatever `texmf` directory you have chosen, create the sub-sub-sub- directory

```bash
texmf/tex/latex/beamertheme-tuni
```

and place all `.sty` and both `.pdf` and `.eps` versions of the graphics in this directory.

Finally, you need to rebuild TeX’s filename database. This is done by running
the command `texhash` or `mktexlsr`.

To produce the documentation you can run

```bash
pdflatex --shell-escape beamerthemetuni.dtx
makeindex -s gglo.ist -o beamerthemetuni.gls beamerthemetuni.glo
makeindex -s gind.ist -o beamerthemetuni.ind beamerthemetuni.idx
pdflatex beamerthemetuni.dtx
pdflatex beamerthemetuni.dtx
```

and optionally place the created documentation in

```bash
texmf/doc/latex/beamertheme-tuni
```

for later reference.

To produce an example presentation run

```bash
pdflatex beamerthemetuni-example.tex
biber beamerthemetuni-example
pdflatex beamerthemetuni-example.tex
pdflatex beamerthemetuni-example.tex
```

For a more detailed explanation of the standard installation process of packages, you might wish to consult [CTAN installation advice][ctan].

## License

Copyright (C) 2019 by Tuomas Välimäki

This work may be distributed and/or modified under the conditions of the LaTeX Project Public License, either version 1.3 of this license or (at your option) any later version. The latest version of this license is in:

[http://www.latex-project.org/lppl.txt](http://www.latex-project.org/lppl.txt)

and version 1.3 or later is part of all distributions of LaTeX version 2005/12/01 or later.

This work has the LPPL maintenance status `maintained'.

The Current Maintainer of this work is Tuomas Välimäki.

This work consists of the file beamerthemetuni.dtx and the derived files beamerthemetuni.ins, beamerthemetuni.sty and beamercolorthemetuni.sty.

[tuni]: https://www.tuni.fi/en
[Beamer]: https://ctan.org/pkg/beamer
[ctan]: http://www.ctan.org/installationadvice/
