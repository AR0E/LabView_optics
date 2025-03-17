#import "../src/lib.typ": *

= Motor controls

Suppose we have $n$ points $accent(bold(x), ->) in bb(R)^m$ arranged 
as $[bold(A)]_{m n}$ and we want to _interpolate_ a curve 
$gamma : [a,b] -> bb(R)^m$ through them. We may perform any of the number
of different parametric interpolations such as _linear, polynomial, non-linear_
and the likes.

== GCODE controls

For the _machine + laser_ control, we'll need a simpler subset of linear motion,
and reinterpret certain parameters for the laser shutter. It is convenient to
deploy some methodology to smoothly modulate the shutter and other equipment as
well.

The standard list is of the following X commands:

- General configurations
    - #highlight(fill: blue.C)[G21]  = Milimeters
    - #highlight(fill: blue.C)[G28]  = Return Home
    - #highlight(fill: blue.C)[G90]  = Absolute Mode
    - #highlight(fill: blue.C)[G91]  = Relative Mode (desired for Laser applications)

- General logic
    - #highlight(fill: blue.C)[M00] = Program stop
    - #highlight(fill: blue.C)[M30] = End of program
    - #highlight(fill: blue.C)[M09] = Shutter ON


- Plane selection
    - #highlight(fill: orange.C)[G17]  = $x y$ plane
    - #highlight(fill: orange.C)[G18]  = $x z$ plane
    - #highlight(fill: orange.C)[G19]  = $y z$ plane

- Movement
    - #highlight(fill: blue.C)[G00]  #highlight(fill: red.C)[X10 Y10]  =  #highlight(fill: blue.C)[Rapid positioning] #highlight(fill: red.C)[$angle.l bold(x), bold(y) angle.r$]
    - #highlight(fill: blue.C)[G01]  #highlight(fill: red.C)[X10 Y10] #highlight(fill: green.C)[F200]  =  #highlight(fill: blue.C)[Linear Interpolation] #highlight(fill: red.C)[$angle.l bold(x), bold(y) angle.r$] #highlight(fill: green.C)[Feed Rate]
    - #highlight(fill: blue.C)[G02]  #highlight(fill: red.C)[X10 Y10] #highlight(fill: green.C)[I0 J-5]  =  #highlight(fill: blue.C)[Circular clockwise Interpolation] #highlight(fill: red.C)[$angle.l bold(x), bold(y) angle.r$] #highlight(fill: green.C)[$angle.l bold(x), bold(y) angle.r$ offset relative to end]
    - #highlight(fill: blue.C)[G02]  #highlight(fill: red.C)[X10 Y10] #highlight(fill: green.C)[I0 J-5]  =  #highlight(fill: blue.C)[Circular counterclockwise Interpolation] #highlight(fill: red.C)[$angle.l bold(x), bold(y) angle.r$] #highlight(fill: green.C)[$angle.l bold(x), bold(y) angle.r$ offset relative to end]
