prefix=/usr/local
DESTDIR=

all: doc

doc/git-track.1: doc/git-track.1.txt
	a2x -f manpage -L doc/git-track.1.txt

doc/git-track.1.html: doc/git-track.1.txt
	asciidoc doc/git-track.1.txt

doc/git-track.txt: doc/git-track.1
	groff -t -e -P -c -Tutf8 -mandoc doc/git-track.1 | col -bx \
	> doc/git-track.txt

doc: doc/git-track.1 doc/git-track.1.html doc/git-track.txt

clean:
	rm -f doc/git-track.1 doc/git-track.1.html

install-bin: git-track
	install -d -m 0755 $(DESTDIR)$(prefix)/bin
	install -m 0755 git-track $(DESTDIR)$(prefix)/bin

install-doc: doc/git-track.1 doc/git-track.1.html doc/git-track.txt
	install -d -m 0755 $(DESTDIR)$(prefix)/share/man/man1
	install -m 0644 doc/git-track.1 $(DESTDIR)$(prefix)/share/man/man1/
	install -m 0644 doc/git-track.1.html $(DESTDIR)$(prefix)/share/man/man1/
	install -d -m 0755 $(DESTDIR)$(prefix)/share/doc/git-track/
	install -m 0644 doc/git-track.txt $(DESTDIR)$(prefix)/share/doc/git-track/

install: install-bin install-doc

