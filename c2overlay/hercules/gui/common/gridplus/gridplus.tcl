#=======================================================================#
# SCRIPT : gridplus.tcl                                                 #
# PURPOSE: Gridplus layout manager.                                     #
# AUTHOR : Adrian Davis                                                 #
# VERSION: 2.4                                                          #
# DATE   : 05/02/2009                                                   #
#-----------------------------------------------------------------------#
# HISTORY: 2.0 07/10/2006 - First release of Tile based GRIDPLUS.       #
#        : 2.1 24/02/2007 - Enchanced gpmap: Array mapping.             #
#        :                - Documents gpinsert and gpselect.            #
#        :                - Adds Container.                             #
#        :                - Removes special main/title condition.       #
#        :                - Adds notebook "-command" option.            #
#        :                - Fix tablelist sort problem.                 #
#        :                - Adds text "-font" option.                   #
#        : 2.2 22/07/2007 - Change gpmap to set dropdown value not list.#
#        :                - Adds "-icons" option for tree.              #
#        :                - Fix padding problem in layout.              #
#        :                - Fix "container".                            #
#        :                - Changes "gridplus window" for container.    #
#        : 2.3 15/05/2008 - Adds Find dialog to text pop-up menu.       #
#        :                - Adds "-labelanchor" option.                 #
#        :                - Adds "-validateauto" option.                #
#        :                - Adds "-validate" for tablelist/tree.        #
#        :                - Adds option to specify an event to "-ecmd". #
#        :                - Adds option to fix maximum entry characters.#
#        :                - Adds "popup" validation error messages.     #
#        :                - Adds "?!" help text set to validation text. #
#        :                - Adds menu "underline" option.               #
#        :                - Adds gpfind_dialog.                         #
#        :                - Adds gpfind, gpclear, gpcut, gpcopy, gppaste#
#        :                - Adds "-topmost" option to "gridplus window".#
#        :                - Adds "-columnformat & -cfmt".               #
#        :                - Change menu "=" as separator.               #
#        :                - Change menu allow "~" to indicate command.  #
#        :                - Fix problem with date validations.          #
#        :                - Fix Validation in contained window problem. #
#        : 2.4 05/02/2009 - Adds "-columnstretch".                      #
#        :                - Adds "-basename".                           #
#        :                - Adds new syntax for embedded grids.         #
#        :                - Adds #style" widget option.                 #
#        :                - Adds radiobutton groups.                    #
#        :                - Adds "gridplus define".                     #
#        :                - Adds resize options to layout and "pack"    #
#        :                  command mode.                               #
#        :                - Adds "-command" to text - Triggered when    #
#        :                  text is modified.                           #
#        :                - Fix validate popup for toplevel windows.    #
#        :                - Fix for "gpEditMenu" in contained windows.  #
#        :                - Fix problem with validation for command     #
#        :                  invoked by pressing enter in entry. If a    #
#        :                  field has both a command and a validation   #
#        :                  specified, the validation will always be    #
#        :                  done when a command specified for the entry #
#        :                  is invoked.                                 #
#        :                - Fix problem setting dropdown using gpmap.   #
#        :                - "gpselect" modified to "see" tablelist row. #
#        :                - Fix date validations.                       #
#        :                - Fix validation popup in notebooks.          #
#        :                - Fix problem displaying label text when      #
#        :                  default widget is button/link/menubutton.   #
#=======================================================================#

package require Tk 8.5

package require msgcat
namespace import msgcat::*

#catch {package require icons}
source "./common/icons1.0/icons.tcl"
catch {package require tablelist_tile}

package provide gridplus 2.4

#=======================================================================#
# Export the public interface.                                          #
#=======================================================================#

namespace eval ::gridplus:: {
   namespace export gridplus
   namespace export gpcopy
   namespace export gpclear
   namespace export gpcut
   namespace export gpfind
   namespace export gpfind_dialog
   namespace export gpinsert
   namespace export gpmap
   namespace export gppaste
   namespace export gpselect
   namespace export gpset
   namespace export gpunset
   variable gpWidgetHelp
   variable gpConfig
   variable gpFocus
   variable gpGroup
   variable gpGroupState
   variable gpInfo
   variable gpOptionSets
   variable gpTabOrder
   variable gpValidate
   variable gpValidateError
   variable gpValidations
   variable gpUnknown
}

#=======================================================================#
# PROC   : ::gridplus::gridplus                                         #
# PURPOSE: Exported command.                                            #
#=======================================================================#

proc ::gridplus::gridplus {args} {
   variable gpConfig
   variable gpUnknown

   # If first call run initialisation.
   if {! [info exists gpConfig]} {
      gpInit
   }

   # Set array of valid/default options.
   array set options [list                                                          \
      -action             none                                                      \
      -anchor             [gpGetOption Gridplus.anchor s]                           \
      -autogroup          [gpGetOption Gridplus.autoGroup {}]                       \
      -attach             [gpGetOption Gridplus.attach {}]                          \
      -background         [gpGetOption Gridplus.background {}]                      \
      -borderwidth        [gpGetOption Gridplus.borderWidth 2]                      \
      -basename           {}                                                        \
      -ccmd               {}                                                        \
      -century            $gpConfig(date:century)                                   \
      -cfmt               [gpGetOption Gridplus.columnFormat {}]                    \
      -checkbuttoncommand {}                                                        \
      -columnformat       [gpGetOption Gridplus.columnFormat {}]                    \
      -columnsort         [gpGetOption Gridplus.columnSort 1]                       \
      -command            {}                                                        \
      -compound           left                                                      \
      -dateformat         $gpConfig(dateformat)                                     \
      -dcmd               {}                                                        \
      -dropdowncommand    {}                                                        \
      -ecmd               [gpGetOption Gridplus.entryCommand {}]                    \
      -entrycommand       [gpGetOption Gridplus.entryCommand {}]                    \
      -errormessage       $gpConfig(errormessage)                                   \
      -fileicon           [gpGetOption Gridplus.fileIcon file]                      \
      -fixed              [gpGetOption Gridplus.fixed 999999]                       \
      -foldericon         [gpGetOption Gridplus.folderIcon folder]                  \
      -font               [gpGetOption Gridplus.font {}]                            \
      -foreground         [gpGetOption Gridplus.foreground black]                   \
      -group              {}                                                        \
      -height             [gpGetOption Gridplus.height 10]                          \
      -icon               [gpGetOption Gridplus.icon {}]                            \
      -iconfile           $gpConfig(iconfile)                                       \
      -iconpath           $gpConfig(iconpath)                                       \
      -icons              [gpGetOption Gridplus.icons 1]                            \
      -in                 {}                                                        \
      -insertexpr         {}                                                        \
      -insertoptions      {}                                                        \
      -justify            left                                                      \
      -labelanchor        [gpGetOption Gridplus.labelAnchor {}]                     \
      -labelcolor         [gpGetOption Gridplus.labelColor /]                       \
      -labelstyle         [gpGetOption Gridplus.labelStyle /]                       \
      -linerelief         [gpGetOption Gridplus.lineRelief sunken]                  \
      -linewidth          [gpGetOption Gridplus.lineWidth 2]                        \
      -linkcolor          [gpGetOption Gridplus.linkColor black/black]              \
      -linkcursor         [gpGetOption Gridplus.linkCursor arrow]                   \
      -linkstyle          [gpGetOption Gridplus.linkStyle /underline]               \
      -listvariable       {}                                                        \
      -menu               {}                                                        \
      -minx               100                                                       \
      -miny               100                                                       \
      -modal              0                                                         \
      -open               [gpGetOption Gridplus.open 0]                             \
      -optionset          {}                                                        \
      -pad                [gpGetOption Gridplus.pad 5]                              \
      -padding            [gpGetOption Gridplus.padding {5 5 5 5}]                  \
      -padx               [gpGetOption Gridplus.padX [gpGetOption Gridplus.pad 5]]  \
      -pady               [gpGetOption Gridplus.padY [gpGetOption Gridplus.pad 5]]  \
      -pattern            {}                                                        \
      -prefix             $gpConfig(prefix)                                         \
      -proc               $gpConfig(proc)                                           \
      -radiobuttoncommand {}                                                        \
      -rcmd               {}                                                        \
      -relief             [gpGetOption Gridplus.relief flat]                        \
      -resize             {}                                                        \
      -scroll             none                                                      \
      -selectfirst        0                                                         \
      -selectmode         [gpGetOption Gridplus.selectMode browse]                  \
      -show               [gpGetOption Gridplus.show tree]                          \
      -sortfirst          0                                                         \
      -sortorder          increasing                                                \
      -space              [gpGetOption Gridplus.space 20]                           \
      -spacestretch       {}                                                        \
      -state              normal                                                    \
      -sticky             [gpGetOption Gridplus.sticky {}]                          \
      -stretch            {}                                                        \
      -style              {}                                                        \
      -subst              [gpGetOption Gridplus.subst 1]                            \
      -tableoptions       {}                                                        \
      -taborder           column                                                    \
      -takefocus          1                                                         \
      -tags               0                                                         \
      -text               {}                                                        \
      -title              {}                                                        \
      -topmost            [gpGetOption Gridplus.topmost 0]                          \
      -validate           [gpGetOption Gridplus.validate 0]                         \
      -validateauto       [gpGetOption Gridplus.validateAuto 1]                     \
      -validatepopup      [gpGetOption Gridplus.validatePopup 0]                    \
      -validation         {}                                                        \
      -variables          1                                                         \
      -wcmd               {}                                                        \
      -widget             [gpGetOption Gridplus.widget grid]                        \
      -width              [gpGetOption Gridplus.width 40]                           \
      -windowcommand      {}                                                        \
      -wrap               word                                                      \
      -wraplength         0                                                         \
      -wtitle             {}                                                        \
   ]

   # Read mode.
   set mode [lindex $args 0]

   # Validate mode and set parameter template.
   switch -- $mode {
      add         {set argTemplate [list "name 1" "options 2 end"]}
      button      {set argTemplate [list "name 1" "options 2 end-1" "layout end"];set options(-width) [gpGetOption Gridplus.widgetWidth 10]}
      checkbutton {set argTemplate [list "name 1" "options 2 end-1" "layout end"];set options(-width) [gpGetOption Gridplus.widgetWidth 10]}
      clear       {set argTemplate [list "name 1" "options 2 end"]}
      container   {set argTemplate [list "name 1" "options 2 end"];set options(-height) [gpGetOption Gridplus.containerHeight 200];set options(-width) [gpGetOption Gridplus.containerWidth 250]}
      define      {set argTemplate [list "layout 1"]}
      dropdown    {set argTemplate [list "name 1" "options 2 end-1" "layout end"];set options(-width) [gpGetOption Gridplus.widgetWidth 10]}
      entry       {set argTemplate [list "name 1" "options 2 end-1" "layout end"];set options(-width) [gpGetOption Gridplus.widgetWidth 10]}
      goto        {set argTemplate [list "name 1" "options 2 end-1" "layout end"]}
      grid        {set argTemplate [list "name 1" "options 2 end-1" "layout end"]}
      init        {set argTemplate [list "options 1 end"]}
      layout      {set argTemplate [list "name 1" "options 2 end-1" "layout end"]}
      line        {set argTemplate [list "name 1" "options 2 end"]}
      link        {set argTemplate [list "name 1" "options 2 end-1" "layout end"];set options(-width) [gpGetOption Gridplus.widgetWidth 10]}
      menu        {set argTemplate [list "name 1" "options 2 end-1" "layout end"]}
      menubutton  {set argTemplate [list "name 1" "options 2 end-1" "layout end"];set options(-width) [gpGetOption Gridplus.widgetWidth 10]}
      notebook    {set argTemplate [list "name 1" "options 2 end-1" "layout end"]}
      optionset   {set argTemplate [list "name 1" "options 2 end-1" "layout end"]}
      pack        {set argTemplate [list "name 1" "options 2 end"]}
      radiobutton {set argTemplate [list "name 1" "options 2 end-1" "layout end"];set options(-width) [gpGetOption Gridplus.widgetWidth 10]}
      set         {set argTemplate [list "options 1 end"]}
      tablelist   {set argTemplate [list "name 1" "options 2 end-1" "layout end"];set options(-width) [gpGetOption Gridplus.tableWidth 40]}
      text        {set argTemplate [list "name 1" "options 2 end"];set options(-width) [gpGetOption Gridplus.textWidth 40]}
      tree        {set argTemplate [list "name 1" "options 2 end"];set options(-width) [gpGetOption Gridplus.treeWidth 200]}
      widget      {set argTemplate [list "name 1" "options 2 end-1" "layout end"];set options(-width) [gpGetOption Gridplus.widgetWidth 10]}
      window      {set argTemplate [list "name 1" "options 2 end"]}
      default     {error "GRIDPLUS ERROR: Invalid mode ($mode)"}
   }

   # Check if sufficient args.
   if {[llength $args] < [llength $argTemplate]} {
      error "GRIDPLUS ERROR: Wrong number of Args."
   }

   # Check if sufficient args remain for option/value pairs.
   if {$mode ne "define" && [expr {([llength $args] - [llength $argTemplate]) % 2}] != 0} {
      error "GRIDPLUS ERROR: Unmatched option/value."
   }

   # Unset gpUnknown.
   if {[info exists gpUnknown]} {
      unset gpUnknown
   }

   # Read/validate arguments.
   foreach template $argTemplate {
      set argName  [lindex $template 0]
      set argStart [lindex $template 1]
      set argEnd   [lindex $template 2]
      # If argName is "options" read option/value pairs.
      if {$argName eq "options"} {
         foreach {option value} [lrange $args $argStart $argEnd] {
            if {[info exists options($option)]} {
               switch -- $option {
                  -pad {
                     set options(-padx) $value
                     set options(-pady) $value
                  }
                  -title {
                     set options(-title) $value
                     if {$options(-title) ne ""} {
                        set options(-relief) theme
                     }
                  }
                  default {
                     set options($option) $value
                  }
               }
            } else {
               if {[gpGetOption Gridplus.unknown 1]} {
                  set gpUnknown($option) $value
               } else {
                  error "GRIDPLUS ERROR: Invalid option ($option)."
               }
            }
         }
      } else {
         set options($argName) [lindex $args $argStart]
      }
   }

   # Set optionset.
   gpSetOptionset

   # Remove blank lines from "layout".
   if {[info exists options(layout)]} {
      regsub -all -- {\n\n}                $options(layout) "\n" options(layout)
      regsub -all -- {(^\n)|(\n$)|(\n +$)} $options(layout) ""   options(layout)
   }

   # Call appropriate procedure according to specified mode.
   switch -- $mode {
      add         {gpAdd}
      button      {set options(-widget) b;gpWidget}
      checkbutton {set options(-widget) c;gpWidget}
      clear       {gpClear}
      container   {gpContainer}
      define      {gpDefine}
      dropdown    {set options(-widget) d;gpWidget}
      entry       {set options(-widget) e;gpWidget}
      goto        {gpGoto}
      grid        {gpGrid}
      layout      {gpLayout}
      line        {gpLine}
      link        {set options(-widget) l;gpWidget}
      menu        {gpMenu}
      menubutton  {set options(-widget) m;gpWidget}
      notebook    {gpNotebook}
      optionset   {gpOptionset}
      pack        {gpPack}
      radiobutton {set options(-widget) r;gpWidget}
      set         {gpSet}
      tablelist   {gpTablelist}
      text        {gpText}
      tree        {gpTree}
      widget      {gpWidget}
      window      {gpWindow}
   }

}

#=======================================================================#
# PROC   : ::gridplus::gpWidget                                         #
# PURPOSE: Create widget grid.                                          #
#=======================================================================#

