#---------------
# popup.tcl
#---------------
# Created by William J Giddings, 2006.
#
# This package acts a simple template for adding popups
# to any TK applicaiton.
#
# Description:
# -----------
# A private namespace contains an array of list which
# define each menu item using standard definitions.
#
# Usage:
# -----
# See demo proc for example
#---------------

#!/bin/sh
# the next line restarts using tclsh \
exec wish "$0" "$@"


# some package defaults
set DEMO(popup) yes
set DEBUG(popup) no

# create some menu icons
image create photo im_new    -data "R0lGODlhEAAQAMQAAP////f33e/v9+3t1+rr6+fnztzcxtjWvdbOvdTQyMrJubm5qKmqmJiYh4yUiXh4dmZmZFZWVDY2NTIyKSUlIwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACwAAAAAEAAQAAAFYGAijklFnmfFmChZVYZBteULxwXrPhByHIZCYYKqECaLn3AQ0ImMAoniUBgwmy5CQOKgWq86Y8SBCFoDaGytAVym0a9nLFh9BwzxEq7+zj+/fU4jFQtpfi0VASs0KYIjIQA7"
image create photo im_copy   -data "R0lGODlhEAAQAIUAAFxaXPwCBNze3GxubERCRPz+/Pz29Pzy5OTe3LS2tAQCBPTq3PTizLyulKyqrOzexLymhLy+vPTy9OzWvLyifMTCxHRydOzSrLyihPz6/OTKpLyabOzu7OTm5MS2nMSqjKSipDQyNJyenLSytOTi5NTS1JyanNTW1JSWlLy6vKyurAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAAEALAAAAAAQABAAAAaUQIBwCAgYj0eAYLkcEJBIZWFaGBie0ICUOnBiowKq4YBIKIbJcGG8YDQUDoHTKGU/HhBFpHrVIiQHbQ8TFAoVBRZeSoEIgxcYhhkSAmZKghcXGht6EhwdDmcRHh4NHxgbmwkcCwIgZwqwsbAhCR0CCiIKWQAOCQkjJAolJrpQShK2wicoxVEJKSMqDiAizLuysiF+QQAh/mhDcmVhdGVkIGJ5IEJNUFRvR0lGIFBybyB2ZXJzaW9uIDIuNQ0KqSBEZXZlbENvciAxOTk3LDE5OTguIEFsbCByaWdodHMgcmVzZXJ2ZWQuDQpodHRwOi8vd3d3LmRldmVsY29yLmNvbQA7"
image create photo im_cut    -data "R0lGODlhEAAQAIEAAPwCBAQCBPz+/ISChCH5BAEAAAAALAAAAAAQABAAAAIwhI9pwaHrGFRBNDdPlYB3bWHQ1YXPtYln+iCpmqCDp6El7Ylsp6ssR1uYSKuW0V8AACH+aENyZWF0ZWQgYnkgQk1QVG9HSUYgUHJvIHZlcnNpb24gMi41DQqpIERldmVsQ29yIDE5OTcsMTk5OC4gQWxsIHJpZ2h0cyByZXNlcnZlZC4NCmh0dHA6Ly93d3cuZGV2ZWxjb3IuY29tADs="
image create photo im_delete -data "R0lGODlhEAAQAIUAAPwCBFxaXNze3Ly2rJyanPz+/Ozq7GxqbPT29GxubMzOzDQyNIyKjHRydERCROTi3IyKhPz29Ox6bPzCxPzy7PTm3NS6rIQCBMxCNPTq3PTi1PTezMyynPTm1PTaxOzWvMyulOzGrMymhPTq5OzOtNTKxNTOzNTCtNS+rMSehAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAAAALAAAAAAQABAAAAaKQAAgQCwahcihYMkcBAiBpLJApRoOBWgyIKhSEQkFgrBAcr1URiPhKAsDD3QB8RhA3FM0IlLHnyUTVBMSFBUWfl0XGBMTGBcZGodmcQWKjpAbHIgIBY2LHRoempOdjooTGx8giIOPFYofISJ+DyMXI6AfFySyfiUmJSUnKBYcICIpfgELzM3OZX5BACH+aENyZWF0ZWQgYnkgQk1QVG9HSUYgUHJvIHZlcnNpb24gMi41DQqpIERldmVsQ29yIDE5OTcsMTk5OC4gQWxsIHJpZ2h0cyByZXNlcnZlZC4NCmh0dHA6Ly93d3cuZGV2ZWxjb3IuY29tADs="
image create photo im_paste  -data "R0lGODlhEAAQAIUAAPwCBCQiFHRqNIx+LFxSBDw6PKSaRPz+/NTOjKyiZDw+POTe3AQCBIR2HPT23Ly2dIR2FMTCxLS2tCQmJKSipExGLHx+fHR2dJyenJyanJSSlERCRGRmZNTW1ERGRNze3GxubBweHMzOzJSWlIyOjHRydPz29MzKzIyKjPTq3Ly2rLy+vISGhPzy5LymhISChPTizOzWvKyurPTexOzSrDQyNHx6fCwuLGxqbOzKpMSabAQGBMS2nLyulMSidAAAACH5BAEAAAAALAAAAAAQABAAAAa7QIBQGBAMCMMkoMAsGA6IBKFZECoWDEbDgXgYIIRIRDJZMigUMKHCrlgul7KCgcloNJu8fsMpFzoZgRoeHx0fHwsgGyEACiIjIxokhAeVByUmG0snkpIbC5YHF4obBREkJCgon5YmKQsqDAUrqiwsrAcmLSkpLrISLC/CrCYOKTAxvgUywhYvGx+6xzM0vjUSNhdvn7zIMdUMNxw4IByKH8fINDk6DABZWTsbYzw9Li4+7UoAHvD+4X6CAAAh/mhDcmVhdGVkIGJ5IEJNUFRvR0lGIFBybyB2ZXJzaW9uIDIuNQ0KqSBEZXZlbENvciAxOTk3LDE5OTguIEFsbCByaWdodHMgcmVzZXJ2ZWQuDQpodHRwOi8vd3d3LmRldmVsY29yLmNvbQA7"
image create photo im_redo   -data "R0lGODlhEAAQAIUAAPwCBBxOHBxSHBRGHKzCtNzu3MTSzBQ2FLzSxIzCjCSKFCyeHDzCLAxGHAwuFDSCNBxKLES+NHSmfBQ6FBxWJAQaDAQWFAw+HDSyLJzOnISyjMTexAQOBAwmDAw+FMzizAQODDymNKzWrAQKDAwaDEy6TFTGTFSyXDyKTAQCBAwiFBQyHAwSFAwmHAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAAAALAAAAAAQABAAAAZ2QIBwSCwaj0hAICBICgcDQsEgaB4PiIRiW0AEiE3sdsFgcK2CBsCheEAcjgYjoigwJRM2pUK0XDAKGRobDRwKHUcegAsfExUdIEcVCgshImojfEUkCiUmJygHACkqHEQpqKkpogAgK5FOQywtprFDKRwptrZ+QQAh/mhDcmVhdGVkIGJ5IEJNUFRvR0lGIFBybyB2ZXJzaW9uIDIuNQ0KqSBEZXZlbENvciAxOTk3LDE5OTguIEFsbCByaWdodHMgcmVzZXJ2ZWQuDQpodHRwOi8vd3d3LmRldmVsY29yLmNvbQA7"
image create photo im_undo   -data "R0lGODlhEAAQAIUAAPwCBBxSHBxOHMTSzNzu3KzCtBRGHCSKFIzCjLzSxBQ2FAxGHDzCLCyeHBQ+FHSmfAwuFBxKLDSCNMzizISyjJzOnDSyLAw+FAQSDAQeDBxWJAwmDAQOBKzWrDymNAQaDAQODAwaDDyKTFSyXFTGTEy6TAQCBAQKDAwiFBQyHAwSFAwmHAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAAAALAAAAAAQABAAAAZ1QIBwSCwaj0hiQCBICpcDQsFgGAaIguhhi0gohIsrQEDYMhiNrRfgeAQC5fMCAolIDhD2hFI5WC4YRBkaBxsOE2l/RxsHHA4dHmkfRyAbIQ4iIyQlB5NFGCAACiakpSZEJyinTgAcKSesACorgU4mJ6uxR35BACH+aENyZWF0ZWQgYnkgQk1QVG9HSUYgUHJvIHZlcnNpb24gMi41DQqpIERldmVsQ29yIDE5OTcsMTk5OC4gQWxsIHJpZ2h0cyByZXNlcnZlZC4NCmh0dHA6Ly93d3cuZGV2ZWxjb3IuY29tADs="

