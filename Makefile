PROJ = lkmpg
all: $(PROJ).pdf

$(PROJ).pdf: lkmpg.tex
	rm -rf _minted-$(PROJ)
	pdflatex -shell-escap $<
	bibtex $(PROJ) >/dev/null || echo
	pdflatex -shell-escape $< 2>/dev/null >/dev/null

html: lkmpg.tex html.cfg
	make4ht --shell-escape --utf8 --format html5 --config html.cfg --output-dir html lkmpg.tex
	ln -sf lkmpg.html html/index.html
	rm -f  lkmpg.xref lkmpg.tmp lkmpg.html lkmpg.css lkmpg.4ct lkmpg.4tc lkmpg.dvi lkmpg.lg lkmpg.idv lkmpg*.svg lkmpg.log lkmpg.aux 

indent:
	(cd examples; find . -name '*.[ch]' | xargs clang-format -i)

clean:
	rm -f *.dvi *.aux *.log *.ps *.pdf *.out lkmpg.bbl lkmpg.blg lkmpg.lof lkmpg.toc
	rm -rf _minted-lkmpg
	rm -rf html

.PHONY: html
