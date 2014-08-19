#---------------
# histogram.tcl
#
# place histogram into canvas
#---------------

#        TITLE
#  +----------------+
#  |           V    |
#  |         +---+  |
#  |    V    |   |  |
#  |  +---+  |   |  |
#  |  |   |  |   |  |
#  +--+---+--+---+--+
#       L      L
#        SERIES

#---------------
# courtesy of Spephane Arnould
#---------------
proc coordy {cvpath coord} {
    incr coord 0; # check integer type
    set y [$cvpath cget -height]
    return [expr {$y-$coord}]
}

#---------------
# determine canvas centre
#---------------
proc centre {cvpath} {
    set cx [$cvpath cget -width]
    return [expr {$cx /2}]
}

#---------------
# render histogram
#
# path          path of canvas widget into which the chart is rendered
# tag           assign a custom tag to all items, it may be useful later
# data          the data series to display
# width, height overall width/height of the graphing area
# x, y          offsets in the canvas, from the bottom left corner
# scalf         scale factor for y-axis
# t1, t2        top/bottom chart titles
#
#---------------
proc histogram {path tag data width height x y scalf t1 t2} {
  # determine how items in the set
  set i [expr [llength $data] / 2]
  # determine spacing between each bar
  set dw [expr $width / $i]

  # set bar width as 80% of separation +--|--+
  set bw [expr $dw * 4 / 10]
  set di [expr $x + 25]

  # draw grid
  # calculate size of table
  set s [expr $i * $dw]
  $path create rectangle \
    [expr $di - $dw] [coordy $path $y] \
    [expr $di + $width]  [coordy $path [expr $height + $y]] \
    -tags $tag

  # determine scale to fit factor
  set j 0
  foreach {a b} $data {
    if {$b > $j} {set j $b}
  }
  set j [expr {$j / $scalf}]

  # make largest item 90% of height, determine scale factor
  set sf [expr ($height * 90 /100) /$j]

  # initialize block co-ordinates
  set cx(1) 0 ; set cy(1) 0
  set cx(2) 0 ; set cy(2) 0
  foreach {a b} $data {
    # bar
    set cx(1) [expr $di - $bw]
    set cy(1) [coordy $path $y]
    set cx(2) [expr $di + $bw]
    set cy(2) [coordy $path [expr $y + ($sf * $b / $scalf)]]
    # label
    set cy(3) [coordy $path [expr $y -10]]
    # value
    set cy(4) [coordy $path [expr $y +($sf * $b / $scalf)+10]]
    # sample
    $path create text \
        $di $cy(3) \
        -text $a \
        -tags $tag
    $path create rectangle \
        $cx(1) $cy(1) \
        $cx(2) $cy(2) \
        -fill yellow \
        -outline black \
        -tags $tag
    # value
     $path create text \
         $di $cy(4) \
         -text $b  \
         -tags $tag

    incr di $dw
  }

  # add top title
  $path create text \
    [expr $x + [centre $path]] [coordy $path [expr $height + 30 ]] \
    -text $t1  \
    -tags $tag
  # add bottom title
  $path create text \
    [expr $x + [centre $path]] [coordy $path [expr $y - 30 ]] \
    -text $t2 \
    -tags $tag

}

#---------------
# demo block
#---------------

#console show
#pack [canvas .hist -width 500 -height 400 -bg white] -fill both

#set data {ch1 10 ch2 10 ch3 20 ch4 30 ch5 50 ch6 40 ch7 60 ch8 30 ch9 20 ch10 40 ch11 10 ch12 5}

#histogram .hist \
#  sarv \
#  $data \
#  500 300 \
#  50 50 \
#  {Occurance of the term 'Sarvajna'} \
#  {T224 Chapter}
