#!/bin/sh
# the next line restarts using tclsh \
exec wish "$0" "$@"

proc Scrolled_Listbox { f args } {
   frame $f
#   listbox $f.list \
#      -xscrollcommand [list Scroll_Set $f.xscroll \
#         [list grid $f.xscroll -row 1 -column 0 -sticky we]] \
#      -yscrollcommand [list Scroll_Set $f.yscroll \
#         [list grid $f.yscroll -row 0 -column 1 -sticky ns]]
   listbox $f.list -xscrollcommand {$f.xscroll set} -yscrollcommand {list $f.yscroll set}
   eval {$f.list configure} $args
   scrollbar $f.xscroll -orient horizontal \
      -command [list $f.list xview]
   scrollbar $f.yscroll -orient vertical \
      -command [list $f.list yview]
   grid $f.list -sticky news
   grid rowconfigure $f 0 -weight 1
   grid columnconfigure $f 0 -weight 1
   return $f.list
}

set l [Scrolled_Listbox .fsl -listvariable fonts]
pack .fsl -expand yes -fill both
set fonts [lsort -dictionary [font families]]