# define package namespace
namespace eval popup {
  set VERSION 0.1
}

#define menus, works for cascades too..
set ::popup::menu(main) {
  {cascade -label "New" -hidemargin 0 -compound left -image im_new -command {.txt1 delete 1.0 end}}
  {cascade -label "Edit" -menu .edit}
  {separator}
  {command -label Exit -command exit}
}
set ::popup::menu(edit) {
  {command -label Undo -hidemargin 0 -compound left -image im_undo -command {event generate [focus] <<Undo>>}}
  {command -label Redo -hidemargin 1 -compound left -image im_redo -command {event generate [focus] <<Redo>>}}
  {separator}
  {command -label Cut   -compound left -image im_cut   -command {event generate [focus] <<Cut>>}}
  {command -label Copy  -compound left -image im_copy  -command {event generate [focus] <<Copy>>}}
  {command -label Paste -compound left -image im_paste -command {event generate [focus] <<Paste>>}}
}
set ::popup::menu(file) {
  {command -label Open -command {File:Open .txt}}
  {command -label Save -command {File:Reload .txt}}
  {command -label Save -command {File:Save .txt}}
}

#----------------
# create menu (m) with from list of supplied items (a)
#---------------
proc popup::create {m} {

  set c $m
  set m ".[string tolower $m]"

  # destroy any pre-exising menu with the same name
  destroy $m

  # create new menus
  menu $m -tearoff 0
  foreach i $popup::menu($c) {
    eval $m add $i
  }
}

#---------------
# display the popup menu adjacent to the current pointer location
#---------------
proc popup::show {w m} {

  set m ".[string tolower $m]"

  # set w [winfo parent $m]
  # lassign [winfo pointerxy $w] x y
  foreach {x y} [winfo pointerxy $w] {}

  set ::active(tag) $m
  #get active ta
  tk_popup $m $x $y
}

 # end of package -----------------------------------------------------

#---------------
# the ubiquitous demo
#---------------
proc demo {} {

  wm title . "Popup($::popup::VERSION):"

  # build simple GUI
  console show
  pack  [text .txt1 -undo yes -font {Palatino 12} -height 10 -width 25 -bg #ffffff] -fill both -expand 1 -side top -anchor nw

  .txt1 insert end "Cut-n Paste Me."

  popup::create main
  popup::create edit

  # add some odd bindings just to test the packacge
  bind .txt1 <Button-3> {popup::show %W Main}

  focus -force .txt1

  #---------------
  # let our menus do something...
  #---------------
  proc demoStub {str} {
    set w [focus]
    $w insert end $str\n
  }
}

if {$DEMO(popup)} {demo} else { proc demo {} {} }

# EOF
