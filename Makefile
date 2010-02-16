prefix=/usr/local
DESTDIR=

RM = rm -f
TAR = tar
ZIP = zip
INSTALL = install
GIT = git
BZIP2 = bzip2
ASCIIDOC = asciidoc
A2X = a2x
SED = sed

default: all
.PHONY: default

.SUFFIXES:

PROJECT = git-multipush
-include gen-version.mk
-include dist.mk
-include man2txt.mk

all: bin doc

install: install-bin install-doc

clean: clean-bin clean-doc

doc/git-track.1: doc/git-track.1.txt
	$(A2X) -f manpage -L doc/git-track.1.txt
doc/git-track.1.html: doc/git-track.1.txt
	$(ASCIIDOC) doc/git-track.1.txt
doc/git-track.txt: doc/git-track.1
	$(call man2txt,doc/git-track.1,doc/git-track.txt)
clean-doc:
	$(RM) doc/git-track.1 doc/git-track.1.html doc/git-track.txt
doc: doc/git-track.1 doc/git-track.1.html doc/git-track.txt

git-track: git-track.sh $(VERSION_DEP)
	$(SED) -e 's/^# @VERSION@/VERSION=$(VERSION)/' git-track.sh > git-track
	@chmod +x git-track
bin: git-track
clean-bin:
	$(RM) git-track
install-bin: git-track
	$(INSTALL) -d -m 0755 $(DESTDIR)$(prefix)/bin
	$(INSTALL) -m 0755 git-track $(DESTDIR)$(prefix)/bin

install-doc: doc/git-track.1 doc/git-track.1.html doc/git-track.txt
	$(INSTALL) -d -m 0755 $(DESTDIR)$(prefix)/share/man/man1
	$(INSTALL) -m 0644 doc/git-track.1 $(DESTDIR)$(prefix)/share/man/man1
	$(INSTALL) -m 0644 doc/git-track.1.html $(DESTDIR)$(prefix)/share/man/man1
	$(INSTALL) -d -m 0755 $(DESTDIR)$(prefix)/share/doc/git-track
	$(INSTALL) -m 0644 doc/git-track.txt $(DESTDIR)$(prefix)/share/doc/git-track
	$(INSTALL) -m 0644 README.markdown $(DESTDIR)$(prefix)/share/doc/git-track