proc ::gridplus::gpWidget {} {
   upvar 1 options globaloptions

   array set options [array get globaloptions]

   global {}

   variable gpConfig
   variable gpFocus
   variable gpGroup
   variable gpGroupState
   variable gpValidation
   variable gpValidations

   set normalColor     [lindex [split $options(-linkcolor) /] 0]
   set overColor       [lindex [split $options(-linkcolor) /] 1]
   set normalStyle     [lindex [split $options(-linkstyle) /] 0]
   set overStyle       [lindex [split $options(-linkstyle) /] 1]

   regsub      -- {[&]} $overStyle   $normalStyle, overStyle
   regsub -all -- {,}   $normalStyle { }           normalStyle
   regsub -all -- {,}   $overStyle   { }           overStyle

   if {! [string match */* $options(-linkcolor)]} {set overColor $normalColor}

   if {$normalColor eq ""} {set normalColor "black"}
   if {$overColor   eq ""} {set overColor   "black"}

   if {$options(-fixed) eq ""} {
      set defaultFixed $options(-width)
   } else {
      set defaultFixed $options(-fixed)
   }

   if {$options(-basename) eq ""} {
      set basename $options(name)
   } else {
      set basename $options(-basename)
   }

   set defaultWidget [string range $options(-widget) 0 0]
   set gridData      {}
   set rowCount      0
   set widgetID      1

   if {! [regexp -- {^[.]([^.]+)[.]} $options(name) -> window]} {
      set window {}
   }

   foreach row [split $options(layout) "\n"] {
      set columnCount 0
      foreach column $row {
         set action           0
         set autoGroup        $options(-autogroup)
         set autoGroupCommand {}
         set createWidget     0
         set doValidation     $options(-validate)
         set errorMessage     {}
         set fixed            $defaultFixed
         set gridColumn       {}
         set icon             0
         set itemFixed        {}
         set itemWidth        {}
         set radiobuttonGroup {}
         set secret           0
         set select           0
         set state            $options(-state)
         set style            $options(-style)
         set validate         all
         set validation       {}
         set validationName   {}
         set value            {}
         set widget           $defaultWidget
         set widgetHelp       {}
         set widgetText       {}
         set width            $options(-width)

         set column [::gridplus::gpDefineWidget      $column]
         set column [::gridplus::gpParseEmbeddedGrid $column]

         foreach item $column {
            switch -regexp -- $item {
               ^[&] {
                  set widgetLayout [lrange $item 1 end]
                  if {! [regexp {^[&]([^: ]+):([^ ]*)} $item -> widget style]} {
                     set widget [lindex [string range $item 1 end] 0]
                  }
                  if {! [regexp -- {^(w)(.)$} $widget -> widget widgetWidget]} {
                     set widgetWidget $defaultWidget
                  }
                  if {$widget in "w &" && $style eq ""} {
                     set style "{}"
                  }
                  if {$widget eq "d"} {
                     set state readonly
                  }
               }
               ^[.] {
                  set createWidget 1
                  if {[regexp -- {(^[.]$)|(^[.]:)} $item]} {
                     regsub -- {[.]} $item $options(name)-$widgetID item
                     incr widgetID
                  }
                  if {! [regexp {(^[^:]+)(:[nsewc]+$)} $item -> item sticky]} {set sticky {}}
                  if {$widget in "g w &"} {
                     set widgetName $item
                  } else {
                     set widgetName $basename,[string range $item 1 end]
                  }
                  if {$options(-group) ne ""} {set gpGroup($widgetName) $options(-group)}
                  lappend gridColumn $widgetName$sticky
               }
               ^: {
                  set icon       1
                  set widgetIcon [string range $item 1 end]
                  if {$widget eq "b" || $widget eq "m"} {
                     if {! $createWidget} {
                        set createWidget 1
                        set widgetName   $options(name),$widgetIcon
                        if {$options(-group) ne ""} {set gpGroup($widgetName) $options(-group)}  
                        lappend gridColumn $widgetName
                     }
                  } else {
                     lappend gridColumn $item%%
                  }
               }
               ^[0-9]+$ {
                  set width $item
               }
               ^([0-9]*)/([0-9]*)$ {
                  regexp -- {^([0-9]*)/([0-9]*)$} $item -> itemWidth itemFixed
                  if {$itemWidth eq ""} {
                     set width $options(-width)
                  } else {
                     set width $itemWidth
                  }
                  if {$itemFixed eq ""} {
                     set fixed $width
                  } else {
                     set fixed $itemFixed
                  }
               }
               ^@ {
                  set gridName .[string range $item 1 end]
                  lappend gridColumn $gridName
               }
               ^% {
                  set gpGroup($widgetName) [string range $item 1 end]
               }
               ^[+] {
                  if {$widget eq "l"} {
                     lappend gridColumn "\u2022"
                  } else {
                     set value  [string range $item 1 end]
                     set select 1
                  }
               }
               ^[-] {
                  if {$widget eq "l"} {
                     lappend gridColumn {}
                  } else {
                     set value  [string range $item 1 end]
                     set select 0
                  }
               }
               ^! {
                  if {$widget eq "e"} {
                     set validation [string range $item 1 end]
                     lappend gpValidations(.$window) $widgetName:$validation
                  }
                  set doValidation 1
               }
               ^[?] {
                  set widgetHelp [mc [string range $item 1 end]]
               }
               ^[|]$ {
                  lappend gridColumn $item
               }
               ^[=]$ {
                  lappend gridColumn $item
               }
               ^<$ {
                  if {$widget eq "e"} {
                     set state [gpGetOption Gridplus.entryDisabled readonly]
                  } else {
                     set state disabled
                  }
               }
               ^>$ {
                  set state normal
               }
               ^<.+ {
                  ::gridplus::gridplus set -group [string range $item 1 end] -state normal
                  set autoGroupCommand "::gridplus::gpAutoGroup $widgetName [string range $item 1 end] disabled"
               }
               ^>.+ {
                  ::gridplus::gridplus set -group [string range $item 1 end] -state disabled
                  set autoGroupCommand "::gridplus::gpAutoGroup $widgetName [string range $item 1 end] normal"
               }
               ^[*]$ {
                  set secret 1
               }
               ^[*].+ {
                  set radiobuttonGroup ",[string range $item 1 end]"
               }
               ^~ {
                  set action 1
                  set command [string range $item 1 end]
               }
               ^[#].* {
                  set style [string range $item 1 end]
               }
               default {
                  if {$widget eq "b" || $widget eq "l" || $widget eq "m"} {
                     if {[llength $column] > 1} {
                        set widgetText [mc $item]
                     } else {
                        lappend gridColumn $item
                     }
                  } else {
                     lappend gridColumn $item
                  }
               }
            }
         }

         switch -- $widget {
            b {
               #---------------#
               # Create button #
               #---------------#
               if {$createWidget} {

                  if {[info exists gpGroup($widgetName)] && [info exists gpGroupState($gpGroup($widgetName))]} {
                     set state $gpGroupState($gpGroup($widgetName))
                  }

                  if {[regexp -- {^([^=]*)=(.*)$} $widgetName -> buttonCommand buttonParameter]} {
                     set buttonCommand "$buttonCommand $buttonParameter"
                  } else {
                     set buttonCommand "$widgetName"
                  }

                  if {$action && $command ne ""} {
                     set buttonCommand $command
                  }

                  if {$options(-proc)} {
                     set command "set gridplus::gpFocus \[focus\];gpProc [::gridplus::gpCommandFormat $buttonCommand]"
                  } else {
                     set command "set gridplus::gpFocus \[focus\];$options(-prefix)[::gridplus::gpCommandFormat $buttonCommand]"
                  }

                  if {$icon} {
                     ::icons::icons create -file [file join $options(-iconpath) $options(-iconfile)] $widgetIcon
                     if {$widgetText eq ""} {
                        ::ttk::button $widgetName -command "::gridplus::gpCommand {$command} .$window $doValidation" -image ::icon::$widgetIcon -state $state -style $style -takefocus $options(-takefocus)
                     } else {
                        ::ttk::button $widgetName -command "::gridplus::gpCommand {$command} .$window $doValidation" -image ::icon::$widgetIcon -state $state -style $style -takefocus $options(-takefocus) -text $widgetText -width $width -compound $options(-compound)
                     }
                  } else {
                     ::ttk::button $widgetName -command "::gridplus::gpCommand {$command} .$window $doValidation" -state $state -style $style -takefocus $options(-takefocus) -text $widgetText -width $width
                  }
                  if {$state eq "disabled"} {$widgetName configure -takefocus 0}
               }
            }
            c {
               #--------------------#
               # Create checkbutton #
               #--------------------#
               if {$createWidget} {
                  if {[info exists gpGroup($widgetName)] && [info exists gpGroupState($gpGroup($widgetName))]} {
                     set state $gpGroupState($gpGroup($widgetName))
                  }
                  set ($widgetName)                0
                  set options(-checkbuttoncommand) [::gridplus::gpOptionAlias -checkbuttoncommand -ccmd]
                  ::ttk::checkbutton $widgetName -offvalue 0 -onvalue 1 -state $state -style $style -takefocus $options(-takefocus) -variable ($widgetName)
                  if {$state eq "disabled"} {$widgetName configure -takefocus 0}
                  if {$select} {$widgetName invoke}
                  if {$action} {
                     if {$command eq ""} {
                        set command $widgetName
                     }
                     if {$options(-proc)} {
                        set command "gpProc [::gridplus::gpCommandFormat $command]"
                     } else {
                        set command "$options(-prefix)[::gridplus::gpCommandFormat $command]"
                     }
                     $widgetName configure -command $command
                  } elseif {$options(-checkbuttoncommand) ne ""} {
                     if {$options(-proc)} {
                        set command "gpProc $options(-checkbuttoncommand)"
                     } else {
                        set command "$options(-prefix)$options(-checkbuttoncommand)"
                     }
                     $widgetName configure -command $command
                  }
               }
            }
            d {
               #-----------------------------#
               # Create dropdown (combo) box #
               #-----------------------------#
               if {$createWidget} {
                  if {[info exists gpGroup($widgetName)] && [info exists gpGroupState($gpGroup($widgetName))]} {
                     set state $gpGroupState($gpGroup($widgetName))
                  }
                  set ($widgetName)             {}
                  set options(-dropdowncommand) [::gridplus::gpOptionAlias -dropdowncommand -dcmd]
                  ::ttk::combobox $widgetName -state $state -style $style -takefocus $options(-takefocus) -textvariable ($widgetName) -values $value -width $width
                  if {$state eq "disabled"} {$widgetName configure -takefocus 0}
                  if {$select} {$widgetName set [lindex $value 0]}
                  if {$action} {
                     if {$command eq ""} {
                        set command $widgetName
                     }
                     if {$options(-proc)} {
                        set command "gpProc [::gridplus::gpCommandFormat $command]"
                     } else {
                        set command "$options(-prefix)[::gridplus::gpCommandFormat $command]"
                     }
                     bind $widgetName <<ComboboxSelected>> $command
                  } elseif {$options(-dropdowncommand) ne ""} {
                     if {$options(-proc)} {
                        set command "gpProc $options(-dropdowncommand)"
                     } else {
                        set command "$options(-prefix)$options(-dropdowncommand)"
                     }
                     bind $widgetName <<ComboboxSelected>> "$command"
                  }
               }
            }
            e {
               #--------------#
               # Create entry #
               #--------------#
               if {$createWidget} {
                  if {[info exists gpGroup($widgetName)] && [info exists gpGroupState($gpGroup($widgetName))]} {
                     set state $gpGroupState($gpGroup($widgetName))
                  }
                  set ($widgetName)          {}
                  set options(-entrycommand) [::gridplus::gpOptionAlias -entrycommand -ecmd]
                  if {$validation eq ""} {
                     set validation __gpFixed__
                  } else {
                     ::gridplus::gpValidateErrorInit $widgetName [::gridplus::gpValidateText $validation]
                  }
                  ::ttk::entry $widgetName -invalidcommand "::gridplus::gpValidateFailed %W" -state $state -style $style -takefocus $options(-takefocus) -textvariable ($widgetName) -validate $validate -validatecommand "::gridplus::gpValidate %W \"$validation\" %V %P $fixed $options(-validateauto)" -width $width
                  if {$state eq "disabled"} {$widgetName configure -background lightgray -takefocus 0}
                  if {$action} {
                     if {$command eq ""} {
                        set command $widgetName
                     }
                     if {$options(-proc)} {
                        set command "gpProc [::gridplus::gpCommandFormat $command]"
                     } else {
                        set command "$options(-prefix)[::gridplus::gpCommandFormat $command]"
                     }
                     if {[string match <*> $command]} {
                        bind $widgetName <Return> "event generate $widgetName $command"
                     } elseif {[string match "<*> *" $command]} {
                        regsub -all {:} $command "." command
                        bind $widgetName <Return> "event generate [lindex $command 1] [lindex $command 0]"
                     } else {
                         bind $widgetName <Return> "::gridplus::gpCommand {$command} .$window $doValidation"
                     }
                  } elseif {$options(-entrycommand) ne ""} {
                     if {$options(-proc)} {
                        set command "gpProc $options(-entrycommand)"
                     } else {
                        set command "$options(-prefix)$options(-entrycommand)"
                     }
                     if {[string match <*> $command]} {
                        bind $widgetName <Return> "event generate $widgetName $command"
                     } elseif {[string match "<*> *" $command]} {
                        regsub -all {:} $command "." command
                        bind $widgetName <Return> "event generate [lindex $command 1] [lindex $command 0]"
                     } else {
                        bind $widgetName <Return> "::gridplus::gpCommand {$command} .$window $doValidation"
                     }
                  }
                  if {$autoGroup ne "" && $autoGroupCommand eq ""} {
                     set autoGroupCommand "::gridplus::gpAutoGroup $widgetName $autoGroup normal"
                  }
                  if {$autoGroupCommand ne ""} {
                     trace add variable ($widgetName) write $autoGroupCommand
                  }
                  if {$options(-validatepopup) && $validation ne "__gpFixed__"} {
                     ::gridplus::gpValidateErrorInit $widgetName [::gridplus::gpValidateText $validation] popup
                  }
                  if {$widgetHelp eq "!"} {
                     set widgetHelp [::gridplus::gpValidateText $validation]
                  }
                  if {$secret} {$widgetName configure -show "*"}
                  if {$select} {focus $widgetName}

                  bind $widgetName <Button-3> "::gridplus::gpEntryEdit \"$window\" %X %Y"
               }
            }
            l {
               #-------------#
               # Create link #
               #-------------#
               if {$createWidget} {
                  if {$icon} {
                     regsub -- {(:[^:]*)%%} $gridColumn "\\1:$widgetName:$doValidation" gridColumn
                  }

                  if {$options(-proc)} {
                     set command "set gridplus::gpFocus \[focus\];gpProc [::gridplus::gpCommandFormat $widgetName]"
                  } else {
                     set command "set gridplus::gpFocus \[focus\];$options(-prefix)[::gridplus::gpCommandFormat $widgetName]"
                  }

                  ::ttk::label $widgetName -background $options(-background) -foreground $options(-foreground) -text [mc $widgetText]

                  set normalFont [::gridplus::gpSetFont $normalStyle]
                  set overFont   [::gridplus::gpSetFont $overStyle]

                  $widgetName configure -font $normalFont -foreground $normalColor

                  bind $widgetName <Enter>           "$widgetName configure -font \"$overFont\" -foreground $overColor -cursor $options(-linkcursor)"
                  bind $widgetName <Leave>           "$widgetName configure -font \"$normalFont\" -foreground $normalColor -cursor {}"
                  bind $widgetName <ButtonRelease-1> "eval \"::gridplus::gpCommand {$command} .$window $doValidation\""
               } else {
                 lappend gridColumn $widgetText
               }
            }
            m {
               #-------------------#
               # Create menubutton #
               #-------------------#
               if {$createWidget} {
                  if {[info exists gpGroup($widgetName)] && [info exists gpGroupState($gpGroup($widgetName))]} {
                     set state $gpGroupState($gpGroup($widgetName))
                  }

                  set menuName "$widgetName:menu"

                  if {$icon} {
                     ::icons::icons create -file [file join $options(-iconpath) $options(-iconfile)] $widgetIcon
                     if {$widgetText eq ""} {
                        ::ttk::menubutton $widgetName -menu $menuName -image ::icon::$widgetIcon -state $state -style $style -takefocus $options(-takefocus)
                     } else {
                        ::ttk::menubutton $widgetName -menu $menuName -image ::icon::$widgetIcon -state $state -style $style -takefocus $options(-takefocus) -text $widgetText -width $width -compound $options(-compound)
                     }
                  } else {
                     ::ttk::menubutton $widgetName -menu $menuName -state $state -style $style -takefocus $options(-takefocus) -text $widgetText -width $width
                  }
                  if {$state eq "disabled"} {$widgetName configure -takefocus 0}
               }
            }
            r {
               #--------------------#
               # Create radiobutton #
               #--------------------#
               if {$createWidget} {
                  if {[info exists gpGroup($widgetName)] && [info exists gpGroupState($gpGroup($widgetName))]} {
                     set state $gpGroupState($gpGroup($widgetName))
                  }
                  if {$basename eq ""} {
                     set radiobuttonVariable "$options(name)$radiobuttonGroup"
                  } else {
                     set radiobuttonVariable "$basename$radiobuttonGroup"
                  }
                  set ($radiobuttonVariable) {}
                  set options(-radiobuttoncommand) [::gridplus::gpOptionAlias -radiobuttoncommand -rcmd]
                  ::ttk::radiobutton $widgetName -state $state -style $style -takefocus $options(-takefocus) -value $value -variable ($radiobuttonVariable)
                  if {$state eq "disabled"} {$widgetName configure -takefocus 0}
                  if {$select}              {after idle $widgetName invoke}
                  if {$action} {
                     if {$command eq ""} {
                        set command $widgetName
                     }
                     if {$options(-proc)} {
                        set command "gpProc [::gridplus::gpCommandFormat $command]"
                     } else {
                        set command "$options(-prefix)[::gridplus::gpCommandFormat $command]"
                     }
                     $widgetName configure -command $command
                  } elseif {$options(-radiobuttoncommand) ne ""} {
                     if {$options(-proc)} {
                        set command "gpProc $options(-radiobuttoncommand)"
                     } else {
                        set command "$options(-prefix)$options(-radiobuttoncommand)"
                     }
                     $widgetName configure -command $command
                  }
               }
            }
            w {
               #----------------------#
               # Create "widget" grid #
               #----------------------#
               if {$createWidget} {
                  set widgetCommand "::gridplus::gridplus widget $widgetName -borderwidth 0 -pad 0 -padding {0 0 0 0} -style $style -widget $widgetWidget [list $widgetLayout]"
                  eval $widgetCommand
               } else {
                  set widgetCommand "::gridplus::gridplus widget $options(name)-$widgetID -borderwidth 0 -pad 0 -padding {0 0 0 0} -style $style -widget $widgetWidget [list $widgetLayout]"
                  eval $widgetCommand
                  lappend gridColumn $options(name)-$widgetID
                  incr widgetID
               }
            }
            & {
               #-------------------------------------------------------------#
               # Create "widget" grid for alternative embedded widget syntax #
               #-------------------------------------------------------------#
               set stretch       [lindex $widgetLayout 0]
               set widgetWidget  [lindex $widgetLayout 1]
               set widgetStyle   [lindex $widgetLayout 2]
               set widgetLayout  [lrange $widgetLayout 3 end]
               if {$widgetStyle ne ""} {
                  if {$widgetStyle eq "%"} {
                     set style "{}"
                  } else {
                     set style $widgetStyle
                  }
               }
               set widgetCommand "::gridplus::gridplus widget $widgetName -basename $basename -borderwidth 0 -spacestretch [list $stretch] -pad 0 -padding {0 0 0 0} -style $style  -widget $widgetWidget [list $widgetLayout]"
               eval $widgetCommand
            }

         }

         if {$widgetHelp ne ""} {
            gpWidgetHelpInit $widgetName $widgetHelp
         }

         lappend gridData $gridColumn
         incr columnCount
      }
      lappend gridData !!!!
      incr rowCount
   }

   regsub -all {!!!!} $gridData \n gridData 

   set gridCommand "::gridplus::gridplus grid $options(name)"

   foreach option [array names options -*] {
      set gridCommand "$gridCommand $option {$options($option)}"
   }

   set gridCommand "$gridCommand {$gridData}"

   eval $gridCommand
}

#=======================================================================#
# PROC   : ::gridplus::gpAdd                                            #
# PURPOSE: Add non-gridplus widget to group.                            #
#=======================================================================#

proc ::gridplus::gpAdd {} {
   upvar 1 options options

   variable gpGroup

   set gpGroup($options(name)) $options(-group)
}

#=======================================================================#
# PROC   : ::gridplus::gpAutoGroup                                      #
# PURPOSE: Set group state when entry has been updated.                 #
#=======================================================================#

proc ::gridplus::gpAutoGroup {name group state args} {

   global {}  

   trace remove variable ($name) write "::gridplus::gpAutoGroup $name $group $state"

   ::gridplus::gridplus set -group $group -state $state
}

#=======================================================================#
# PROCS  : ::gridplus::gpWidgetHelpInit                                 #
#        : ::gridplus::gpWidgetHelpDelay                                #
#        : ::gridplus::gpWidgetHelpCancel                               #
#        : ::gridplus::gpWidgetHelpShow                                 #
# PURPOSE: Gridplus widget help.                                        #
#=======================================================================#

proc ::gridplus::gpWidgetHelpInit {item message} {
   variable gpWidgetHelp 

   if {! [winfo exists .gpWidgetHelp]} {
      toplevel .gpWidgetHelp -background black -borderwidth 1 -relief flat
      label    .gpWidgetHelp.message -background lightyellow
      pack     .gpWidgetHelp.message
      wm overrideredirect .gpWidgetHelp 1
      wm withdraw         .gpWidgetHelp
   }

   set gpWidgetHelp($item) $message
   bind $item <Enter> {::gridplus::gpWidgetHelpDelay %W}
   bind $item <Leave> {::gridplus::gpWidgetHelpCancel}
}

proc ::gridplus::gpWidgetHelpDelay {item} {
   variable gpWidgetHelp
 
   gpWidgetHelpCancel
   set gpWidgetHelp(delay) [after 300 [list ::gridplus::gpWidgetHelpShow $item]]
}

proc ::gridplus::gpWidgetHelpCancel {} {
   variable gpWidgetHelp
 
   if {[info exists gpWidgetHelp(delay)]} {
      after cancel $gpWidgetHelp(delay)
      unset gpWidgetHelp(delay)
   }

   if {[winfo exists .gpWidgetHelp]} {
      wm withdraw .gpWidgetHelp
   }
}

proc ::gridplus::gpWidgetHelpShow {item} {
   variable gpWidgetHelp
 
   .gpWidgetHelp.message configure -text $gpWidgetHelp($item)
 
   set helpX [expr [winfo rootx $item] + 10]
   set helpY [expr [winfo rooty $item] + [winfo height $item]]
 
   wm geometry  .gpWidgetHelp +$helpX+$helpY
   wm deiconify .gpWidgetHelp
 
   raise .gpWidgetHelp
 
   unset gpWidgetHelp(delay)
}

#=======================================================================#
# PROC   : ::gridplus::gpClear                                          #
# PURPOSE: Clear window and unset associated variables.                 #
#=======================================================================#

proc ::gridplus::gpClear {} {
   upvar 1 options options

   global {}

   variable gpWidgetHelp
   variable gpGroup
   variable gpInfo
   variable gpTabOrder
   variable gpValidateError
   variable gpValidations

   unset -nocomplain gpInfo($options(name):toplevel)

   if {[winfo exists $options(name).container]} {
      eval $gpInfo($options(name):wcmd)
      unset -nocomplain gpInfo($options(name):in)
      set gpInfo($options(name):wcmd) {}
      return
   }

   $options(name) configure -menu {}

   unset -nocomplain gpInfo(validation:failed)
   unset -nocomplain gpValidations($options(name))

   foreach item [winfo child $options(name)] {
      if {! [winfo exists $item]} {continue}

      set class [winfo class $item]

      if {[regexp -- {^[.]_} $item]} {
         continue
      }

      if {[string match *.gpEditMenu $item]} {
         continue
      }

      if {$class ne "Toplevel"} {
         if {$options(-variables) && [info exists ($item)]} {
            if {$class eq "Entry"} {
               $item configure -textvariable {}
            }
            unset ($item)
         }
         if {[info exists gpWidgetHelp($item)]} {
            unset gpWidgetHelp($item)
         }
         if {[info exists gpInfo($item:wcmd)]} {
            eval $gpInfo($item:wcmd)
         }
         foreach infoItem [array names gpInfo $item:*] {
            unset gpInfo($infoItem)
         }
         foreach tabOrderItem [array names gpTabOrder $item:*] {
            unset gpTabOrder($tabOrderItem)
         }
         foreach validateErrorItem [array names gpValidateError $item:*] {
            unset gpValidateError($validateErrorItem)
         }
         if {[info exists gpGroup($item)]} {
            unset gpGroup($item)
         }
         if {$gpInfo(<gpTextFindItem>) eq "$item.text"} {
            if {[winfo exists .gpTextFind]} {
               ::gridplus::gpTextFind:action,cancel
            }
         }
         if {$class eq "Menu"} {
            foreach menuGroupItem [array names gpGroup $item.*] {
               unset gpGroup($menuGroupItem)
            }
         }

         destroy $item
      }
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpCommand                                        #
# PURPOSE: Evals command, performing validations if required.           #
#=======================================================================#

proc ::gridplus::gpCommand {command window validate} {

   global {}

   variable gpValidations
   variable gpInfo

   if {$window eq "."} {
      set containers [array names gpInfo -regexp {^[.][^.]+:in$}]
   } else {
      set containers [array names gpInfo -regexp "^$window\[.\]\[^.\]+:in$"]
   }

   set containedWindows {}

   foreach container $containers {
      set containedWindows "$containedWindows $gpInfo($container)"
   }

   if {[info exists gpValidations($window)]} {
      set validations $gpValidations($window)
   } else {
      set validations {}
   }

   foreach containedWindow $containedWindows {
      if {[info exists gpValidations($containedWindow)]} {
         set validations "$validations $gpValidations($containedWindow)"
      }
   }

   if {$validate && $validations ne ""} {
      foreach validationInfo $validations {
         set entry [lindex [split $validationInfo :] 0]
         regexp -- {:(.+)$} $validationInfo -> validation
         if {! [::gridplus::gpValidate $entry $validation focusout - - 1]} {
            ::gridplus::gpValidateFailed $entry
            return
         }
      }
   }

   eval $command
}

#=======================================================================#
# PROC   : ::gridplus::gpCommandFormat                                  #
# PURPOSE: Makes sure "command" is in the correct format.               #
#=======================================================================#

proc ::gridplus::gpCommandFormat {command} {

   set commandProc       [lindex $command 0]
   set commandParameters [lrange $command 1 end]

   regsub -all {[.]} $commandProc ":" commandProc
   regsub      {;:}  $commandProc ";" commandProc
   regsub      {^:}  $commandProc {}  commandProc

   if {[llength $command] eq 1} {
      return $commandProc
   } else {
      return [list $commandProc {*}$commandParameters]
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpContainer                                      #
# PURPOSE: Create container for toplevel windows.                       #
#=======================================================================#

proc ::gridplus::gpContainer {} {
   upvar 1 options options

   variable gpInfo

   if {[regexp -- {(^[.][^.]+)[.]} $options(name) -> window]} {
      if {! $gpInfo($window:toplevel)} {
         error "GRIDPLUS ERROR: (gridplus container) $window is a contained toplevel."
      }
   }

   if {$options(-relief) eq "theme"} {
      if {$options(-labelanchor) eq ""} {
         ::ttk::labelframe $options(name) -height $options(-height) -width $options(-width) -padding $options(-padding) -text [mc $options(-title)]
      } else {
         ::ttk::labelframe $options(name) -height $options(-height) -width $options(-width) -labelanchor $options(-labelanchor) -padding $options(-padding) -text [mc $options(-title)]
      }
   } else {
      ::ttk::frame $options(name) -height $options(-height) -width $options(-width) -padding $options(-padding) -relief $options(-relief)
   }

   frame $options(name).container -container 1

   grid propagate $options(name) 0
   pack propagate $options(name) 0

   set gpInfo($options(name):container) [winfo id $options(name).container]
   set gpInfo($options(name):wcmd)      {}

   grid $options(name).container -sticky $options(-sticky)
   grid rowconfigure    $options(name) $options(name).container -weight 1
   grid columnconfigure $options(name) $options(name).container -weight 1

}

#=======================================================================#
# PROC   : ::gridplus::gpCreateIcons                                    #
# PURPOSE: Creates default icons for GRIDPLUS Tree.                     #
#=======================================================================#

proc ::gridplus::gpCreateIcons {} {

   image create photo ::icon::file -data {
      R0lGODlhEAAQAIIAAPwCBFxaXISChPz+/MTCxKSipAAAAAAAACH5BAEAAAAA
      LAAAAAAQABAAAANCCLrcGzBC4UAYOE8XiCdYF1BMJ5ye1HTfNxTBSpy0QMBy
      ++HlXNu8h24X6/2AReHwllRcMtCgs0CtVpsWiRZbqfgTACH+aENyZWF0ZWQg
      YnkgQk1QVG9HSUYgUHJvIHZlcnNpb24gMi41DQqpIERldmVsQ29yIDE5OTcs
      MTk5OC4gQWxsIHJpZ2h0cyByZXNlcnZlZC4NCmh0dHA6Ly93d3cuZGV2ZWxj
      b3IuY29tADs=
   }

   image create photo ::icon::folder -data {
      R0lGODlhEAAQAIIAAPwCBFxaXMTCxPz+/KSipAAAAAAAAAAAACH5BAEAAAAA
      LAAAAAAQABAAAAM3CLrc/i/IAFcQWFAos56TNYxkOWhKcHossals+64x5qZ0
      fQNwbc++Hy4o2F0IyKTSCGqCKhB/AgAh/mhDcmVhdGVkIGJ5IEJNUFRvR0lG
      IFBybyB2ZXJzaW9uIDIuNQ0KqSBEZXZlbENvciAxOTk3LDE5OTguIEFsbCBy
      aWdodHMgcmVzZXJ2ZWQuDQpodHRwOi8vd3d3LmRldmVsY29yLmNvbQA7
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpDefine                                         #
# PURPOSE: Creates GRIDPLUS widget definitions.                         #
#=======================================================================#

proc ::gridplus::gpDefine {} {
   upvar 1 options options

   variable gpInfo

   foreach {id widget} $options(layout) {
      set gpInfo(<gpDefine>:$id) $widget
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpDefineWidget                                   #
# PURPOSE: Process "defined" widget.                                    #
#=======================================================================#

proc ::gridplus::gpDefineWidget {column} {

   variable gpInfo

   if {[string match @* $column]} {
      if {[winfo exists .[string range $column 1 end]]} {
         return $column
      }
      set defineID [string range [lindex $column 0] 1 end]
      if {[info exists gpInfo(<gpDefine>:$defineID)]} {
         set defineWidget $gpInfo(<gpDefine>:$defineID)
         set replacementID 1

         foreach replacement [lrange $column 1 end] {
            regsub -- "%$replacementID" $defineWidget $replacement defineWidget
            incr replacementID 
         }
      }
      return [::gridplus::gpDefineWidget $defineWidget]
   } else {
      return $column
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpEditMenu                                       #
# PURPOSE: Pop-up menu for entry widgets.                               #
#=======================================================================#

proc ::gridplus::gpEditMenu {mode} {

   set widget [focus]

   switch -- $mode {
      cut   {
         clipboard clear
         clipboard append [selection get]
         $widget delete sel.first sel.last
      }
      copy  {
         clipboard clear
         clipboard append [selection get]
      }
      paste {
         $widget selection clear
         $widget insert insert [clipboard get]
      }
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpEditMenuCreate                                 #
# PURPOSE: Create pop-up menu for entry widgets.                        #
#=======================================================================#

proc ::gridplus::gpEditMenuCreate {window} {

      menu $window.gpEditMenu

      $window.gpEditMenu configure -tearoff 0

      $window.gpEditMenu add command -label [mc "Cut"]   -command "::gridplus::gpEditMenu cut"
      $window.gpEditMenu add command -label [mc "Copy"]  -command "::gridplus::gpEditMenu copy"
      $window.gpEditMenu add command -label [mc "Paste"] -command "::gridplus::gpEditMenu paste"
}

#=======================================================================#
# PROC   : ::gridplus::gpEntryEdit                                      #
# PURPOSE: Pop-up menu for entry widgets.                               #
#=======================================================================#

proc ::gridplus::gpEntryEdit {editWindow X Y} {

   global {}

   set widget [winfo containing $X $Y]

   focus $widget

   if {$editWindow eq ""} {
      set window {}
   } else {
      set window .$editWindow
   }

   if {! [$widget selection present]} {
      $widget selection range 0 end
   }

   if {[$widget cget -state] ne "normal"} {
      $window.gpEditMenu entryconfigure 0 -state disabled
      $window.gpEditMenu entryconfigure 1 -state normal
      $window.gpEditMenu entryconfigure 2 -state disabled
   } else {
      $window.gpEditMenu entryconfigure 0 -state normal
      $window.gpEditMenu entryconfigure 1 -state normal
      $window.gpEditMenu entryconfigure 2 -state normal
   }

   if {$($widget) eq ""} {
      $window.gpEditMenu entryconfigure 0 -state disabled
      $window.gpEditMenu entryconfigure 1 -state disabled
   }

   if {[$widget cget -state] ne "disabled"} {
      $window.gpEditMenu post $X $Y
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpGetFontOption                                  #
# PURPOSE: Get font option for specified font.                          #
#=======================================================================#

proc ::gridplus::gpGetFontOption {font option} {

   foreach {fontOption value} [font configure $font] {
      if {$fontOption eq $option} {
         return $value
      }
   }

   return {}
}

#=======================================================================#
# PROC   : ::gridplus::gpGetFontSize                                    #
# PURPOSE: Get font size for specified font.                            #
#=======================================================================#

proc ::gridplus::gpGetFontSize {font} {

   if {[llength $font] == 1} {
      return [::gridplus::gpGetFontOption $font -size]
   } else {
      return [lindex $font 1]
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpGetOption                                      #
# PURPOSE: Get option from "option database". Use default if not found. #
#=======================================================================#

proc ::gridplus::gpGetOption {option default} {

   set value [option get . $option -]

   if {$value eq ""} {
      return $default
   } else {
      return $value
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpGoto                                           #
# PURPOSE: Move text widget display to specified label.                 #
#=======================================================================#

proc ::gridplus::gpGoto {} {
   upvar 1 options options

   global {}

   $options(name).text yview $options(layout)

   set ($options(name)) $options(layout)
}

#=======================================================================#
# PROC   : ::gridplus::gpGrid                                           #
# PURPOSE: Create grid.                                                 #
#=======================================================================#

proc ::gridplus::gpGrid {} {
   upvar 1 options options

   global {}

   variable gpInfo
   variable gpTabOrder

   set options(-columnformat) [::gridplus::gpOptionAlias -columnformat -cfmt]

   set labelColor(1) [lindex [split $options(-labelcolor) /] 0]
   set labelColor(2) [lindex [split $options(-labelcolor) /] 1]
   set labelStyle(1) [lindex [split $options(-labelstyle) /] 0]
   set labelStyle(2) [lindex [split $options(-labelstyle) /] 1]

   regsub -all -- {,} $labelStyle(1) { } labelStyle(1)
   regsub -all -- {,} $labelStyle(2) { } labelStyle(2)

   if {[string match *w* $options(-attach)]} {
      set leftStretch    0
      set rightStretch   1
      set defaultStretch 0
   } else {
      set leftStretch    0
      set rightStretch   0
      set defaultStretch 1
   }

   if {[llength $options(-spacestretch)] == 1} {
      set options(-spacestretch) [lrepeat 100 $options(-spacestretch)]
   }

   if {[string match *n* $options(-attach)]} {
      set weightY 0
   } else {
      set weightY 1
   }
 
   if {$options(-relief) eq "theme"} {
      if {$options(-labelanchor) eq ""} {
         ::ttk::labelframe $options(name) -padding $options(-padding) -text [mc $options(-title)]
      } else {
         ::ttk::labelframe $options(name) -labelanchor $options(-labelanchor) -padding $options(-padding) -text [mc $options(-title)]
      }
   } else {
      ::ttk::frame $options(name) -padding $options(-padding) -relief $options(-relief)
   }

   grid anchor $options(name) $options(-anchor)

   set rowID    0
   set rowTotal [llength [split $options(layout) "\n"]]
   set rowCount 1

   if {! [regexp -- {^[.]([^.]+)[.]} $options(name) -> window]} {
      set window {}
   }

   if {$options(-subst)} {
      set options(layout) [subst -nobackslashes -nocommands $options(layout)]
   }

   foreach row [split $options(layout) "\n"] {
      set columnID    0
      set columnTotal [llength $row]
      set columnCount 1

      if {$options(-spacestretch) eq ""} {
         if {$columnTotal > 1} {
            set stretch "$leftStretch [lrepeat [expr {$columnTotal - 1}] $defaultStretch] $rightStretch"
         } else {
            set stretch "$leftStretch $rightStretch"
         }
      } else {
         set stretch $options(-spacestretch)
      }

      ::ttk::frame $options(name).space:$rowID:$columnID -width 0
      grid $options(name).space:$rowID:$columnID -column $columnID -row $rowID -sticky ew
      grid columnconfigure $options(name) $columnID -weight [lindex $stretch 0]
      incr columnID

      foreach column $row {
         switch -- [llength $column] {
            0 {
               set columnSpan 2
               set column "{}"
            }
            1 {
               set columnSpan 2
            }
            2 {
               set columnSpan 1
            }
            default {
               error "GRIDPLUS ERROR: Too many items in column"
            }
         }

         set columnItem     1
         set formatWidth(1) 0
         set formatWidth(2) 0

         if {[set columnFormat [lindex $options(-columnformat) [expr {$columnCount - 1}]]] ne ""} {
            if {[lindex [split $columnFormat "/"] 0] ne ""} {
               set formatWidth(1) [lindex [split $columnFormat "/"] 0]
               set formatWidth(2) [lindex [split $columnFormat "/"] 1]
            }
            if {$formatWidth(1) eq ""} {set formatWidth(1) 0}
            if {$formatWidth(2) eq ""} {set formatWidth(2) 0}
         }


         foreach item $column {
            set bold      0
            set command   {}
            set labelFont $labelStyle($columnItem)
            set labelIcon {}
            set sticky    {}
            set validate  0

            if {! [string match "*: " $item]} {
               regexp {(^[^:]+)(:([nsewc]+$)?)} $item -> item dummy2 sticky
            }
            switch -- $sticky {
               c  {set sticky {}}
               "" {set sticky w}
            }
            switch -glob -- $item {
               .* {
                  set itemName $item
                  ::ttk::frame $options(name).widget:$rowID:$columnID
                  ::ttk::frame $options(name).widget:$rowID:$columnID.width -height 0 -width [expr {$formatWidth($columnItem) * $gpInfo(<gpWidthFactor>)}]
                  if {! [winfo exists $item]} {
                     set itemName $options(name),[string range $item 1 end]
                     if {$options(-basename) ne ""} {
                        set textVariable $options(-basename),[string range $item 1 end]
                     } else {
                        set textVariable $itemName
                     }
                     ::ttk::label $itemName -foreground $labelColor($columnItem) -justify $options(-justify) -wraplength $options(-wraplength) -textvariable ($textVariable)
                     if {$labelFont ne ""} {
                        $itemName configure -font [::gridplus::gpSetFont $labelFont]
                     }
                  }
                  grid $options(name).widget:$rowID:$columnID.width         -row 0 -column 0
                  grid $itemName -in $options(name).widget:$rowID:$columnID -row 1 -column 0 -sticky $sticky
                  grid configure $options(name).widget:$rowID:$columnID -in $options(name) -column $columnID -row $rowID -columnspan $columnSpan -sticky $sticky
                  grid columnconfigure $options(name).widget:$rowID:$columnID 0 -weight 1
                  if {$options(-taborder) eq "column"} {
                     set gpTabOrder([format "%s:%03d%03d%03d" $options(name) $columnCount $rowCount $columnItem]) $itemName
                  } else {
                     set gpTabOrder([format "%s:%03d%03d%03d" $options(name) $rowCount $columnCount $columnItem]) $itemName
                  }
               }
               | {
                  ::ttk::separator $options(name).separator:$rowID:$columnID -orient vertical   
                  grid configure $options(name).separator:$rowID:$columnID -in $options(name) -column $columnID -row $rowID -columnspan $columnSpan -sticky ns
               }
               = {
                  ::ttk::separator $options(name).separator:$rowID:$columnID -orient horizontal
                  grid configure $options(name).separator:$rowID:$columnID -in $options(name) -column $columnID -row $rowID -columnspan $columnSpan -sticky ew
               }
               :* {
                  if {! [regexp -- {^:([^:]*):([^:]*):([^:]*)$} $item -> labelIcon command validate]} {
                     set labelIcon [string range $item 1 end]
                     regsub -- {%%$} $labelIcon {} labelIcon
                  }
                  if {$labelIcon eq ""} {
                     set labelIcon $options(-icon)
                  }
                  ::icons::icons create -file [file join $options(-iconpath) $options(-iconfile)] $labelIcon
                  ::ttk::label $options(name).label:$rowID:$columnID -image ::icon::$labelIcon
                  grid configure $options(name).label:$rowID:$columnID -in $options(name) -column $columnID -row $rowID -columnspan $columnSpan -sticky $sticky
                  if {$command ne ""} {
                     if {$options(-proc)} {
                        set command "set gridplus::gpFocus \[focus\];gpProc $command"
                     } else {
                        set command "set gridplus::gpFocus \[focus\];$options(-prefix)$command"
                        regsub -all {[.]} $command ":" command
                        regsub      {;:}  $command ";" command
                     }

                     bind $options(name).label:$rowID:$columnID <ButtonRelease-1> "eval \"::gridplus::gpCommand {$command} .$window $validate\""
                  }
               }
               default {
                  if {[string match ^* $item]} {
                     set labelFont "$labelFont bold"
                     set item [string range $item 1 end]
                  }
                  regsub -all -- " +\n +" $item "\n" item
                  regsub -all -- "<n>"    $item "\n" item
                  ::ttk::frame $options(name).label:$rowID:$columnID
                  ::ttk::frame $options(name).label:$rowID:$columnID.width -height 0 -width [expr {$formatWidth($columnItem) * $gpInfo(<gpWidthFactor>)}]
                  ::ttk::label $options(name).label:$rowID:$columnID.text -foreground $labelColor($columnItem) -style $options(-style) -justify $options(-justify) -wraplength $options(-wraplength) -text [mc $item]
                  if {$labelFont ne ""} {
                     $options(name).label:$rowID:$columnID.text configure -font [::gridplus::gpSetFont $labelFont]
                  }
                  grid $options(name).label:$rowID:$columnID.width -row 0 -column 0
                  grid $options(name).label:$rowID:$columnID.text -in $options(name).label:$rowID:$columnID -row 1 -column 0 -sticky $sticky
                  grid configure $options(name).label:$rowID:$columnID -in $options(name) -column $columnID -row $rowID -columnspan $columnSpan -sticky $sticky
                  grid columnconfigure $options(name).label:$rowID:$columnID 0 -weight 1
               }
            }

            incr columnID $columnSpan
            incr columnItem
         }

         if {$columnCount != $columnTotal} {
            ::ttk::frame $options(name).space:$rowID:$columnID -width $options(-space)
            grid $options(name).space:$rowID:$columnID -column $columnID -row $rowID -sticky ew
            grid columnconfigure $options(name) $columnID -weight [lindex $stretch $columnCount]
            incr columnID
         } else {
            ::ttk::frame $options(name).space:$rowID:$columnID -width 0
            grid $options(name).space:$rowID:$columnID -column $columnID -row $rowID -sticky ew
            grid columnconfigure $options(name) $columnID -weight [lindex $stretch $columnCount]
         }

         incr columnCount
      }

      incr rowID

      if {$rowCount != $rowTotal} {
         ::ttk::frame $options(name).space:$rowID:$columnID -height 4 -width 4
         grid $options(name).space:$rowID:$columnID -row $rowID -column 0 -sticky ns -columnspan 3
         grid rowconfigure $options(name) $rowID -weight $weightY
         incr rowID
      } elseif {! $weightY} {
         ::ttk::frame $options(name).space:$rowID:$columnID -height 4 -width 4
         grid $options(name).space:$rowID:$columnID -row $rowID -column 0 -sticky ns -columnspan 3
         grid rowconfigure $options(name) $rowID -weight 1
      }

      incr rowCount
   }

   foreach stretch $options(-stretch) {
      grid columnconfigure $options(name) [expr {(($stretch + 1) * 3) - 1}] -weight 1
   }

   gpSetTabOrder $options(name)

   if {$options(-wtitle) ne ""} {
      wm title [winfo toplevel $options(name)] [mc $options(-wtitle)]
   }
}

#== ADDED: Nikolaos Kavvadias
#== Source: http://wiki.tcl.tk/773

proc DirectPathname {filename} {
     set savewd [pwd]
     set realFile [file join $savewd $filename]
     # Hmm.  This (unusually) looks like a job for do...while!
     cd [file dirname $realFile]
     set dir [pwd] ;# Always gives a canonical directory name
     set filename [file tail $realFile]
     while {![catch {file readlink $filename} realFile]} {
         cd [file dirname $realFile]
         set dir [pwd]
         set filename [file tail $realFile]
     }
     cd $savewd
     return [file join $dir $filename]
}

#=======================================================================#
# PROC   : ::gridplus::gpInit                                           #
# PURPOSE: Gridplus initailise.                                         #
#=======================================================================#

proc ::gridplus::gpInit {} {
   variable gpConfig
   variable gpInfo
   variable gpValidation

   wm resizable . 0 0

   set gpInfo(.:toplevel)       1
   set gpInfo(<gpTextFindItem>) {}

   ttk::label .gpWidthFactor -width 1
   set gpInfo(<gpWidthFactor>) [winfo reqwidth .gpWidthFactor]
   destroy .gpWidthFactor

   if {[namespace exists "::starkit"]} {
      set iconPath [file join $::starkit::topdir lib]
   } else {
#      set iconPath [file join [info library]]
      set iconPath [DirectPathname "./common/icons1.0"]
#      puts iconPath "$iconPath"
   }

   array set gpConfig [list                                  \
      dateformat   [gpGetOption Gridplus.dateFormat us]      \
      errormessage [gpGetOption Gridplus.errorMessage %]     \
      iconfile     [gpGetOption Gridplus.iconFile tkIcons]   \
      iconpath     [gpGetOption Gridplus.iconPath $iconPath] \
      prefix       [gpGetOption Gridplus.prefix {}]          \
      proc         [gpGetOption Gridplus.proc 0]             \
   ]

   switch -- $gpConfig(dateformat) {
      eu {
         set gpConfig(date:day)       0
         set gpConfig(date:month)     1
         set gpConfig(date:separator) .
      }
      uk {
         set gpConfig(date:day)       0
         set gpConfig(date:month)     1
         set gpConfig(date:separator) /
      }
      us {
         set gpConfig(date:day)       1
         set gpConfig(date:month)     0
         set gpConfig(date:separator) /
      }
   }

   set gpConfig(date:century) [gpGetOption Gridplus.century 50]

   array set gpValidation {
      alpha          {^[a-zA-Z]+$}
      alphanum       {^[a-zA-Z0-9]+$}
      date           {proc:gpValidateDate}
      money          {^[0-9]+[.][0-9][0-9]$}
      num            {^[0-9]+[.]?[0-9]*$}
      notnull        {[^\000]}
      int            {^[0-9]+$}
      !              {[^\000]}
      alpha:text     {Alpha}
      alphanum:text  {Alphanumeric}
      date:text      {Date}
      money:text     {Money Format}
      notnull:text   {Not Null}
      num:text       {Numeric}
      int:text       {Integer}
      !:text         {Non Blank}

   }

   ::gridplus::gpCreateIcons

   ::gridplus::gpEditMenuCreate {}

   bind . <Configure> "::gridplus::gpValidateErrorCancel . %W"
   bind . <Unmap>     "::gridplus::gpValidateErrorCancel . %W"
}

#=======================================================================#
# PROC   : ::gridplus::gpInsertText                                     #
# PURPOSE: Inserts "tagged" data into text widget.                      #
#=======================================================================#

proc ::gridplus::gpInsertText {name tag end parameter position text} {
   upvar 1 options options

   global {}

   variable gpInfo

   if {! [regexp -- {^[.]([^.]+)[.]} $name -> window]} {
      set window {}
   }

   set command        false
   set imageCommand   {}
   set imageInfo      {}
   set imageLink      {}
   set imageParameter {}
   set link           false
   set bgColor        $gpInfo($name:bgcolor)
   set fgColor        $gpInfo($name:fgcolor)
   set linkColor      $gpInfo($name:link)
   set setCommand     0
   set validate       0

   switch -- $end$tag {
      init     {set gpInfo($name:font)       $gpInfo($name:defaultfont)
                set gpInfo($name:size)       10
                set gpInfo($name:weight)     normal
                set gpInfo($name:slant)      roman
                set gpInfo($name:underline)  false}
      b        {set gpInfo($name:weight)     bold}
      /b       {set gpInfo($name:weight)     normal}
      bgcolor  {set bgColor                  [lindex [split $parameter :] 0]
                set bgParameter              [lindex [split $parameter :] 1]
                if {$bgParameter eq "default"} {set gpInfo($name:defaultbg) $bgColor}
                set gpInfo($name:bgcolor)    $bgColor}
      /bgcolor {set bgColor                  $gpInfo($name:defaultbg)
                set gpInfo($name:bgcolor)    $gpInfo($name:defaultbg)}
      color    {set fgColor                  [lindex [split $parameter :] 0]
                set fgParameter              [lindex [split $parameter :] 1]
                if {$fgParameter eq "default"} {set gpInfo($name:defaultfg) $fgColor}
                set gpInfo($name:fgcolor)    $fgColor}
      /color   {set fgColor                  $gpInfo($name:defaultfg)
                set gpInfo($name:fgcolor)    $gpInfo($name:defaultfg)}
      command  {set fgColor                  $gpInfo($name:normalcolor)
                set gpInfo($name:underline)  $gpInfo($name:normalstyle)
                set command                  [lindex [split $parameter :] 0]
                set commandParameter         [lindex [split $parameter :] 1]
                if {$commandParameter eq ""} {set commandParameter $text}}
      font     {set font                     [lindex [split $parameter :] 0]
                set fontParameter            [lindex [split $parameter :] 1]
                if {$fontParameter eq "default"} {set gpInfo($name:defaultfont) $font}
                set gpInfo($name:font)       $font}
      /font    {set gpInfo($name:font)       $gpInfo($name:defaultfont)}
      i        {set gpInfo($name:slant)      italic}
      /i       {set gpInfo($name:slant)      roman}
      image    {set imageInfo                $parameter}
      indent   {set gpInfo($name:indent)     $parameter
                set tabs [string repeat "\t" $parameter]
                set text "$tabs$text"}
      /indent  {set gpInfo($name:indent)     0}
      label    {set label                    [lindex [split $parameter :] 0]
                set labelParameter           [lindex [split $parameter :] 1]
                if {$labelParameter eq "default"} {set ($name) $label} 
                $name.text mark set $label "insert wordstart"
                $name.text mark gravity $label left}
      link     {set fgColor                  $gpInfo($name:normalcolor)
                set gpInfo($name:underline)  $gpInfo($name:normalstyle)
                set link                     $parameter}
      size     {set size                     [lindex [split $parameter :] 0]
                set sizeParameter            [lindex [split $parameter :] 1]
                if {$sizeParameter eq "default"} {set gpInfo($name:defaultsize) $size}
                set gpInfo($name:size)       [gridplus::gpSetFontSize $gpInfo($name:defaultsize) $size]}
      /size    {set gpInfo($name:size)       $gpInfo($name:defaultsize)}
      tab      {if {$parameter eq ""} {set parameter 1}
                set tabs [string repeat "\t" $parameter]
                set text "$tabs$text"}
      u        {set gpInfo($name:underline)  true}
      /u       {set gpInfo($name:underline)  false}
   }

   set tagName "tag[incr gpInfo($name:tagid)]"
   set font    "-family $gpInfo($name:font) -size $gpInfo($name:size) -slant $gpInfo($name:slant) -underline $gpInfo($name:underline) -weight $gpInfo($name:weight)"
   set indent  "[expr {$gpInfo($name:indent) * 0.5}]c"

   $name.text tag configure $tagName -lmargin1 $indent -lmargin2 $indent -background $bgColor -foreground $fgColor -font "$font"

   if {$imageInfo ne ""} {
      if {[string match *@* $imageInfo]} {
         set image          [lindex [split $imageInfo @] 0]
         set imageLink      [lindex [split $imageInfo @] 1]
      } else {
         set image          [lindex [split $imageInfo ~] 0]
         set imageCommand   [lindex [split [lindex [split $imageInfo ~] 1] :] 0]
         set imageParameter [lindex [split [lindex [split $imageInfo ~] 1] :] 1]

         if {$imageCommand ne ""} {
            set setCommand   1
            set imageCommand "$name,$imageCommand"

            if {$gpInfo($name:proc)} {
               set imageCommand "set gridplus::gpFocus \[focus\];gpProc $imageCommand"
            } else {
               set imageCommand "set gridplus::gpFocus \[focus\];$gpInfo($name:prefix)$imageCommand"
               regsub -all {[.]} $imageCommand ":" imageCommand
               regsub      {;:}  $imageCommand ";" imageCommand
            }
         }
      }

      if {[string match :* $image]} {
         set icon  [string range $image 1 end]
         set image "::icon::$icon"
         ::icons::icons create -file $gpInfo($name:iconlibrary) $icon
      }

      set imageName [$name.text image create end -image $image]

      $name.text tag add $imageName $imageName
      $name.text tag configure $imageName -background $bgColor

      if {$imageLink ne ""} {
         $name.text tag bind $imageName <Enter> "$name.text configure -cursor $gpInfo($name:linkcursor)"
         $name.text tag bind $imageName <Leave> "$name.text configure -cursor {}"
         $name.text tag bind $imageName <ButtonPress-1> "set ($name) $imageLink; $name.text yview $imageLink"
      } elseif {$setCommand} {
         $name.text tag bind $imageName <Enter> "$name.text configure -cursor $gpInfo($name:linkcursor)"
         $name.text tag bind $imageName <Leave> "$name.text configure -cursor {}"
         $name.text tag bind $imageName <ButtonPress-1> "set ($name) \"$imageParameter\"; ::gridplus::gpCommand {$imageCommand} .$window $validate"
      }
   }

   if {$command ne "false"} {

      set command "$name,$command"

      if {$gpInfo($name:proc)} {
         set command "set gridplus::gpFocus \[focus\];gpProc $command"
      } else {
         set command "set gridplus::gpFocus \[focus\];$gpInfo($name:prefix)$command"
         regsub -all {[.]} $command ":" command
         regsub      {;:}  $command ";" command
      }

      $name.text tag bind $tagName <Enter> "$name.text configure -cursor $gpInfo($name:linkcursor); $name.text tag configure $tagName -foreground $gpInfo($name:overcolor) -underline $gpInfo($name:overstyle)"
      $name.text tag bind $tagName <Leave> "$name.text configure -cursor {}; $name.text tag configure $tagName -foreground $gpInfo($name:normalcolor) -underline $gpInfo($name:normalstyle)"
      $name.text tag bind $tagName <ButtonPress-1> "set ($name) \"$commandParameter\"; ::gridplus::gpCommand {$command} .$window $validate"

      set gpInfo($name:underline) false
   }

   if {$link ne "false"} {
      $name.text tag bind $tagName <Enter> "$name.text configure -cursor $gpInfo($name:linkcursor); $name.text tag configure $tagName -foreground $gpInfo($name:overcolor) -underline $gpInfo($name:overstyle)"
      $name.text tag bind $tagName <Leave> "$name.text configure -cursor {}; $name.text tag configure $tagName -foreground $gpInfo($name:normalcolor) -underline $gpInfo($name:normalstyle)"
      $name.text tag bind $tagName <ButtonPress-1> "set ($name) $link; $name.text yview $link"
      set gpInfo($name:underline) false
   }

   if {$text ne ""} {
      regsub -all {!b:}  $text "\u2022" text
      regsub -all {!ob:} $text \{       text
      regsub -all {!cb:} $text \}       text
      regsub -all {!bs:} $text {\\}     text
      regsub -all {!lt:} $text {<}      text
      regsub -all {!gt:} $text {>}      text
      $name.text insert $position $text $tagName 
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpLayout                                         #
# PURPOSE: Create layout.                                               #
#=======================================================================#

proc ::gridplus::gpLayout {} {
   upvar 1 options options

   global {}

   variable gpTabOrder

   set rowCount      0
   set layout(items) {}
   set toplevel      {}

   if {$options(-subst)} {
      set options(layout) [subst -nobackslashes -nocommands $options(layout)]
   }

   foreach row [split $options(layout) "\n"] {
      set columnCount 0
      foreach column $row {
         set setXweight 0
         set setYweight 0
         set sticky  {}

         if {$column eq "="} {set column ".="}
         if {$column eq "|"} {set column ".|"}

         regexp -- {(^[^:]+)(:([nsewc]+$)?)} $column -> column -> sticky

         if {[regexp -- {(^[.][^|]+)([|]([nsewc]+$)?)} $column -> column -> sticky]} {
            set setXweight 1
         }
         if {[regexp -- {(^[.][^=]+)([=]([nsewc]+$)?)} $column -> column -> sticky]} {
            set setYweight 1
         }
         if {[regexp -- {(^[.][^+]+)([+]([nsewc]+$)?)} $column -> column -> sticky]} {
            set setXweight 1
            set setYweight 1
         }

         set layout($column:xweight) 1
         set layout($column:yweight) 1

         if {$setXweight} {set layout($column:xweight) 0}
         if {$setYweight} {set layout($column:yweight) 0}

         switch -- $sticky {
            c  {set sticky {}}
            "" {set sticky w}
         }
         switch -glob -- $column {
            .* {
               if {$column eq ".="} {
                  ::ttk::separator $options(name):line:$columnCount:$rowCount -orient horizontal
                  set sticky "nsew"
                  set column $options(name):line:$columnCount:$rowCount
                  set layout($column:yweight) 0
               }
               if {$column eq ".|"} {
                  ::ttk::separator $options(name):line:$columnCount:$rowCount -orient vertical
                  set sticky "nsew"
                  set column $options(name):line:$columnCount:$rowCount
                  set layout($column:xweight) 0
               }
               set column [regsub -all -- {%} $column [string range $options(name) 1 end]]
               lappend layout(items) $column
               set layout(cell:$columnCount,$rowCount) $column
               set layout($column:x)      $columnCount
               set layout($column:y)      $rowCount
               set layout($column:xspan)  1
               set layout($column:yspan)  1
               set layout($column:sticky) $sticky
               if {$options(-taborder) eq "column"} {
                  set gpTabOrder([format "%s:%03d%03d001" $options(name) $columnCount $rowCount]) $column
               } else {
                  set gpTabOrder([format "%s:%03d%03d001" $options(name) $rowCount $columnCount]) $column
               }
            }
            - {
               if {$columnCount == 0} {error "GRIDPLUS ERROR (layout): Column span not valid in first column"}
               set previousColumn [expr {$columnCount - 1}]
               set cell $layout(cell:$previousColumn,$rowCount)
               set layout(cell:$columnCount,$rowCount) $layout(cell:$previousColumn,$rowCount)
               incr layout($cell:xspan)
            }
            ^ {
               if {$rowCount == 0} {error "GRIDPLUS ERROR (layout): Row span not valid in first row"}
               set previousRow  [expr {$rowCount - 1}]
               set previousCell [expr {$columnCount - 1}]
               set cell $layout(cell:$columnCount,$previousRow)
               set layout(cell:$columnCount,$rowCount) $layout(cell:$columnCount,$previousRow)
               if {! ([info exists layout(cell:$previousCell,$rowCount)] && $layout(cell:$previousCell,$rowCount) eq $cell)} {
                  incr layout($cell:yspan)
               }
            }
            x {
            }
            default {
               error "GRIDPLUS ERROR (layout): Invalid item/option ($column)"
            }
         }
         incr columnCount
      }
      incr rowCount
   }

   if {$options(-wtitle) ne "" && [regexp {([.][^.]*)[.].+$} $options(name) -> window]} {
      wm title $window [mc $options(-wtitle)]
   }

   if {$options(-relief) eq "theme"} {
      if {$options(-labelanchor) eq ""} {
         ::ttk::labelframe $options(name) -padding $options(-padding) -text [mc $options(-title)]
      } else {
         ::ttk::labelframe $options(name) -labelanchor $options(-labelanchor) -padding $options(-padding) -text [mc $options(-title)]
      }
   } else {
      ::ttk::frame $options(name) -padding $options(-padding) -relief $options(-relief)
   }

   foreach item $layout(items) {
      set padxLeft  $options(-padx)
      set padxRight $options(-padx)

      if {$layout($item:x) == 0} {
         set padxLeft 0
      }
      if {[expr {$layout($item:x) + $layout($item:xspan)}] == $columnCount} {
         set padxRight 0
      }

      set padyTop    $options(-pady)
      set padyBottom $options(-pady)

      if {$layout($item:y) == 0} {
         set padyTop 0
      }
      if {[expr {$layout($item:y) + $layout($item:yspan)}] == $rowCount} {
         set padyBottom 0
      }

      set padx [list $padxLeft $padxRight]
      set pady [list $padyTop  $padyBottom]

      grid configure $item -in $options(name) -column $layout($item:x) -row $layout($item:y) -columnspan $layout($item:xspan) -rowspan $layout($item:yspan) -sticky $layout($item:sticky) -padx $padx -pady $pady

      if {[info exists layout($item:xweight)]} {
         set xweight $layout($item:xweight)
      } else {
         set xweight 1
      }
      if {[info exists layout($item:yweight)]} {
         set yweight $layout($item:yweight)
      } else {
         set yweight 1
      }

      grid columnconfigure $options(name) $layout($item:x) -weight $xweight
      grid rowconfigure    $options(name) $layout($item:y) -weight $yweight
      gpSetTabOrder $options(name)
   }

   if {$options(-wtitle) ne ""} {
      wm title [winfo toplevel $options(name)] [mc $options(-wtitle)]
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpLine                                           #
# PURPOSE: Gridplus create line.                                        #
#=======================================================================#

proc ::gridplus::gpLine {} {
   upvar 1 options options

   if {$options(-background) eq ""} {
      set background [. cget -background] 
   } else {
      set background $options(-background)
   }

   if {$options(-title) ne ""} {
      frame $options(name) -background $background -padx $options(-padx) -pady $options(-pady)
      frame $options(name).left  -background $background -borderwidth 2 -height 2 -relief sunken -width 5
      frame $options(name).right -background $background -borderwidth 2 -height 2 -relief sunken
      label $options(name).label -background $background -text [mc $options(-title)] -borderwidth 1
      grid configure $options(name).left  -column 0 -row 0 -sticky ew
      grid configure $options(name).label -column 1 -row 0
      grid configure $options(name).right -column 2 -row 0 -sticky ew
      grid columnconfigure $options(name) 2 -weight 1
   } else {
     frame $options(name) -background $background -borderwidth $options(-borderwidth) -height $options(-linewidth) -padx $options(-padx) -pady $options(-pady) -relief $options(-linerelief) -width $options(-linewidth)
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpMenu                                           #
# PURPOSE: Create menu(bar).                                            #
#=======================================================================#

proc ::gridplus::gpMenu {} {
   upvar 1 options options

   if {$options(name) eq "."} {
      set rootMenu .menubar
      $options(name) configure -menu $rootMenu
   } elseif {[winfo exists $options(name)] && [winfo class $options(name)] eq "Toplevel"} {
      set rootMenu $options(name).menubar
      $options(name) configure -menu $rootMenu
   } else {
      set rootMenu $options(name)
   }

   menu $rootMenu

   $rootMenu configure -tearoff 0

   set rootMenuIndex 0

   foreach {menuLabel menuEntries} $options(layout) {
      set underline [string first "_" $menuLabel]
      regsub -all -- {_} $menuLabel {} menuLabel

      if {$menuLabel eq "~"} {
         ::gridplus::gpMenuOption $rootMenu {} $rootMenuIndex $menuEntries
         incr rootMenuIndex
         continue  
      }

      if {[string match @* $menuEntries]} {
         set cascade ".[string range $menuEntries 1 end]"
         $rootMenu add cascade -label [mc $menuLabel] -menu $cascade -underline $underline
         continue
      }

      set menu [string tolower $menuLabel]

      $rootMenu add cascade -label [mc $menuLabel] -menu $rootMenu.$menu -underline $underline
      menu $rootMenu.$menu
      $rootMenu.$menu configure -tearoff 0

      set menuIndex 0

      foreach menuEntryData $menuEntries {
         ::gridplus::gpMenuOption $rootMenu $menu $menuIndex $menuEntryData  
         incr menuIndex
      }

      incr rootMenuIndex
   }

}

#=======================================================================#
# PROC   : ::gridplus::gpMenuOption                                     #
# PURPOSE: Create menu(bar) option.                                     #
#=======================================================================#

proc ::gridplus::gpMenuOption {rootMenu menu menuIndex menuEntryData} {
   upvar 1 options options

   variable gpGroup
   variable gpGroupState

   set menuEntryLabel   [lindex $menuEntryData 0]
   set menuEntryOptions [lrange $menuEntryData 1 end]
   set underline        [string first "_" $menuEntryLabel]

   regsub -all -- {_} $menuEntryLabel {} menuEntryLabel

   set menuEntry        [string tolower $menuEntryLabel]

   regsub -all -- { } $menuEntry {_} menuEntry

   if {$menuEntry eq "-" || $menuEntry eq "="} {
      $rootMenu.$menu add separator     
   } else {
      if {$menu eq ""} {
         set command     $rootMenu,$menuEntry
         set menuEntryID $rootMenu@$menuIndex
         set menuName    {}
      } else {
         set command     $rootMenu:$menu,$menuEntry
         set menuEntryID $rootMenu.$menu@$menuIndex
         set menuName    .$menu
      }
      set cascade     {}
      set compound    none
      set menuIcon    {}
      set state       $options(-state)
      set validate    0

      foreach item $menuEntryOptions {
         switch -regexp -- $item {
            ^% {
               set gpGroup($menuEntryID) [string range $item 1 end]
            }
            ^<$ {
               set state disabled
            }
            ^>$ {
               set state normal
            }
            ^!$ {
               set validate 1
            }
            ^@ {
               set cascade ".[string range $item 1 end]"
            }
            ^[.~].+ {
               set command [string range $item 1 end]
            }
            ^: {
               set menuIcon "::icon::[::icons::icons create -file [file join $options(-iconpath) $options(-iconfile)] [string range $item 1 end]]"
               set compound left
            }
         }
      }

      if {$options(-proc)} {
         set command "gpProc [::gridplus::gpCommandFormat $command]"
      } else {
         set command "$options(-prefix)[::gridplus::gpCommandFormat $command]"
      }

      if {[info exists gpGroup($menuEntryID)] && [info exists gpGroupState($gpGroup($menuEntryID))]} {
         set state $gpGroupState($gpGroup($menuEntryID))
      }

      if {$cascade ne ""} {
         $rootMenu$menuName add cascade -label [mc $menuEntryLabel] -menu $cascade -state $state -compound $compound -image $menuIcon -underline $underline
      } else {
         $rootMenu$menuName add command  -label [mc $menuEntryLabel] -command "::gridplus::gpCommand {$command} $options(name) $validate" -state $state -compound $compound -image $menuIcon -underline $underline
      }
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpNotebook                                       #
#        : ::gridplus::gpNotebookSet                                    #
# PURPOSE: Create notebook.                                             #
#=======================================================================#

proc ::gridplus::gpNotebook {} {
   upvar 1 options options

   global {}

   variable gpTabOrder

   if {$options(-subst)} {
      set options(layout) [subst -nobackslashes -nocommands $options(layout)]
   }

   ::ttk::notebook $options(name)

   if {$options(-command) ne ""} {
      set command "$options(-command) \[$options(name) index current\] \[$options(name) tab \[$options(name) index current\] -text\];"
   } else {
      set command ""
   }

   bind $options(name) <<NotebookTabChanged>> "${command}::gridplus::gpNotebookSet $options(name)"

   foreach {button item} $options(layout) {
      set pane [winfo name $item]

      $options(name) add [::ttk::frame $options(name).$pane] -text [mc $button]

      pack $item -in $options(name).$pane -expand 1 -fill both
   }

   ::gridplus::gpNotebookSet $options(name)

   if {$options(-wtitle) ne ""} {
      wm title [winfo toplevel $options(name)] [mc $options(-wtitle)]
   }
}

proc ::gridplus::gpNotebookSet {name} {
   global {}

   variable gpInfo
   variable gpValidations

   if {[info exists gpInfo(validation:failed)]} {
      foreach windowValidations [array names ::gridplus::gpValidations] {
         foreach windowValidation $windowValidations {
            foreach validationInfo $::gridplus::gpValidations($windowValidation) {
               foreach {entry validation} [split $validationInfo :] {}
               if {[info exists gpInfo(validation:failed)] && $gpInfo(validation:failed) eq $entry} {
                  if {! [::gridplus::gpValidate $entry $validation focusout - - 1]} {
                     ::gridplus::gpValidateFailed $entry
                  }
               }
            }
         }
      }

      if {[info exists gpInfo(validation:failed)]} {
         ::gridplus::gpNotebookIn $gpInfo(validation:failed)
         return
      }
   }

   variable gpTabOrder

   set pane  [$name index current]
   set panes [$name tabs]
   regsub -all .[winfo name $name] [lindex $panes $pane] {} item

   set gpTabOrder($name:000000) $item

   gpSetTabOrder $name
}

#=======================================================================#
# PROC   : ::gridplus::gpOptionAlias                                    #
# PURPOSE: Set value for option with "alias".                           #
#=======================================================================#

proc ::gridplus::gpOptionAlias {option alias} {
   upvar 1 options options

   if {$options($option) ne ""} {return $options($option)}
   if {$options($alias)  ne ""} {return $options($alias)}

   return {}
}

#=======================================================================#
# PROC   : ::gridplus::gpOptionset                                      #
# PURPOSE: Create optionset.                                            #
#=======================================================================#

proc ::gridplus::gpOptionset {} {
   upvar 1 options options

   variable gpOptionSets

   set gpOptionSets($options(name)) $options(layout)
}

#=======================================================================#
# PROC   : ::gridplus::gpPack                                           #
# PURPOSE: Pack specified layout where resizing is required.            #
#=======================================================================#

proc ::gridplus::gpPack {} {
   upvar 1 options options

   if {$options(-resize) eq ""} {
      pack $options(name)
      return
   }

   if {! [regexp -- {(^[.][^.]+)[.]} $options(name) -> window]} {
      set window "."
   }

   set resizeX 0
   set resizeY 0

   switch -- $options(-resize) {
      x  {set resizeX 1}
      y  {set resizeY 1}
      xy {set resizeX 1; set resizeY 1}
   }

   wm minsize $window 1 1

   update idletasks

   pack $options(name) -expand 1 -fill both

   update idletasks

   regexp -- {^([0-9]+)x([0-9]+)} [wm geometry $window] -> width height

   set width  [expr {int(($width  / 100.0) * $options(-minx))}]
   set height [expr {int(($height / 100.0) * $options(-miny))}]

   wm minsize   $window $width   $height
   wm resizable $window $resizeX $resizeY
}

#=======================================================================#
# PROC   : ::gridplus::gpParseEmbeddedGrid                              #
# PURPOSE: If column contains embedded grid, parse it.                  #
#=======================================================================#

proc ::gridplus::gpParseEmbeddedGrid {column} {

   if {! [regexp -- {[|][|:>&<=]} $column]} {return $column}

   set left  {}
   set right {}

   regsub -- {[|]:[|]} $column {|: __gpBar__ |:} column
   regsub -- {[|]>[|]} $column {|> __gpBar__ |:} column
   regsub -- {[|]<[|]} $column {|: __gpBar__ |>} column
   regsub -- {[|]=[|]} $column {|> __gpBar__ |>} column

   if {"||" in $column} {
      regexp -- {^(.*)\|\|(.*)$} $column -> left right 

      if {[regexp -- {[|][:>&]} $left]} {
         set grid [gpEmbeddedGridParse $left]
         set side left
      } else {
         set label $left
      }

      if {[regexp -- {[|][:>&]} $right]} {
         set grid [gpEmbeddedGridParse $right]
         set side right
      } else {
         set label $right
      }
   } else {
      set grid [gpEmbeddedGridParse $column]
      set side both
   }

   switch -- $side {
      left  {return "$grid .:ew $label"}
      right {return "$grid $label .:ew"}
      both  {return "$grid .:ew"}
   }
}

proc ::gridplus::gpEmbeddedGridParse {grid} {

   set columns       {}
   set stretch       {}
   set defaultWidget grid
   set leftStretch   0
   set rightStretch  1
   set style         {}

   if {[regexp -- {^(.+) [|][:]$} $grid -> left]} {
      set grid $left
      set leftStretch  1
      set rightStretch 0
   }

   if {[regexp -- {[|][#]([^ ]*)} $grid -> style]} {
      regsub -- {[|][#]([^ ]*)} $grid {} grid
      if {$style eq ""} {set style %}
   }

   if {[regexp -- {[|][&]([^ ]*)} $grid -> defaultWidget]} {
      regsub -- {[|][&]([^ ]*)} $grid {} grid
      if {$defaultWidget eq ""} {set defaultWidget "grid"}
   }

   while {[regexp -- {^([^|]*)([|][:>])(.*)$} $grid -> left op right]} {

      lappend columns $left

      switch -- $op {
         |: {lappend stretch 0}
         |> {lappend stretch 1;set rightStretch 0}
      }

      set grid $right
   }

   lappend columns $grid

   regsub -- {__gpBar__} $columns {|} columns

   set stretch "$leftStretch $stretch $rightStretch"

   return "{&& {$stretch} {$defaultWidget} {$style} $columns}"
}

#=======================================================================#
# PROC   : ::gridplus::gpParseTags                                      #
# PURPOSE: Parse tags for text widget.                                  #
#=======================================================================#

proc ::gridplus::gpParseTags {name tagText position} {

   regsub -all \{   $tagText {!ob:} tagText
   regsub -all \}   $tagText {!cb:} tagText
   regsub -all {\\} $tagText {!bs:} tagText

   set whitespace " \t\r\n"
   set pattern <(/?)(\[^$whitespace>]+)\[$whitespace]*(\[^>]*)>

   set substitute "\}\n::gridplus::gpInsertText $name {\\2} {\\1} {\\3} $position \{"
   regsub -all $pattern $tagText $substitute tagText

   eval "::gridplus::gpInsertText $name {init} {} {} $position {$tagText}"
}

#=======================================================================#
# PROC   : ::gridplus::gpSet                                            #
# PURPOSE: Gridplus Set values.                                         #
#=======================================================================#

proc ::gridplus::gpSet {} {
   upvar 1 options options

   variable gpConfig
   variable gpGroupState
   variable gpValidation

   foreach option [array names options -*] {
      switch -- $option {
         -century {
            set gpConfig(date:century) $options(-century)
         }
         -dateformat {
            switch -- $options(-dateformat) {
               eu {
                  set gpConfig(date:day)       0
                  set gpConfig(date:month)     1
                  set gpConfig(date:separator) .
               }
               uk {
                  set gpConfig(date:day)       0
                  set gpConfig(date:month)     1
                  set gpConfig(date:separator) /
               }
               us {
                  set gpConfig(date:day)       1
                  set gpConfig(date:month)     0
                  set gpConfig(date:separator) /
               }
               default {
                  error "GRIDPLUS ERROR: Invalid date format ($options(-dateformat))"
                  return
               }
            }
            set gpConfig(dateformat) $options(-dateformat)
         }
         -errormessage {
            set gpConfig(errormessage) $options(-errormessage)
         }
         -group {
            set gpGroupState($options(-group)) $options(-state)
            ::gridplus::gpSetGroup
         }
         -prefix {
            set gpConfig(prefix) $options(-prefix)
         }
         -proc {
            set gpConfig(proc) $options(-proc)
         }
         -validation {
            if {$options(-pattern) ne ""} {
               set gpValidation($options(-validation)) $options(-pattern)
               if {$options(-text) ne ""} {
                  set gpValidation($options(-validation):text) $options(-text)
               } else {
                  set gpValidation($options(-validation):text) $options(-validation)
               }
            }

         }
      }
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpSetFont                                        #
# PURPOSE: Gridplus Set font attributes.                                #
#=======================================================================#

proc ::gridplus::gpSetFont {attributes} {

   set font [dict create {*}[font configure TkDefaultFont]]

   foreach attribute $attributes {
      switch -regexp -- $attribute {
         {^[0-9]+$} {
            set font [dict replace $font -size $attribute]
         }
         {^[+][0-9]+$} {
            set font [dict replace $font -size [expr {[dict get $font -size] + $attribute}]]
         }
         {^[-][0-9]+$} {
            set font [dict replace $font -size [expr {[dict get $font -size] - $attribute}]]
         }
         {^bold$} {
            set font [dict replace $font -weight bold]
         }
         {^underline$} {
            set font [dict replace $font -underline 1]
         }
         {^italic$} {
            set font [dict replace $font -slant italic]
         }
      }
   }

   return $font
}

#=======================================================================#
# PROC   : ::gridplus::gpSetFontSize                                    #
# PURPOSE: Gridplus Set font size for "tagged" text widget.             #
#=======================================================================#

proc ::gridplus::gpSetFontSize {defaultSize newSize} {

   switch -regexp -- $newSize {
      {^[0-9]+$} {
         set fontSize $newSize
      } 
      {^[+][0-9]+$} {
         set value [string range $newSize 1 end]
         set fontSize [expr {$defaultSize + $value}]
      }
      {^[-][0-9]+$} {
         set value [string range $newSize 1 end]
         set fontSize [expr {$defaultSize - $value}]
      }
      default {
         set fontSize $defaultSize
      }
   }

   return $fontSize
}

#=======================================================================#
# PROC   : ::gridplus::gpSetGroup                                       #
# PURPOSE: Gridplus Set widgets state to "group" state.                 #
#=======================================================================#

proc ::gridplus::gpSetGroup {} {
   variable gpGroup
   variable gpGroupState

   foreach item [array names gpGroup] {
      if {[info exists gpGroupState($gpGroup($item))]} {
         if {[regexp {^([^@]+)@(.+)$} $item -> configureItem index]} {
            $configureItem entryconfigure $index -state $gpGroupState($gpGroup($item))
         } else {
            if {[string match *Entry [winfo class $item]] && $gpGroupState($gpGroup($item)) eq "disabled"} {
               $item configure -state [gpGetOption Gridplus.entryDisabled readonly]
            } else {
               $item configure -state $gpGroupState($gpGroup($item))
            }
         }
      }
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpSetOptionset                                   #
# PURPOSE: Set optionset options.                                       #
#=======================================================================#

proc ::gridplus::gpSetOptionset {} {
   upvar 1 options options

   variable gpOptionSets

   if {$options(-optionset) eq ""} {
      if {$options(-style) ne "" && [info exists gpOptionSets($options(-style))] && [gpGetOption Gridplus.optionSetStyle 1]} {
         set options(-optionset) $options(-style)
      } else {
         return
      }
   }

   if {[info exists gpOptionSets($options(-optionset))]} {
      foreach {option value} $gpOptionSets($options(-optionset)) {
         if {$option eq "-pad"} {
            set options(-padx) $value
            set options(-pady) $value
         } else {
            set options($option) $value
         }
      }
   } else {
      error "GRIDPLUS ERROR: Invalid optionset ($options(-optionset))"
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpSetTabOrder                                    #
# PURPOSE: Gridplus Set widgets to correct "tab" order.                 #
#=======================================================================#

proc ::gridplus::gpSetTabOrder {name} {
   variable gpTabOrder

   foreach item [lsort [array names gpTabOrder $name:*]] {
      raise $gpTabOrder($item)
      ::gridplus::gpSetTabOrder $gpTabOrder($item)
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpTablelist                                      #
# PURPOSE: Create tablelist.                                            #
#=======================================================================#

proc ::gridplus::gpTablelist {} {
   upvar 1 options options

   global {}

   variable gpGroup
   variable gpGroupState
   variable gpInfo
   variable gpUnknown

   if {! [regexp -- {^[.]([^.]+)[.]} $options(name) -> window]} {
      set window {}
   }

   set gpInfo($options(name):action)        $options(-action)
   set gpInfo($options(name):columnsort)    $options(-columnsort)
   set gpInfo($options(name):iconlibrary)   [file join $options(-iconpath) $options(-iconfile)]
   set gpInfo($options(name):insertexpr)    $options(-insertexpr)
   set gpInfo($options(name):insertoptions) $options(-insertoptions)
   set gpInfo($options(name):selectfirst)   $options(-selectfirst)
   set gpInfo($options(name):selectmode)    $options(-selectmode)
   set gpInfo($options(name):sortorder)     $options(-sortorder)
   set gpInfo($options(name):validate)      $options(-validate)
   set gpInfo($options(name):window)        .$window

   set state $options(-state)

   if {$options(-group) ne ""} {
      set gpGroup($options(name).tablelist) $options(-group)
   }
   if {[info exists gpGroup($options(name).tablelist)] && [info exists gpGroupState($gpGroup($options(name).tablelist))]} {
      set state $gpGroupState($gpGroup($options(name).tablelist))
   }

#-------------------------------------#
# Deal with "hide" columns in layout. #
#-------------------------------------#

   set column -1
   set count  0
   set first  0
   set hide   {}
   set index  0

   foreach item $options(layout) {

      if {[string is integer $item]} {
         set  count 0
         incr column
      }
      if {$item eq "hide" && $count == 2} {
         lappend hide $column
         set options(layout) [lreplace $options(layout) $index $index]
         incr index -1
         if {$column == $first} {
            incr first
         }
      }
      incr count
      incr index
   }

   if {$options(-sortfirst)} {
      set gpInfo($options(name):firstcolumn) 0
   } else {
      set gpInfo($options(name):firstcolumn) $first
   }

   if {$options(-relief) eq "theme"} {
      if {$options(-labelanchor) eq ""} {
         ::ttk::labelframe $options(name) -padding $options(-padding) -text [mc $options(-title)]
      } else {
         ::ttk::labelframe $options(name) -labelanchor $options(-labelanchor) -padding $options(-padding) -text [mc $options(-title)]
      }
   } else {
      ::ttk::frame $options(name) -padding $options(-padding) -relief $options(-relief)
   }

   tablelist::tablelist $options(name).tablelist                        \
                        -columns         $options(layout)               \
                        -exportselection 0                              \
                        -height          $options(-height)              \
                        -listvariable    $options(-listvariable)        \
                        -selectmode      $options(-selectmode)          \
                        -state           $state                         \
                        -stretch         all                            \
                        -width           $options(-width)               \
                        -xscrollcommand  [list $options(name).xbar set] \
                        -yscrollcommand  [list $options(name).ybar set] \
                        -takefocus       0                              \

   if {$options(-columnsort)} {
      $options(name).tablelist configure -labelcommand ::tablelist::sortByColumn
   }

   ::ttk::scrollbar $options(name).xbar -orient horizontal -command [list $options(name).tablelist xview]
   ::ttk::scrollbar $options(name).ybar -orient vertical   -command [list $options(name).tablelist yview]

   foreach item $hide {
      $options(name).tablelist columnconfigure $item -hide 1
   }

   grid $options(name).tablelist -row 0 -column 0 -sticky news

   switch -- $options(-scroll) {
      x {
         grid $options(name).xbar -row 1 -column 0 -sticky ew
      }
      y {
         grid $options(name).ybar -row 0 -column 1 -sticky ns
      }
      xy {
         grid $options(name).xbar -row 1 -column 0 -sticky ew
         grid $options(name).ybar -row 0 -column 1 -sticky ns
      }
   }

   grid rowconfigure    $options(name) 0 -weight 1
   grid columnconfigure $options(name) 0 -weight 1

   foreach item $options(-tableoptions) {
      switch -- $item {
         stripe {
            $options(name).tablelist configure -stripebackground #e0e8f0
         }
         separator {
            $options(name).tablelist configure -showseparators yes
         }
      } 
   }

   if {[info exists gpUnknown]} {
      foreach {unkownItem unknownValue} [array get gpUnknown] {
         $options(name).tablelist configure $unkownItem $unknownValue
      }
   }

   if {$options(-proc)} {
      set command "gpProc [::gridplus::gpCommandFormat $options(name)]"
   } else {
      if {$options(-command) eq ""} {
         set command "$options(-prefix)[::gridplus::gpCommandFormat $options(name)]"
      } else {
         set command $options(-command)
      }
   }

   set gpInfo($options(name):command) $command

   switch -- $options(-action) {
      double {
         bind [$options(name).tablelist bodypath] <Button-1> "after 1 [list ::gridplus::gpTablelistSelect $options(name) \[$options(name).tablelist curselection\] .$window 0]"
         bind [$options(name).tablelist bodypath] <Double-1> "after 1 [list ::gridplus::gpCommand [list $command] .$window $options(-validate)]"
      }
      single {
         bind [$options(name).tablelist bodypath] <Button-1> "after 1 [list ::gridplus::gpTablelistSelect $options(name) \[$options(name).tablelist curselection\] .$window $options(-validate) [list $command]]"
      }
      default {
         bind [$options(name).tablelist bodypath] <Button-1> "after 1 [list ::gridplus::gpTablelistSelect $options(name) \[$options(name).tablelist curselection\] .$window $options(-validate)]"
      }
   }

   if {$options(-menu) ne ""} {
      bind [$options(name).tablelist bodypath] <Button-3> "after 1 {::gridplus::gpTablelistMenu $options(-menu) %x %y %X %Y %W $options(name)}"
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpTablelistInsertExpr                            #
# PURPOSE: Expand tablelist insert expression.                          #
#=======================================================================#

proc ::gridplus::gpTablelistInsertExpr {name line} {
   upvar 1 options options

   variable gpInfo

   if {$gpInfo($name:insertexpr) eq ""} {
      return
   }

   regsub -all -- {%([0-9][0-9]*)} $gpInfo($name:insertexpr) {[lindex $line \1]} insertExpr

   eval "if {$insertExpr} {set result 1} else {set result 0}"

   if {$result} {
      ::gridplus::gpTablelistInsertOptions $name
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpTablelistInsertOptions                         #
# PURPOSE: Process tablelist insert options.                            #
#=======================================================================#

proc ::gridplus::gpTablelistInsertOptions {name} {
   upvar 1 options options

   variable gpInfo

   foreach insertOption $gpInfo($name:insertoptions) {
      if {[lindex $insertOption 0] eq "*"} {
         regsub -- {[*]} $insertOption {end} insertOption
         eval "$name.tablelist rowconfigure $insertOption"
      } else {
         eval "$name.tablelist cellconfigure end,$insertOption"
      }
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpTablelistMenu                                  #
# PURPOSE: Right-click pop-up menu for tablelist.                       #
#=======================================================================#

proc ::gridplus::gpTablelistMenu {menu x y X Y W name} {
   global {}

   foreach {Widget xPosition yPosition} [tablelist::convEventFields $W $x $y] {}
   set row [$name.tablelist nearest $yPosition]

   $name.tablelist selection clear 0 end
   $name.tablelist selection set   $row

   set ($name) [$name.tablelist get $row]

   $menu post $X $Y
}

#=======================================================================#
# PROC   : ::gridplus::gpTablelistSelect                                #
# PURPOSE: Sets value for tablelist selections.                         #
#=======================================================================#

proc ::gridplus::gpTablelistSelect {name selection window validate {command {}}} {
   upvar 1 options options

   global {}

   variable gpInfo

   set count [llength $selection]
   set value [$name.tablelist get $selection]

   if {$gpInfo($name:selectmode) eq "multiple" || $gpInfo($name:selectmode) eq "extended"} {
      if {$count == 1} {
         set ($name) [list $value]
      } else {
         set ($name) $value
      }
   } else {
      set ($name) $value
   }

   if {$command ne ""} {{*}[list ::gridplus::gpCommand $command $window $validate]}

}

#=======================================================================#
# PROC   : ::gridplus::gpTablelistInsert                                #
# PURPOSE: Inserts line into tablelist.                                 #
#=======================================================================#

proc ::gridplus::gpTablelistInsert {item position line} {
   variable gpInfo

   set   column    0
   set   tableLine {}

   unset -nocomplain tableIcon

   foreach tableColumn $line {
      if {[regexp -- {^:([^ ]+) ?} $tableColumn -> tableIcon($column)]} {
         regsub -- {^:([^ ]+) ?} $tableColumn {} tableColumn
      }
      lappend tableLine $tableColumn
      incr column
   }

   $item.tablelist insert $position $tableLine

   if {[info exists tableIcon]} {
      foreach iconColumn [array names tableIcon] {
         set icon  $tableIcon($iconColumn)
         set image "::icon::$icon"
         if {$image ni [image names]} {::icons::icons create -file $gpInfo($item:iconlibrary) $icon}
         $item.tablelist cellconfigure $position,$iconColumn -image $image
      }
   }

   gpTablelistInsertExpr $item $line
}

#=======================================================================#
# PROC   : ::gridplus::gpText                                           #
# PURPOSE: Create text.                                                 #
#=======================================================================#

proc ::gridplus::gpText {} {
   upvar 1 options options

   global {}

   variable gpGroup
   variable gpGroupState
   variable gpInfo

   set state $options(-state)

   if {$options(-group) ne ""} {
      set gpGroup($options(name).text) $options(-group)
   }
   if {[info exists gpGroup($options(name).text)] && [info exists gpGroupState($gpGroup($options(name).text))]} {
      set state $gpGroupState($gpGroup($options(name).text))
   }

   if {$options(-relief) eq "theme"} {
      if {$options(-labelanchor) eq ""} {
         ::ttk::labelframe $options(name) -padding $options(-padding) -text [mc $options(-title)]
      } else {
         ::ttk::labelframe $options(name) -labelanchor $options(-labelanchor) -padding $options(-padding) -text [mc $options(-title)]
      }
   } else {
      ::ttk::frame $options(name) -padding $options(-padding) -relief $options(-relief)
   }

   text $options(name).text                                                                           \
        -background     white                                                                         \
        -height         $options(-height)                                                             \
        -font           TkTextFont                                                                    \
        -state          $state                                                                        \
        -tabs           {0.5c 1c 1.5c 2c 2.5c 3.0c 3.5c 4.0c 4.5c 5.0c 5.5c 6.0c 6.5c 7.0c 7.5c 8.0c} \
        -takefocus      $options(-takefocus)                                                          \
        -width          $options(-width)                                                              \
        -wrap           $options(-wrap)                                                               \
        -xscrollcommand [list $options(name).xbar set]                                                \
        -yscrollcommand [list $options(name).ybar set]                                                \

   ::ttk::scrollbar $options(name).xbar -orient horizontal -command [list $options(name).text xview]
   ::ttk::scrollbar $options(name).ybar -orient vertical   -command [list $options(name).text yview]

   grid $options(name).text -row 0 -column 0 -sticky news

   switch -- $options(-scroll) {
      x {
         grid $options(name).xbar -row 1 -column 0 -sticky ew
      }
      y {
         grid $options(name).ybar -row 0 -column 1 -sticky ns
      }
      xy {
         grid $options(name).xbar -row 1 -column 0 -sticky ew
         grid $options(name).ybar -row 0 -column 1 -sticky ns
      }
   }

   grid rowconfigure    $options(name) 0 -weight 1
   grid columnconfigure $options(name) 0 -weight 1

   if {$options(-tags)} {
      set normalColor [lindex [split $options(-linkcolor) /] 0]
      set overColor   [lindex [split $options(-linkcolor) /] 1]
      set normalStyle [lindex [split $options(-linkstyle) /] 0]
      set overStyle   [lindex [split $options(-linkstyle) /] 1]

      regsub -- {[&]} $overStyle $normalStyle, overStyle

      if {! [string match */* $options(-linkcolor)]} {set overColor $normalColor}
      if {! [string match */* $options(-linkstyle)]} {set overStyle $normalStyle}

      if {$normalColor eq ""} {set normalColor "blue"}
      if {$overColor   eq ""} {set overColor "blue"}

      if {$normalStyle eq "underline"} {
         set normalStyle "true"
      } else {
         set normalStyle "false"
      }
      if {$overStyle eq "underline"} {
         set overStyle "true"
      } else {
         set overStyle "false"
      }

      set gpInfo($options(name):bgcolor)     white
      set gpInfo($options(name):defaultbg)   white
      set gpInfo($options(name):defaultfg)   black
      set gpInfo($options(name):defaultfont) helvetica
      set gpInfo($options(name):defaultsize) [::gridplus::gpGetFontSize [$options(name).text cget -font]]
      set gpInfo($options(name):fgcolor)     black
      set gpInfo($options(name):font)        [lindex [$options(name).text cget -font] 0]
      set gpInfo($options(name):iconlibrary) [file join $options(-iconpath) $options(-iconfile)]
      set gpInfo($options(name):indent)      0
      set gpInfo($options(name):link)        blue
      set gpInfo($options(name):linkcursor)  $options(-linkcursor)
      set gpInfo($options(name):normalcolor) $normalColor
      set gpInfo($options(name):normalstyle) $normalStyle
      set gpInfo($options(name):overcolor)   $overColor
      set gpInfo($options(name):overstyle)   $overStyle
      set gpInfo($options(name):prefix)      $options(-prefix)
      set gpInfo($options(name):proc)        $options(-proc)
      set gpInfo($options(name):size)        [::gridplus::gpGetFontSize [$options(name).text cget -font]]
      set gpInfo($options(name):tagid)       0
      set gpInfo($options(name):tags)        1

      $options(name).text configure -cursor {} -state disabled
   } else {
      if {$options(-font) ne ""} {
         $options(name).text configure -font $options(-font)
      }

      set gpInfo($options(name):tags)        0
   }

   menu $options(name).text.edit -tearoff 0

   if {$options(-tags) || $options(-state) eq "disabled"} {
      $options(name).text.edit add command -label [mc "Copy"]  -command "tk_textCopy $options(name).text"
      $options(name).text.edit add separator
      $options(name).text.edit add command -label [mc "Find"]  -command "::gridplus::gpTextFind $options(name).text"
   } else {
      $options(name).text.edit add command -label [mc "Cut"]   -command "tk_textCut $options(name).text;$options(name).text edit modified 1"
      $options(name).text.edit add command -label [mc "Copy"]  -command "tk_textCopy $options(name).text"
      $options(name).text.edit add command -label [mc "Paste"] -command "tk_textPaste $options(name).text;$options(name).text edit modified 1"
      $options(name).text.edit add separator
      $options(name).text.edit add command -label [mc "Find"]  -command "::gridplus::gpTextFind $options(name).text"
   }

   if {$options(-command) ne ""} {
      bind $options(name).text <<Modified>> "::gridplus::gpTextSet $options(name) ; eval $options(-command)"
   } else {
      bind $options(name).text <<Modified>> "::gridplus::gpTextSet $options(name)"
   }

   bind $options(name).text <ButtonPress-3> "tk_popup $options(name).text.edit %X %Y"
   bind $options(name).text <Tab>           "[bind all <Tab>];break"
   bind $options(name).text <Shift-Tab>     "[bind all <<PrevWindow>>]; break"

   set ($options(name)) {}

   if {$options(-autogroup) ne ""} {
      set autoGroupCommand "::gridplus::gpAutoGroup $options(name) $options(-autogroup) normal"
      trace add variable ($options(name)) write $autoGroupCommand
   }

}

#=======================================================================#
# PROC   : ::gridplus::gpTextSet                                        #
# PURPOSE: Set contents of GRIDPLUS Text.                               #
#=======================================================================#

proc ::gridplus::gpTextSet {item} {
   global {}

   if {[$item.text edit modified]} {
      set ($item) {}

      foreach {key text index} [$item.text dump -text 1.0 end] {
         set ($item) "$($item)$text"
      }

      $item.text edit modified 0
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpTextInsert                                     #
# PURPOSE: Inserts line into text.                                      #
#=======================================================================#

proc ::gridplus::gpTextInsert {item position line} {
   variable gpInfo

   set textState [$item.text cget -state]

   $item.text configure -state normal

   if {$position eq "end"} {
      set insertPosition end
   } else {
      set insertPosition $position.0
   }

   if {$gpInfo($item:tags)} {
      if {$position eq "end"} {
         ::gridplus::gpParseTags $item $line $insertPosition
         $item.text insert $insertPosition "\n"
      } else {
         $item.text insert $position.0 "\n"
         ::gridplus::gpParseTags $item $line $position.end
      }
      $item.text tag raise sel
   } else {
      $item.text insert $insertPosition "$line\n"
      $item.text edit modified 0
      set ($item) {}
      foreach {key text index} [$item.text dump -text 1.0 end] {
         set ($item) "$($item)$text"
      }
   }

   $item.text configure -state $textState
}

#=======================================================================#
# PROC   : ::gridplus::gpTextFind                                       #
# PURPOSE: Find string in GRIDPLUS Text.                                #
#=======================================================================#

proc ::gridplus::gpTextFind {item} {
   variable gpInfo

   if {[winfo exists .gpTextFind]} {
      ::gridplus::gpTextFind:action,cancel
   }

   if {[string match *?.text $item]} {
      set gpInfo(<gpTextFindItem>) $item
   } else {
      set gpInfo(<gpTextFindItem>) $item.text
   }

   gridplus window .gpTextFind -topmost 1 -wcmd ::gridplus::gpTextFind:action,cancel -wtitle Find

   gridplus checkbutton .gpTextFind.match -padding 0 {
      {.word "Match whole word only"}
      {.case "Match case"}
   }

   gridplus radiobutton .gpTextFind.direction -title Direction {
      {.up Up -backwards} {.down Down +forwards}
   }

   gridplus button .gpTextFind.action -prefix gridplus:: {
      {&e "Find What: " .string 38 + >next ~gpTextFind.action,next} {"Find Next" .next < %next}
      {{&w @gpTextFind.match @gpTextFind.direction}}                {"Cancel" .cancel}
   }

   pack .gpTextFind.action
}

#=======================================================================#
# PROC   : ::gridplus::gpTextFind:action,next                           #
# PURPOSE: Find next/previous occurance of string in GRIDPLUS Text.     #
#=======================================================================#

proc ::gridplus::gpTextFind:action,next {} {
   global {}

   variable gpInfo

   if {$(.gpTextFind.direction) eq "forwards"} {
      set searchIndex "insert+1char"
   } else {
      set searchIndex "insert"
   }

   if {$(.gpTextFind.match,word)} {
      set matchWord "-regexp"
      set pattern "\[\[:<:\]\]$(.gpTextFind.action,string)\[\[:>:\]\]"
   } else {
      set matchWord "-exact"
      set pattern "$(.gpTextFind.action,string)"
   }

   if {$(.gpTextFind.match,case)} {
      set matchCase "--"
   } else {
      set matchCase "-nocase"
   }

   set position [$gpInfo(<gpTextFindItem>) search -$(.gpTextFind.direction) $matchWord $matchCase $pattern $searchIndex]

   if {$position ne ""} {
      catch "$gpInfo(<gpTextFindItem>) tag remove sel sel.first sel.last"
      $gpInfo(<gpTextFindItem>) tag add sel $position $position+[string length $(.gpTextFind.action,string)]chars
      $gpInfo(<gpTextFindItem>) configure -inactiveselectbackground [$gpInfo(<gpTextFindItem>) cget -selectbackground]
      $gpInfo(<gpTextFindItem>) mark set insert $position
      $gpInfo(<gpTextFindItem>) see $position
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpTextFind:action,cancel                         #
# PURPOSE: Cancel/close Find dialog.                                    #
#=======================================================================#

proc ::gridplus::gpTextFind:action,cancel {} {
   global {}

   variable gpInfo

   set gpInfo(<gpTextFindItem>) {}

   gridplus clear .gpTextFind
   destroy .gpTextFind
}

#=======================================================================#
# PROC   : ::gridplus::gpTree                                           #
# PURPOSE: Create tree.                                                 #
#=======================================================================#

proc ::gridplus::gpTree {} {
   upvar 1 options options

   global {}

   variable gpInfo

   if {! [regexp -- {^[.]([^.]+)[.]} $options(name) -> window]} {
      set window {}
   }

   set gpInfo($options(name):action)       $options(-action)
   set gpInfo($options(name):fileicon)     $options(-fileicon)
   set gpInfo($options(name):foldericon)   $options(-foldericon)
   set gpInfo($options(name):iconlibrary)  [file join $options(-iconpath) $options(-iconfile)]
   set gpInfo($options(name):icons)        $options(-icons)
   set gpInfo($options(name):open)         $options(-open)
   set gpInfo($options(name):validate)     $options(-validate)
   set gpInfo($options(name):window)       .$window
  
   if {$options(-relief) eq "theme"} {
      if {$options(-labelanchor) eq ""} {
         ::ttk::labelframe $options(name) -padding $options(-padding) -text [mc $options(-title)]
      } else {
         ::ttk::labelframe $options(name) -labelanchor $options(-labelanchor) -padding $options(-padding) -text [mc $options(-title)]
      }
   } else {
      ::ttk::frame $options(name) -padding $options(-padding) -relief $options(-relief)
   }

   ::ttk::treeview $options(name).tree                 \
        -cursor         left_ptr                       \
        -height         $options(-height)              \
        -show           $options(-show)                \
        -yscrollcommand [list $options(name).ybar set]

   $options(name).tree column #0 -width $options(-width)

   ::ttk::scrollbar $options(name).ybar -orient vertical -command [list $options(name).tree yview]

   grid $options(name).tree -row 0 -column 0 -sticky news

   switch -- $options(-scroll) {
      x {
         puts "X scroll not supported in this version"
#        grid $options(name).xbar -row 1 -column 0 -sticky ew
      }
      y {
         grid $options(name).ybar -row 0 -column 1 -sticky ns
      }
      xy {
         puts "X scroll not supported in this version"
#        grid $options(name).xbar -row 1 -column 0 -sticky ew
         grid $options(name).ybar -row 0 -column 1 -sticky ns
      }
   }

   grid rowconfigure    $options(name) 0 -weight 1
   grid columnconfigure $options(name) 0 -weight 1

   if {$options(-proc)} {
      set command "gpProc [::gridplus::gpCommandFormat $options(name)]"
   } else {
      if {$options(-command) eq ""} {
         set command "$options(-prefix)[::gridplus::gpCommandFormat $options(name)]"
      } else {
         set command $options(-command)
      }
   }

   set gpInfo($options(name):command) $command

   switch -- $options(-action) {
      double {
         bind $options(name).tree <Button-1> "after 1 [list ::gridplus::gpTreeSelect $options(name) .$window 0]"
         bind $options(name).tree <Double-1> "after 1 [list ::gridplus::gpCommand [list $command] .$window $options(-validate)]"
      }
      single {
         bind $options(name).tree <Button-1> "after 1 [list ::gridplus::gpTreeSelect $options(name) .$window $options(-validate) [list $command]]"
      }
      default {
         bind $options(name).tree <Button-1> "after 1 [list ::gridplus::gpTreeSelect $options(name) .$window $options(-validate)]"
      }
   }

   if {$options(-menu) ne ""} {
      bind $options(name).tree <Button-3> "after 1 {::gridplus::gpTreeMenu $options(-menu) %x %y %X %Y %W $options(name)}"
   }

   if {[lsearch [image names] ::icon::$options(-fileicon)] < 0} {
      ::icons::icons create -file [file join $options(-iconpath) $options(-iconfile)] $options(-fileicon)
   }
   if {[lsearch [image names] ::icon::$options(-foldericon)] < 0} {
      ::icons::icons create -file [file join $options(-iconpath) $options(-iconfile)] $options(-foldericon)
   }

   set ($options(name)) {}
}

#=======================================================================#
# PROC   : ::gridplus::gpTreeMenu                                       #
# PURPOSE: Right-click pop-up menu for tree.                            #
#=======================================================================#

proc ::gridplus::gpTreeMenu {menu x y X Y W name} {
   global {}

   $name.tree selection remove $($name)

   set item [lindex [$name.tree identify $x $y] 1]

   $name.tree selection set $item

   set ($name) [$name.tree selection]

   $menu post $X $Y
}

#=======================================================================#
# PROC   : ::gridplus::gpTreeSelect                                     #
# PURPOSE: Sets value for tree selections.                              #
#=======================================================================#

proc ::gridplus::gpTreeSelect {name window validate {command {}}} {
   global {}

   set ($name) [$name.tree selection]

   if {$command ne ""} {{*}[list ::gridplus::gpCommand $command $window $validate]}
}

#=======================================================================#
# PROC   : ::gridplus::gpTreeSet                                        #
# PURPOSE: Set contents of GRIDPLUS Tree.                               #
#=======================================================================#

proc ::gridplus::gpTreeSet {name nodes} {
   variable gpInfo

   $name.tree delete [$name.tree children {}]

   foreach node $nodes {
      set icon     {}
      set nodeText {}
      set nodeType file

      foreach item $node {
         switch -regexp -- $item {
            ^: {
               set icon [string range $item 1 end]
            }
            ^[+]$ {
               set nodeType folder
            }
            ^[/] {
               regsub -all { } $item "\034" nodeFullName
            }
            default {
               set nodeText $item
            }
         }

      }

      if {! [regexp {^(.*/)([^/]+)$} $nodeFullName -> path nodeName]} {
         set path     $nodeFullName
         set nodeName $nodeFullName
         set indent   ""
      }

      if {$nodeText ne ""} {
         set nodeName $nodeText
      } else {
         regsub -all "\034" $nodeName { } nodeName
      }

      set nodeName [mc $nodeName]

      if {$icon eq ""} {
         set icon $gpInfo($name:${nodeType}icon)
      } else {
         if {[lsearch [image names] ::icon::$icon] < 0} {
            ::icons::icons create -file $gpInfo($name:iconlibrary) $icon
         }
      }

      if {$path eq "/"} {
         set parent {}
      } else {
         regsub -- {/$} $path {} parent
      }

      if {$gpInfo($name:icons)} {
         $name.tree insert $parent end -id $nodeFullName -image ::icon::$icon -open $gpInfo($name:open) -text $nodeName
      } else {
         $name.tree insert $parent end -id $nodeFullName -open $gpInfo($name:open) -text $nodeName
      }
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpValidateFailed                                 #
# PURPOSE: Sets focus to failed validation entry.                       #
#=======================================================================#

