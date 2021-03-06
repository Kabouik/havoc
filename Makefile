
SCANNER     := wayland-scanner
PROTDATADIR != pkg-config --variable=datarootdir wayland-protocols
PROTDIR     := $(PROTDATADIR)/wayland-protocols

PREFIX=/usr/local
BINDIR=$(PREFIX)/bin

CFLAGS=-Wall -Wextra -Wno-unused-parameter -Wno-parentheses

LIBS=-lrt -lm -lutil -lwayland-client -lwayland-cursor -lxkbcommon -Ltsm -lhtsm
OBJ=touch-extension.o surface-extension.o gtk-primary-selection.o glyph.o main.o
GEN=touch-extension.c touch-extension.h surface-extension.c surface-extension.h gtk-primary-selection.c gtk-primary-selection.h

havoc: tsm $(OBJ)
	$(CC) $(LDFLAGS) -o $@ $(OBJ) $(LIBS)

install: havoc
	install -D -t $(DESTDIR)$(BINDIR) havoc

uninstall:
	rm -f $(DESTDIR)$(BINDIR)/havoc

clean:
	$(MAKE) -C tsm clean
	rm -f havoc $(GEN) $(OBJ)

$(OBJ): $(GEN)

%.c: %.xml
	$(SCANNER) private-code < $< > $@

%.h: %.xml
	$(SCANNER) client-header < $< > $@

tsm:
	$(MAKE) -C $@

.PHONY: install clean tsm uninstall
