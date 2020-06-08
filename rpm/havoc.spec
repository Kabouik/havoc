Name:          havoc
Version:       85fdde7
Release:       1
Summary:       A minimal terminal emulator for Wayland on Linux
Group:         System
Vendor:        Murray Calavera <murray.calavera@protonmail.com>
Distribution:  Sailfish OS
Packager:      Kabouik <matf[redactedforbots]disr.it>
Source0:       %{name}-%{version}.tar.gz
URL:           https://github.com/kabouik/havoc
License:       MIT

%description
Havoc is a minimal but modern terminal emulator for Wayland. It supports everything you would expect from a terminal emulator on a PC, including 24bit colours and TUI features that Fingerterm and, to a lower extent, Toeterm, cannot handle. Havoc being developed for PC originally, it is meant to be used in landscape with a hardware keyboard.

You can still use Havoc with no hardware keyboard, using qCommand, any other terminal, or .desktop files to print command outputs that do not render correctly in other terminals. To issue a command in Havoc from another application, use "havoc -l COMMAND", where "-l" is to hold in case the output does not keep a process running.

# Features
- 24bit colours
- Full support for ncurses features and other TUI
- Easy multi-touch text selection; no more conflict between selecting and scrolling
- One finger scrolling (like all native SFOS apps except terminals
- User configuration in ~/.config/havoc.cfg by default (font, font size, colours, opacity of the cover, etc.)
- Support for compose and dead keys if your hardware keyboard is set to use a xkb layout with those (additional package)

# Disclaimer
I am not the developer of Havoc, I just packaged it for SFOS. Havoc is being actively developed by Murray Calavera (ii8) at https://github.com/ii8/havoc/.

%license
LICENSE

%files
%defattr(-,root,root,-)
%{_bindir}/havoc
%{_datadir}/applications/*.desktop
%{_datadir}/icons/hicolor/86x86/apps/havoc.png
%config /home/nemo/.config/havoc.cfg

%prep
setup -q -n %{name}-%{version}

%build
make CFLAGS="-O2 -DNDEBUG"

%install
rm -rf %{buildroot}
make PREFIX=/usr DESTDIR=%{?buildroot} install
cp %{?buildroot}/havoc.desktop %{_datadir}/applications/havoc.destkop
cp %{?buildroot}/icons/havoc.png %{_datadir}/icons/hicolor/86x86/apps/havoc.png

%post
# Bundle a default config file for easier customization
cp %{?buildroot}/havoc.cfg /home/nemo/.config/havoc.cfg
chmod 644 /home/nemo/.config/havoc.cfg
chown nemo:nemo /home/nemo/.config/havoc.cfg

%changelog
* Mon Jun 08 2020 Kabouik <matf[redactedforbots]disr.it> 85fdde7
- First SFOS package based on the 85fdde7 version.
