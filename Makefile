.PHONY: run resources lang

all: resources lang run

run:
	python main.py

resources:
	printf "<!DOCTYPE RCC><RCC version='1.0'>\n<qresource>\n" > resources.qrc
	for file in `find resources`; do printf "	<file>$$file</file>\n" >> resources.qrc; done
	printf "</qresource>\n</RCC>\n" >> resources.qrc
	pyrcc5 -o resources.py resources.qrc

lang:
	lupdate translations.pro
	lrelease translations.pro

