VERSION := $(shell ./vdr-chksums -V)
PREFIX ?= /usr/local
DIST := vdr-chksums Makefile README.md vdr-chksums.1.gz doc/ build.deb/ CHANGELOG

# setable file permissions
# to-test: make -e DIR_PRM=755 -e DOC_PRM=664 -e show_permissions
DIR_PRM ?= 775
DOC_PRM ?= 644
EXE_PRM ?= 755

all:

show_permissions:
	@echo show setable permissions
	@echo DIR_PRM: $(DIR_PRM)
	@echo DOC_PRM: $(DOC_PRM)
	@echo EXE_PRM: $(EXE_PRM)

show_version:
	@echo $(VERSION)

update_changelog:
	cat CHANGELOG | gzip -f > ./doc/changelog.gz
	cat CHANGELOG > ./build.deb/debian/changelog

update_copyright:
	cat doc/copyright > build.deb/debian/copyright

update_man:
	pod2man ./vdr-chksums | gzip -f > ./vdr-chksums.1.gz

update_readme:
	pod2markdown ./vdr-chksums > ./README.md

make:	update_changelog update_man update_readme update_copyrignt

install:
	install -m $(EXE_PRM) -D vdr-chksums $(DESTDIR)$(PREFIX)/bin/vdr-chksums
	if test ! -d $(DESTDIR)$(PREFIX)/share/man; then mkdir -m $(DIR_PRM) $(DESTDIR)$(PREFIX)/share/man; fi
	if test ! -d $(DESTDIR)$(PREFIX)/share/man/man1; then mkdir -m $(DIR_PRM) $(DESTDIR)$(PREFIX)/share/man/man1; fi
	install -m $(DOC_PRM) -D vdr-chksums.1.gz $(DESTDIR)$(PREFIX)/share/man/man1/
	if test ! -d $(DESTDIR)$(PREFIX)/share/doc; then mkdir -m $(DIR_PRM) $(DESTDIR)$(PREFIX)/share/doc; fi
	mkdir -m $(DIR_PRM)  $(DESTDIR)$(PREFIX)/share/doc/vdr-chksums/
	mkdir -m $(DIR_PRM)  $(DESTDIR)$(PREFIX)/share/doc/vdr-chksums/examples/
	install -m $(DOC_PRM) -D doc/changelog.gz $(DESTDIR)$(PREFIX)/share/doc/vdr-chksums/
	install -m $(DOC_PRM) -D doc/copyright $(DESTDIR)$(PREFIX)/share/doc/vdr-chksums/
	install -m $(DOC_PRM) -D doc/LICENSE $(DESTDIR)$(PREFIX)/share/doc/vdr-chksums/
	install -m $(DOC_PRM) -D doc/examples/* $(DESTDIR)$(PREFIX)/share/doc/vdr-chksums/examples/

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/vdr-chksums
	rm -f $(DESTDIR)$(PREFIX)/share/man/man1/vdr-chksums.1.gz
	rm -fR $(DESTDIR)$(PREFIX)/share/doc/vdr-chksums

dist: vdr-chksums_$(VERSION).tar.xz

dist_gz: vdr-chksums_$(VERSION).tar.gz

dist_bz2: vdr-chksums_$(VERSION).tar.bz2

%.tar.bz2: $(DIST)
	tar -c --exclude-vcs --transform="s@^@$*/@" $^ | bzip2 -cz9 > $@

%.tar.gz: $(DIST)
	tar -c --exclude-vcs --transform="s@^@$*/@" $^ | gzip -cn9 > $@

%.tar.xz: $(DIST)
	tar -c --exclude-vcs --transform="s@^@$*/@" $^ | xz -cz9 > $@

clean:
	rm -f *.tar.*

.PHONY: all clean dist install uninstall update_changelog update_man update_readme show_version show_permissions update_copyright