proc ::gridplus::gpValidateFailed {item} {

   variable gpInfo

   if {! [winfo exists $item]} {
      return
   }

   set focus [focus]

   if {[string compare {} $focus] && [winfo class $focus] eq "Entry"} {
      $focus selection clear

      if {[regexp {^(focus(out)?|all)} [set validate [$focus cget -validate]]]} {
         $focus configure -validate none
         after idle [list $focus configure -validate $validate]
      }
   }

   after 1 [list focus $item]
}

#=======================================================================#
# PROC   : ::gridplus::gpValidate                                       #
# PURPOSE: Validates contents of entry.                                 #
#=======================================================================#

proc ::gridplus::gpValidate {item validation condition prevalue fixed auto} {
   global {}

   variable gpConfig
   variable gpInfo
   variable gpValidateError
   variable gpValidation

   if {$condition eq "key"} {
      if {[string length $prevalue] > $fixed} {
         return 0
      }
      return 1
   }

   if {$validation eq "__gpFixed__" || $condition ne "focusout" || ! $auto} {
      return 1
   }

   if {[info exists gpInfo(validation:failed)] && $gpInfo(validation:failed) ne $item} {
      if {[winfo toplevel $gpInfo(validation:failed)] ne [winfo toplevel $item]} {
         unset gpInfo(validation:failed)
      } else {
         return 1
      }
   }

   set focus [focus]

   if {$focus eq "" || [winfo class $focus] eq "Toplevel" || [winfo class $focus] eq "Button"} {
      return 1
   }

   if {! [regexp {^([.][^.,]+)} $item -> window]} {
      set window {}
   } else {
      if {[winfo class $window] ne "Toplevel"} {
         set window {}
      }
   }

   set validationOK 0

   regexp -- {@?([^:?]+)(:([^?]*))*([?](.*))*} $validation -> validationName -> parameter -> errorText

   if {[string match @* $validation] && $($item) eq ""} {
      set validationOK 1
   } else {
      switch -glob -- $gpValidation($validationName) {
         proc:* {
            set validateProc [string range $gpValidation($validationName) 5 end]
            if {[$validateProc $item $parameter]} {
               set validationOK 1
            }
         }
         default {
            if {[regexp $gpValidation($validationName) $($item)]} {
               set validationOK 1
            }
         }
      }
   }

   if $validationOK {
      $item configure -foreground black

      if {[winfo exists $window.errormessage]} {
         $window.errormessage configure -text {}
      }

      unset -nocomplain gpInfo(validation:failed)
      ::gridplus::gpValidateErrorCancel - -
      return 1
   } else {
      ::gridplus::gpNotebookIn $item

      update idletasks

      if {[winfo exists $window.errormessage]} {
         $window.errormessage configure -text $gpValidateError($item:text)
      }

      if {$gpValidateError($item:popup)} {
         ::gridplus::gpValidateErrorShow $item
      }

      $item configure -foreground red

      set gpInfo(validation:failed) $item

      return 0
   }
}

