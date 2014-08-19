proc splashscreen {imgfile {delay 0}} \
{
  wm withdraw .
  toplevel .splash
  wm overrideredirect .splash 1
  canvas .splash.c -highlightt 0 -border 0
  if {[catch {image create photo splash -file $imgfile}]} \
  { error "image $imgfile not found" }
  .splash.c create image 0 0 -anchor nw -image splash
  foreach {- - width height} [.splash.c bbox all] break
  .splash.c config -width $width -height $height
  set wscreen [winfo screenwidth .splash]
  set hscreen [winfo screenheight .splash]
  set x [expr {($wscreen - $width) / 2}]
  set y [expr {($hscreen - $height) / 2}]
  wm geometry .splash +$x+$y
  pack .splash.c
  raise .splash
  update
  if {$delay > 0} \
  { after $delay { destroy .splash; wm deiconify . } }
}

