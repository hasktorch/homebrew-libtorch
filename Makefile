all:

install:
	cd include/torch; for i in csrc/api/include/torch/* ; do ln -s $$i ;done
        install -d $(DESTDIR)/bin
        install -d $(DESTDIR)/include
        install -d $(DESTDIR)/share
        install bin/* $(DESTDIR)/bin
        install include/* $(DESTDIR)/include
        install share/* $(DESTDIR)/share