#=======================================================================#
# PROCS  : ::gridplus::gpValidateErrorInit                              #
#        : ::gridplus::gpValidateErrorCancel                            #
#        : ::gridplus::gpValidateErrorShow                              #
# PURPOSE: Gridplus widget validation "pop-up" error message.           #
#=======================================================================#

proc ::gridplus::gpValidateErrorInit {item message {mode label}} {
   variable gpValidateError

   if {! [winfo exists .gpValidateError]} {
      toplevel .gpValidateError -background black -borderwidth 1 -relief flat
      label    .gpValidateError.message -background red -foreground white
      pack     .gpValidateError.message
      wm overrideredirect .gpValidateError 1
      wm withdraw         .gpValidateError
   }

   if {$mode eq "popup"} {
      set gpValidateError($item:popup) 1
   } else {
      set gpValidateError($item:popup) 0
   }

   set gpValidateError($item:text) $message
}

proc ::gridplus::gpValidateErrorCancel {testWindow eventWindow} {
   variable gpValidateError

   if {$testWindow eq $eventWindow} {
      if {[winfo exists .gpValidateError]} {
         wm withdraw .gpValidateError
      }
   }
}

proc ::gridplus::gpValidateErrorShow {item} {
   variable gpValidateError

   .gpValidateError.message configure -text $gpValidateError($item:text)
 
   set helpX [expr [winfo rootx $item] + 10]
   set helpY [expr [winfo rooty $item] + [expr {[winfo height $item] - 1}]]
 
   wm geometry  .gpValidateError +$helpX+$helpY
   wm deiconify .gpValidateError
 
   raise .gpValidateError
}

