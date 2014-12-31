

pdf:
	mkdir -p out
	f=../tea_tutorial ;  \
		sed 's/,/<|,|>/g' $$f | sed 's/~~/,/g' | m4 -P textify.m4  - | sed -e 's/æ/\\ae{}/g' -e "s/ó/\\\\'o/g" -e 's/ô/\\^o/g' \
	-e 's/…/.../g' -e 's/œ/\\oe{}/g' -e 's/&gt;/>/' -e 's/&lt;/</' > out/`basename $$f .tex`.tex ;
	cp ../tea.bib out
	cd out && pdflatex tea_tutorial
	cd out && bibtex tea_tutorial
	cd out && pdflatex tea_tutorial
	cd out && pdflatex tea_tutorial

HTMLout=~/tmp/tea-tutorial

html:
	mkdir -p out
	f=../tea_tutorial ;  \
		sed 's/,/<|,|>/g' $$f  | sed 's/~~/,/g' | m4 -P htmlify.m4  - | sed -e 's|<ul> *</li>|<ul>|' | insert_ps | \
        sed -e 's/<p><h6>/<h6>/' -e 's|</h6></p>|</h6>|' -e 's|<p></li>|</li>|g'\
        -e '$d' -e 's/``/“/g' -e 's/\\dots/…/g' -e 's/\\%/%/g' -e 's/\\#/#/g' -e 's/---/—/g'\
            |awk -f awk_cut > out/`basename $$f xx`.html;
	cd bib&&make
	echo "<h2>Bibliography</h2>" > out/xxx
	cat head.html out/tea_tutorial.html out/xxx  bib/bibshell.html tail.html > $(HTMLout)/index.html
	cp tutorial.css $(HTMLout)

push:
	cd $(HTMLout) && git commit -a -m "Another update." && git push origin gh-pages
	scp out/tea_tutorial.pdf klemens@klemens.org:/var/www/html/ben/pdfs/
