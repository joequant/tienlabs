run:
	java -jar plantuml.jar document-server.tex
	pdflatex document-server.tex
	bibtex document-server
	pdflatex document-server.tex
	pdflatex document-server.tex

plantuml.jar:
	wget http://downloads.sourceforge.net/projects/plantuml/files/plantuml.jar
