WAYLAND_SCANNER := wayland-scanner

PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin

VERSION="0.3.0"

CFLAGS ?= -Wall -Wextra -Wno-unused-parameter -Wno-parentheses
CFLAGS += -DVERSION=\"$(VERSION)\"

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
	$(WAYLAND_SCANNER) private-code < $< > $@

%.h: %.xml
	$(WAYLAND_SCANNER) client-header < $< > $@

tsm:
	$(MAKE) -C $@

.PHONY: install uninstall clean tsm