#=======================================================================#
# PROC   : ::gridplus::gpValidateText                                   #
# PURPOSE: Returns formatted validation message text.                   #
#=======================================================================#

proc ::gridplus::gpValidateText {validation} {
   variable gpConfig
   variable gpValidation

   regexp -- {@?([^:?]+)(:([^?]*))*([?](.*))*} $validation -> validationName -> parameter -> errorText

   if {$errorText eq ""} {
      set errorText    [mc $gpValidation($validationName:text)]
      set errorMessage [mc $gpConfig(errormessage)]
      regsub {%} $errorText    $parameter errorText
      regsub {%} $errorMessage $errorText errorMessage
      return $errorMessage
   } else {
      return $errorText
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpValidateDate                                   #
# PURPOSE: Validates for valid date.                                    #
#=======================================================================#

proc ::gridplus::gpValidateDate {entry parameter} {
   global {}

   foreach {month day year} [::gridplus::gpFormatDate $($entry) internal] {}

   set day    [scan $day   "%d"]
   set month  [scan $month "%d"]
   set result 0

   if {$month < 1 || $month > 12} {
      return 0
   } else {

      if {$day < 1 || $day > [::gridplus::gpCalMonthDays $month $year]} {
         return 0
      } else {
         set ($entry) [::gridplus::gpFormatDate $($entry) application]
         $entry configure -validate focusout
         return 1
      }
   }
}

#=======================================================================#
# PROCS  : ::gridplus::gpGridIn                                         #
#        : ::gridplus::gpPackIn                                         #
#        : ::gridplus::gpNotebokIn                                      #
# PURPOSE: If validated entry in notebooks elect pane containing entry. #
#=======================================================================#

proc ::gridplus::gpGridIn {name} {

   array set info [grid info $name]

   if {[info exists info(-in)]} {
      return $info(-in)
   } else {
      return {}
   }
}

proc ::gridplus::gpPackIn {name} {
   
   if {! [catch "pack info $name"]} {
      array set info [pack info $name]
      return $info(-in)
   } else {
      return {}
   }
}

proc ::gridplus::gpNotebookIn {name} {
   global {}

   variable gpTabOrder

   set in $name

   while {[set in [gpGridIn $in]] ne ""} {
      set lastIn $in
   }

   set in $lastIn

   while {[set in [gpPackIn $in]] ne ""} {
      set lastIn $in
   }

   set toplevelLastIn {}

   if {[winfo class $lastIn] eq "Toplevel"} {
      foreach item [array names ::gridplus::gpInfo *:in] {
         if {$::gridplus::gpInfo($item) eq $lastIn} {
            set in [lindex [split $item :] 0]
            set toplevelLastIn $in
            while {[set in [gpPackIn $in]] ne ""} {
               set lastIn $in
            }
         }
      }
   }

   if {[regexp -- {(.*)[.]([^.]+$)} $lastIn -> containedIn]} {
      if {$containedIn eq "" && $toplevelLastIn ne ""} {
         gpNotebookIn $toplevelLastIn
      } elseif {[winfo class $containedIn] eq "TNotebook"} {
         $containedIn select $lastIn

         set pane  [$containedIn index current]
         set panes [$containedIn tabs]

         regsub -all .[winfo name $containedIn] [lindex $panes $pane] {} item

         set gpTabOrder($containedIn:000000) $item

         gpSetTabOrder $containedIn
      }
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpFormatDate                                     #
# PURPOSE: Converts date format for validation and display.             #
#=======================================================================#

proc ::gridplus::gpFormatDate {date mode} {
   variable gpConfig

   switch -regexp -- $date {
      {^[0-9]{6}$} {
         set part(0) [string range $date 0 1]
         set part(1) [string range $date 2 3]
         set year    [string range $date 4 5]
         if {$year <= $gpConfig(date:century)} {
            set year "20$year"
         } else {
            set year "19$year"
         }
      }
      {^[0-9]{8}$} {
         set part(0) [string range $date 0 1]
         set part(1) [string range $date 2 3]
         set year    [string range $date 4 7]
      }
      {^[0-9]{2}.[0-9]{2}.[0-9]{4}$}  {
         set part(0) [string range $date 0 1]
         set part(1) [string range $date 3 4]
         set year    [string range $date 6 9]
      }
      default  {
         set part(0) 0
         set part(1) 0
         set year    0
      }
   }

   set separator $gpConfig(date:separator)

   if {[string equal $mode internal]} {
      return "$part($gpConfig(date:month)) $part($gpConfig(date:day)) $year"
   } else {
      return $part(0)$separator$part(1)$separator$year
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpCalMonthDays                                   #
# PURPOSE: Returns number of days for specified month/year.             #
#=======================================================================#

proc ::gridplus::gpCalMonthDays {month year} {
   array set days {
       1 31
       2 28
       3 31
       4 30
       5 31
       6 30
       7 31
       8 31
       9 30
      10 31
      11 30
      12 31
   }

   if {[clock format [clock add [clock scan 28/02/${year} -format "%d/%m/%Y"] 1 day] -format %d] eq "29"} {
      set days(2) 29
   }

   return $days([scan $month "%d"])
}

#=======================================================================#
# PROC   : ::gridplus::gpWindow                                         #
# PURPOSE: Create toplevel window with "modal" option.                  #
#=======================================================================#

proc ::gridplus::gpWindow {} {
   upvar 1 options options

   variable gpInfo

   set options(-windowcommand) [::gridplus::gpOptionAlias -windowcommand -wcmd]

   if {[winfo exists $options(name)] && $options(-in) eq ""} {
      if {! $gpInfo($options(name):toplevel)} {
         return 0
      }

      if {$options(-windowcommand) ne ""} {
         wm protocol $options(name) WM_DELETE_WINDOW "after 1 {$options(-windowcommand)}"
      }
      if {$options(-wtitle) ne ""} {
         wm title [winfo toplevel $options(name)] [mc $options(-wtitle)]
      }
      return 0
   }

   regsub -- {%c} $options(-windowcommand) "::gridplus::gridplus clear $options(name)"
   regsub -- {%d} $options(-windowcommand) "destroy $options(name)"

   if {$options(-in) ne ""} {
      if {[info exists gpInfo($options(-in):wcmd)]} {
         eval $gpInfo($options(-in):wcmd)
      }

      toplevel $options(name) -use $gpInfo($options(-in):container)

      set gpInfo($options(name):toplevel) 0

      ::gridplus::gpEditMenuCreate $options(name)

      if {$options(-windowcommand) ne ""} {
         set gpInfo($options(-in):wcmd) "$options(-windowcommand)"
      } else {
         set gpInfo($options(-in):wcmd) "::gridplus::gridplus clear $options(name);destroy $options(name)"
      }

      set gpInfo($options(-in):in) $options(name)

      return 1
   } else {
      set gpInfo($options(name):toplevel) 1
      toplevel $options(name)
   }

   wm attributes $options(name) -topmost $options(-topmost)

   bind $options(name) <Destroy>   "::gridplus::gpWidgetHelpCancel;::gridplus::gpValidateErrorCancel $options(name) %W"
   bind $options(name) <Configure> "::gridplus::gpValidateErrorCancel $options(name) %W"
   bind $options(name) <Unmap>     "::gridplus::gpValidateErrorCancel $options(name) %W"

   ::gridplus::gpEditMenuCreate $options(name)

   wm resizable $options(name) 0 0

   if {$options(-windowcommand) ne ""} {
      wm protocol $options(name) WM_DELETE_WINDOW "after 1 {$options(-windowcommand)}"
   } else {
      wm protocol $options(name) WM_DELETE_WINDOW "after 1 {::gridplus::gridplus clear $options(name);destroy $options(name)}"
   }

   if {$options(-wtitle) ne ""} {
      wm title [winfo toplevel $options(name)] [mc $options(-wtitle)]
   }

   if {$options(-modal)} {
      bind modalWindow <ButtonPress> {wm deiconify %W;raise %W}
      bindtags $options(name) [linsert [bindtags $options(name)] 0 modalWindow]
      wm deiconify $options(name)
      tkwait visibility $options(name)
      grab set $options(name)
   }

   return 1
}

#=======================================================================#
# PROC   : ::gridplus::gpclear                                          #
# PURPOSE: Clear selected text for item.                                #
#=======================================================================#

proc ::gridplus::gpclear {{item {}}} {

   if {$item eq ""} {
      set item [focus]
   }

   if {[string match *.text $item] && [winfo class $item] eq "Text"} {
      set textItem $item
   } else {
      set textItem $item.text
   }

   if {[winfo exists $textItem]} {
      event generate $textItem <<Clear>>
      $textItem edit modified 1
   } else {
      event generate $item <<Clear>>
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpcopy                                           #
# PURPOSE: Perform clipboard copy for item.                             #
#=======================================================================#

proc ::gridplus::gpcopy {{item {}}} {

   if {$item eq ""} {
      set item [focus]
   }

   if {[string match *.text $item] && [winfo class $item] eq "Text"} {
      set textItem $item
   } else {
      set textItem $item.text
   }

   if {[winfo exists $textItem]} {
      tk_textCopy $textItem
   } else {
      clipboard clear
      clipboard append [selection get]
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpcut                                            #
# PURPOSE: Perform clipboard cut for item.                              #
#=======================================================================#

proc ::gridplus::gpcut {{item {}}} {

   if {$item eq ""} {
      set item [focus]
   }

   if {[string match *.text $item] && [winfo class $item] eq "Text"} {
      set textItem $item
   } else {
      set textItem $item.text
   }

   if {[winfo exists $textItem]} {
      tk_textCut $textItem
      $textItem edit modified 1
   } else {
      clipboard clear
      clipboard append [selection get]
      $item delete sel.first sel.last
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpfind                                           #
# PURPOSE: Find next/previous occurance of string in GRIDPLUS Text.     #
#=======================================================================#

proc ::gridplus::gpfind {item pattern {direction forwards}} {
   global {}

   if {$direction eq "forwards"} {
      set searchIndex "insert+1char"
   } else {
      set searchIndex "insert"
   }

   set position [$item.text search -$direction -exact -nocase $pattern $searchIndex]

   if {$position ne ""} {
      catch "$item.text tag remove sel sel.first sel.last"
      $item.text tag add sel $position $position+[string length $pattern]chars
      $item.text configure -inactiveselectbackground [$item.text cget -selectbackground]
      $item.text mark set insert $position
      $item.text see $position
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpfind_dialog                                    #
# PURPOSE: Display find dialog for specified GRIDPLUS text item.        #
#=======================================================================#

proc ::gridplus::gpfind_dialog {item} {

   ::gridplus::gpTextFind $item
}

#=======================================================================#
# PROC   : ::gridplus::gpinsert                                         #
# PURPOSE: Inserts line into tablelist/text.                            #
#=======================================================================#

proc ::gridplus::gpinsert {name position line} {
   global {}

   variable gpInfo

   if {[winfo exists $name.tablelist]} {
      ::gridplus::gpTablelistInsert $name $position $line
   } elseif {[winfo exists $name.text]} {
      ::gridplus::gpTextInsert $name $position $line
   } else {
      error "GRIDPLUS ERROR: (gpinsert) Widget \"$name\" is not tablelist or text."
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpmap                                            #
# PURPOSE: Map Gridplus "variable(s)" to a list of values or array.     #
#=======================================================================#

proc ::gridplus::gpmap {map values {arg __direct}} {

   if {$arg ni "__direct __left __right"} {
      upvar #0 $arg array
   
      if {[array exists array]} {
         set position 0

         foreach item $map {
            if {[winfo exists $item] && [winfo class $item] eq "TCombobox"} {
               gpset [list $item $array([lindex $values $position])]
            } else {
               gpset $item $array([lindex $values $position])
            }
            incr position
         }
      } else {
         error "GRIDPLUS ERROR: (gpmap) Array \"$arg\" does not exist."
      }
   } else {
      switch -- $arg {
         __direct {set start 0; set increment 1}
         __left   {set start 0; set increment 2}
         __right  {set start 1; set increment 2}
         default  {set start 0; set increment 1}
      }

      set position $start

      foreach item $map {
         if {[winfo exists $item] && [winfo class $item] eq "TCombobox"} {
            gpset [list $item [lindex $values $position]]
         } else {
            gpset $item [lindex $values $position]
         }
         incr position $increment
      }
   }
}

#=======================================================================#
# PROC   : ::gridplus::gppaste                                          #
# PURPOSE: Perform clipboard paste for item.                            #
#=======================================================================#

proc ::gridplus::gppaste {{item {}}} {

   if {$item eq ""} {
      set item [focus]
   }

   if {[string match *.text $item] && [winfo class $item] eq "Text"} {
      set textItem $item
   } else {
      set textItem $item.text
   }

   if {[winfo exists $textItem]} {
      tk_textPaste $textItem
      $textItem edit modified 1
   } else {
      $item selection clear
      $item insert insert [clipboard get]
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpselect                                         #
# PURPOSE: Selects specified item in a list/tree.                       #
#=======================================================================#

proc ::gridplus::gpselect {name match {column 0}} {
   global {}

   variable gpInfo

   if {[winfo exists $name.tablelist]} {
      $name.tablelist selection clear 0 end
      if {[set row [lsearch -exact [$name.tablelist getcolumn $column] $match]] > -1} {
         $name.tablelist selection set $row
         $name.tablelist see $row
         if {$gpInfo($name:action) eq "single"} {
            ::gridplus::gpTablelistSelect $name $row $gpInfo($name:window) $gpInfo($name:validate) $gpInfo($name:command)
         } else {
            ::gridplus::gpTablelistSelect $name $row $gpInfo($name:window) $gpInfo($name:validate) {}
         }
      } else {
         error "GRIDPLUS ERROR: (gpselect) Tablelist line with match \"$match\" not found."
      }
   } elseif {[winfo exists $name.tree]} {
      if {! [catch {$name.tree selection set $match}]} {
            if {$gpInfo($name:action) eq "single"} {
               ::gridplus::gpTreeSelect $name $gpInfo($name:window) $gpInfo($name:validate) $gpInfo($name:command)
            } else {
               ::gridplus::gpTreeSelect $name $gpInfo($name:window) $gpInfo($name:validate) {}
            }
      } else {
         error "GRIDPLUS ERROR: (gpselect) Tree node \"$match\" not found."
      }
   } else {
      error "GRIDPLUS ERROR: (gpselect) Widget \"$name\" is not tablelist or tree."
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpset                                            #
# PURPOSE: Set Gridplus "variable(s)".                                  #
#=======================================================================#

proc ::gridplus::gpset {args} {
   global {}

   variable gpInfo

   switch -- [llength $args] {
      1 {
         if {[expr [llength [lindex $args 0]] % 2] != 0} {
            error "GRIDPLUS ERROR: (gpset) Unmatched item/value."
         }
         foreach {item value} [lindex $args 0] {
            if {[winfo exists $item.text]} {
               $item.text delete 1.0 end
               $item.text insert end $value
               set ($item) $value
            } else {
               set ($item) $value
            }
         }
      }
      2 {
         set item  [lindex $args 0]
         set value [lindex $args 1]
         if {[winfo exists $item.tablelist]} {
            unset -nocomplain ($item)
            $item.tablelist delete 0 end
            foreach line $value {
               ::gridplus::gpTablelistInsert $item end $line
            }
            if {$gpInfo($item:columnsort)} {
               $item.tablelist sortbycolumn $gpInfo($item:firstcolumn) -$gpInfo($item:sortorder)
            }
            if {$gpInfo($item:selectfirst)} {
               $item.tablelist selection set 0
               set ($item) [$item.tablelist get 0]
            }
         } elseif {[winfo exists $item.text]} {
            set textState [$item.text cget -state]
            $item.text configure -state normal
            if {$gpInfo($item:tags)} {
               $item.text delete 1.0 end
               ::gridplus::gpParseTags $item $value end
               $item.text tag raise sel
            } else {
               $item.text delete 1.0 end
               $item.text insert end $value
               $item.text edit modified 0
               set ($item) $value
            }
            $item.text configure -state $textState
         } elseif {[winfo exists $item.tree]} {
            ::gridplus::gpTreeSet $item $value
         } elseif {[winfo exists $item] && [winfo class $item] eq "TCombobox"} {
            $item configure -value $value
         } else {
            set ($item) $value
         }
      }
      default {
         error "GRIDPLUS ERROR: (gpset) Wrong number of Args."
      }
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpunset                                          #
# PURPOSE: Unset Gridplus "variable(s)".                                #
#=======================================================================#

proc ::gridplus::gpunset {args} {
   global {}

   foreach arg $args {
      if {[info exists ($arg)]} {
         unset ($arg)
      }
      if {[winfo exists $arg.tablelist]} {
         $arg.tablelist delete 0 end
      } elseif {[winfo exists $arg.text]} {
         $arg.text delete 1.0 end
      } elseif {[winfo exists $arg.tree]} {
         $arg.tree configure -state normal
         $arg.tree delete 1.0 end
         $arg.tree configure -state disabled
      }
   }
}

#=======================================================================#
# End of Script: gridplus.tcl                                           #
#=======================================================================#
