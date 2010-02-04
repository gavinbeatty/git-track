prefix=/usr/local

all: doc

doc/git-track.1: doc/git-track.1.txt
	a2x -f manpage -L doc/git-track.1.txt

doc/git-track.1.html: doc/git-track.1.txt
	asciidoc doc/git-track.1.txt

doc: doc/git-track.1 doc/git-track.1.html

clean:
	rm -f doc/git-track.1 doc/git-track.1.html

install-bin: git-track
	install -d -m 0755 $(prefix)/bin
	install -m 0755 git-track $(prefix)/bin

install-doc: doc/git-track.1 doc/git-track.1.html
	install -d -m 0755 $(prefix)/share/man/man1
	install -m 0644 doc/git-track.1 $(prefix)/share/man/man1/
	install -m 0644 doc/git-track.1.html $(prefix)/share/man/man1/

install: install-bin install-doc

