TEXSRC=fpl13-poly

all:
	latex $(TEXSRC)
	bibtex $(TEXSRC)
	bibtex $(TEXSRC)
	latex $(TEXSRC)
	latex $(TEXSRC)
	dvips -Ppdf -t a4 -o $(TEXSRC).ps $(TEXSRC).dvi
#	dvips -Ppdf -t letter -o $(TEXSRC).ps $(TEXSRC).dvi
	ps2pdf $(TEXSRC).ps $(TEXSRC).pdf

clean:
	rm -rf $(TEXSRC).aux $(TEXSRC).pdf $(TEXSRC).dvi $(TEXSRC).log $(TEXSRC).ps $(TEXSRC).bbl $(TEXSRC).log
