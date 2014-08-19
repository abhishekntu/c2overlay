#---------------
# scrolledlistbox.tcl
#---------------
#
# by William J Giddings, 2006.
#
# Description:
# -----------
# Display a scrolled list box, pick, then perform some follow up action.
#
# Usage:
# -----
# See demo code below
#
# Note:
# -----
# It is possible to only select a single value. Thus, it cannot be used 
# with -selectmode multiple.
#
#---------------

proc scrolledlistbox {w values cmd args} {
  frame $w
  eval listbox $w.list $args
  $w.list configure -yscrollcommand "$w.scrl set"
  scrollbar $w.scrl -command "$w.list yview"
  pack $w.scrl -side right -fill y
  pack $w.list -side left -fill both -expand 1

  set j true
  set indx 0
  foreach i $values {
    $w.list insert end $i
    if {$j} {
      set j false
      $w.list itemconfigure $indx -background #ffffdd
    } else {
      set j true
    }
    incr indx
  }
  # bindings
  #
  # this will obtain the item clicked, and then pass
  # the value onto the proc specified in the variable cmd.

  eval "bind $w.list <ButtonRelease-1> \{$cmd \[\%\W get \@\%x,\%y\]\}"

  # return the widget path
  return $w
}

#---------------
# demo stuff
#---------------
proc cmd {a} { puts ">>> $a" }

console show
set values {one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen}

set aa {-}
pack [scrolledlistbox .slb $values cmd -font {Arial 12} ] -fill both -expand 1
