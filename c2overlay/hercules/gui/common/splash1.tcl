proc splashscreen { { art tclpower.gif } { delay 2500 } { artdir "" } } {
  catch { [ winfo ] } errmsg
  
  if { [ string match invalid* $errmsg ] } {
    return -code error "Splash requires Tk"
  }
  
  set logo [file join $artdir $art]
   
  if { [ file exists $logo ] } {
    frame .splash -borderwidth 4 -relief raised
    set logo [ image create photo -file $logo ]
    label .splash.logo -image $logo
    pack  .splash.logo -fill both
    place .splash -anchor c -relx .5 -rely .5
    after $delay destroy .splash
    update
  } else {
    set    msg "Splash image missing!\n"
    append msg "(file: \"$logo\" not found)"
    puts  $msg
  }
  return {}
}
