##########
# busy:
#   Show a busy (watch) cursor while running the command!

proc busy {topl cmds} {
  global errorInfo

  foreach w [winfo children $topl] {
    lappend busy [list $w [lindex [$w config -cursor] 4]]
  }

  foreach w $busy { 
    catch {[lindex $w 0] config -cursor watch} 
  }

  update idletasks
  set error [catch {uplevel eval [list $cmds]} result]
  set ei $errorInfo

  foreach w $busy { 
    catch {[lindex $w 0] config -cursor [lindex $w 1]} 
  }

  if {$error} {
    ErrorMesg [concat $result $ei]
  } else {
    return $result
  }
}
