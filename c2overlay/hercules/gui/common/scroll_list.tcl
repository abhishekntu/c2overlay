#!/bin/sh
# the next line restarts using tclsh \
exec wish "$0" "$@"

proc scroll_list {w name} {
  frame $w
  label $w.label -text "$name" -anchor w

  scrollbar $w.v -command "$w.listbox yview"
  scrollbar $w.h -orient horizontal -command "$w.listbox xview"

  listbox $w.listbox \
  -xscrollcommand "$w.h set" -yscrollcommand "$w.v set" 

  pack $w.v -side right -fill y -pady 19
  pack $w.h -side bottom -fill x
  pack $w.label -fill x -anchor w -ipadx 2
  pack $w.listbox -expand 1 -fill both

  return $w
}

pack [scroll_list .f "f list"] -expand 1 -fill both
