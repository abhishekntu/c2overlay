# -*- tcl -*-

# This file holds the commands determining the files to install. They
# are used by the installer to actually perform the installation, and
# by 'sak' to get the per-module lists of relevant files. The
# different purposes are handled through the redefinition of the
# commands [xcopy] and [xcopyf] used by the commands here.

proc _null {args} {}

proc _tcl {module libdir} {
    global distribution
    xcopy \
	    [file join $distribution modules $module] \
	    [file join $libdir $module] \
	    0 *.tcl
    return
}

proc _tab {module libdir} {
    global distribution

    _tcl $module $libdir

    xcopy \
	    [file join $distribution modules $module images] \
	    [file join $libdir $module images] \
	    0 *

    xcopy \
	    [file join $distribution modules $module scripts] \
	    [file join $libdir $module scripts] \
	    0 *.tcl

    xcopyfile \
	[file join $distribution modules $module scripts tclIndex] \
	[file join $libdir $module scripts]

    return
}

proc _ctxt {module libdir} {
    global distribution
    xcopy \
	    [file join $distribution modules $module] \
	    [file join $libdir $module] \
	    0 ctext.tcl
    xcopy \
	    [file join $distribution modules $module] \
	    [file join $libdir $module] \
	    0 pkgIndex.tcl
    return
}

proc _doc {module libdir} {
    global distribution

    _tcl $module $libdir
    xcopy \
	    [file join $distribution modules $module mpformats] \
	    [file join $libdir $module mpformats] \
	    1
    return
}

proc _tex {module libdir} {
    global distribution

    _tcl $module $libdir
    xcopy \
	    [file join $distribution modules $module] \
	    [file join $libdir $module] \
	    0 *.tex
    return
}

proc _tci {module libdir} {
    global distribution

    _tcl $module $libdir
    xcopyfile [file join $distribution modules $module tclIndex] \
	    [file join $libdir $module]
    return
}

proc _man {module format ext docdir} {
    global distribution argv argc argv0 config

    package require doctools
    ::doctools::new dt -format $format -module $module

    foreach f [glob -nocomplain [file join $distribution modules $module *.man]] {

	set out [file join $docdir [file rootname [file tail $f]]].$ext

	log "Generating $out"
	if {$config(dry)} {continue}

	dt configure -file $f
	file mkdir [file dirname $out]

	set data [dt format [get_input $f]]
	switch -exact -- $format {
	    nroff {
		set data [string map \
			[list \
			{.so man.macros} \
			$config(man.macros)] \
			$data]
	    }
	    html {}
	}
	write_out $out $data

	set warnings [dt warnings]
	if {[llength $warnings] > 0} {
	    log [join $warnings \n]
	}
    }
    dt destroy
    return
}

proc _exa {module exadir} {
    global distribution
    xcopy \
	    [file join $distribution examples $module] \
	    [file join $exadir $module] \
	    1
    return
}
