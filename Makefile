prefix=/usr/local
DESTDIR=

PROJECT = git-track

bindir = $(DESTDIR)$(prefix)/bin
man1dir = $(DESTDIR)$(prefix)/share/man/man1
docdir = $(DESTDIR)$(prefix)/share/doc/$(PROJECT)

RM = rm -f
TAR = tar
ZIP = zip
INSTALL_DIR = install -d -m 0755
INSTALL_BIN = install -m 0755
INSTALL_DATA = install -m 0644
GIT = git
BZIP2 = bzip2
ASCIIDOC = asciidoc
A2X = a2x
SED = sed

default: all
.PHONY: default

.SUFFIXES:

-include gen-version.mk
-include dist.mk
-include man2txt.mk

all: bin doc
install: install-bin install-doc
clean: clean-bin clean-doc
.PHONY: all install clean

doc/$(PROJECT).1: doc/$(PROJECT).1.txt
	$(A2X) -f manpage -L doc/$(PROJECT).1.txt
doc/$(PROJECT).1.html: doc/$(PROJECT).1.txt
	$(ASCIIDOC) doc/$(PROJECT).1.txt
doc/$(PROJECT).txt: doc/$(PROJECT).1
	$(call man2txt,doc/$(PROJECT).1,doc/$(PROJECT).txt)
doc: doc/$(PROJECT).1 doc/$(PROJECT).1.html doc/$(PROJECT).txt
clean-doc:
	$(RM) doc/$(PROJECT).1 doc/$(PROJECT).1.html doc/$(PROJECT).txt
install-doc: doc/$(PROJECT).1 doc/$(PROJECT).1.html doc/$(PROJECT).txt
	$(INSTALL_DIR) $(man1dir)
	$(INSTALL_DATA) doc/$(PROJECT).1 $(man1dir)
	$(INSTALL_DATA) doc/$(PROJECT).1.html $(man1dir)
	$(INSTALL_DIR) $(docdir)
	$(INSTALL_DATA) doc/$(PROJECT).txt $(docdir)
	$(INSTALL_DATA) README.markdown $(docdir)
.PHONY: doc clean-doc install-doc doc

$(PROJECT): $(PROJECT).sh $(VERSION_DEP)
	$(SED) -e 's/^# @VERSION@/VERSION=$(VERSION)/' $(PROJECT).sh > $(PROJECT)
	@chmod +x $(PROJECT)
bin: $(PROJECT)
clean-bin:
	$(RM) $(PROJECT)
install-bin: $(PROJECT)
	$(INSTALL_DIR) $(bindir)
	$(INSTALL_BIN) $(PROJECT) $(bindir)
.PHONY: bin clean-bin insetall-bin


