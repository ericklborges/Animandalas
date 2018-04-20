/*:
 # Polar Coordinates
 
 The cartesian coordinate system is the most commom graphic representation system used. All the main frameworks of apple use it.
 
 It's fundamentals are very simple to understand. A Pair of cartesian coordinates store two values. A value for de X axis, and a value for de y axis. Commonly represented this way: (x,y) or (5,5) for instance. And can be graphically represented this way:
 
 This image shows the translation of 5 units along the X axis, and 5 units along the Y axis.
 ![CartesianCoordinates](CartesianCoordinates.png)
 
 Differently from cartesian coordinates, the polar coordinates stores a value for a radius, and a value for an angle. The radius represents the distance from the center, and the angle is the ration counter-clockwise.
 
 Polar and Cartesian coordinates are compatible, and can be represented in both systems. The conversion from cartesian to polar coordinates is a simple pythagorean theorem rule. For instance I am going to convert this point (5,5) to polar:
 
 radius = sqrt(xˆ2 + yˆ2) = 5
 
 angle = atan(y/x) = 45º
 
 It allows me to get the exactly oposite point just by adding 180º to this coordinate. Or four equidistant points by adding 90º three times, like in this image:
 ![PolarCoordinates](PolarCoordinates.png)
 
 That is exactly the MathMagic done to make my mandalas work. You can set the number of sections, or lines you want to draw simultaneously, and the playground makes the maths to know the right angle to sum, and make the lines equidistant.
 
 You can see how this works by changing `polarView.numberOfSections` bellow.
 */
//#-hidden-code
import UIKit
import PlaygroundSupport

let polar = UIViewController()
var polarView = TeachingPolarView(frame: polar.view.frame)
polar.view = polarView
//#-end-hidden-code

polarView.numberOfSections = /*#-editable-code */2/*#-end-editable-code*/

//#-hidden-code
PlaygroundPage.current.liveView = polar
//#-end-hidden-code
