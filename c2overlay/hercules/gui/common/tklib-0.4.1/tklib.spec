# $Id: sak.tcl,v 1.4 2005/11/02 19:31:11 andreas_kupries Exp $

%define version 0.4.1
%define directory /usr

Summary: The standard Tk library
Name: tklib
Version: %{version}
Release: 2
Copyright: BSD
Group: Development/Languages
Source: %{name}-%{version}.tar.bz2
URL: http://tcllib.sourceforge.net/
Packager: Jean-Luc Fontaine <jfontain@free.fr>
BuildArchitectures: noarch
Prefix: /usr
Requires: tcl >= 8.3.1
BuildRequires: tcl >= 8.3.1
Buildroot: /var/tmp/%{name}-%{version}

%description
Tklib, the Tk Standard Library is a collection of Tcl packages that
provide Tk utility functions and widgets useful to a large collection
of Tcl/Tk programmers.
The home web site for this code is http://tcllib.sourceforge.net/.
At this web site, you will find mailing lists, web forums, databases
for bug reports and feature requests, the CVS repository (browsable
on the web, or read-only accessible via CVS), and more.
Note: also grab source tarball for more documentation, examples, ...

%prep

%setup -q

%install
# compensate for missing manual files:
# - nothing yet
/usr/bin/tclsh installer.tcl -no-gui -no-wait -no-html -no-examples -pkg-path $RPM_BUILD_ROOT/usr/lib/%{name}-%{version} -nroff-path $RPM_BUILD_ROOT/usr/share/man/mann/
# install HTML documentation to specific modules sub-directories:
# generate list of files in the package (man pages are compressed):
find $RPM_BUILD_ROOT ! -type d | sed -e "s,^$RPM_BUILD_ROOT,,;" -e 's,\.n$,\.n\.gz,;' > %{_builddir}/%{name}-%{version}/files

%clean
rm -rf $RPM_BUILD_ROOT

%files -f %{_builddir}/%{name}-%{version}/files
%defattr(-,root,root)
%doc README ChangeLog license.terms
