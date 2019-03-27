VERSION ?= 0.9.02
PREFIX ?= /usr/local
DIST := vdr-chksums Makefile README.md vdr-chksums.1.gz doc/

# VERSION=0.9.01 make dist
#
# file permissions for debian 9 stretch distro
# your distro may vary
DIR_PRM := u=rwx,g=srwx,o=rx
DOC_PRM := 644
EXE_PRM := 755

all:

update_changelog:
	cat CHANGELOG | gzip -f > ./doc/changelog.gz

update_man:
	pod2man ./vdr-chksums | gzip -f > ./vdr-chksums.1.gz

update_readme:
	pod2markdown ./vdr-chksums > ./README.md

make:	update_changelog update_man update_readme

install:
	install -m $(EXE_PRM) -D vdr-chksums $(DESTDIR)$(PREFIX)/bin/vdr-chksums
	if test ! -d $(DESTDIR)$(PREFIX)/share/man; then mkdir -m $(DIR_PRM) $(DESTDIR)$(PREFIX)/share/man; fi
	if test ! -d $(DESTDIR)$(PREFIX)/share/man/man1; then mkdir -m $(DIR_PRM) $(DESTDIR)$(PREFIX)/share/man/man1; fi
	install -m $(DOC_PRM) -D vdr-chksums.1.gz $(DESTDIR)$(PREFIX)/share/man/man1/
	if test ! -d $(DESTDIR)$(PREFIX)/share/doc; then mkdir -m $(DIR_PRM) $(DESTDIR)$(PREFIX)/share/doc; fi
	mkdir -m $(DIR_PRM)  $(DESTDIR)$(PREFIX)/share/doc/vdr-chksums/
	mkdir -m $(DIR_PRM)  $(DESTDIR)$(PREFIX)/share/doc/vdr-chksums/samples/
	install -m $(DOC_PRM) -D doc/changelog.gz $(DESTDIR)$(PREFIX)/share/doc/vdr-chksums/
	install -m $(DOC_PRM) -D doc/copyright $(DESTDIR)$(PREFIX)/share/doc/vdr-chksums/
	install -m $(DOC_PRM) -D doc/LICENSE $(DESTDIR)$(PREFIX)/share/doc/vdr-chksums/
	install -m $(DOC_PRM) -D doc/samples/* $(DESTDIR)$(PREFIX)/share/doc/vdr-chksums/samples/

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/vdr-chksums
	rm -f $(DESTDIR)$(PREFIX)/share/man/man1/vdr-chksums.1.gz
	rm -fR $(DESTDIR)$(PREFIX)/share/doc/vdr-chksums

dist: vdr-chksums-$(VERSION).tar.xz

%.tar.bz2: $(DIST)
	tar -c --exclude-vcs --transform="s@^@$*/@" $^ | bzip2 -cz9 > $@

%.tar.gz: $(DIST)
	tar -c --exclude-vcs --transform="s@^@$*/@" $^ | gzip -cn9 > $@

%.tar.xz: $(DIST)
	tar -c --exclude-vcs --transform="s@^@$*/@" $^ | xz -cz9 > $@

clean:
	rm -f *.tar.*

.PHONY: all clean dist install uninstall update_changelog update_man update_readme
