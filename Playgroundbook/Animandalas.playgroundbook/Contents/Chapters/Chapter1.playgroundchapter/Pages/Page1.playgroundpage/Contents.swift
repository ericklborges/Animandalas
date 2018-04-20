/*:
 # Lines
 
 Hello! Before anything else, I'd like to recommed that you use this playground on an iPad in landscape orientation.
 
 My name is Erick, and I am an engineering student, passionate by arts and maths. When I first thought about applying to WWDC Scholarship, I've challenged myself to develop a playground which theme would involve complex engineering level mathemathics, and some way of self expression and relaxing through arts.
 
 The result of it was this kind of drawing tool, that allows you to draw stunning abstract art like this:
 
 ![DetailsExample_01](DetailsExample_01.png)
 
 These smaller lines that I call "details", are generated between the line points. Their distance depends on the line drawing speed, length, and curves. Give it a try! 👩‍🎨
 
 First, choose your **colors** 🎨
 
 You can change any color and also remove, or add extra colors. Do it changing the `canvas.colors` attribute.
 
 If you wish, you can change the **background color** by setting `drawingView.backgroundColor`
 
 Then choose the **line width** 🖌
 
 You can do that changing the value of `drawingView.lineWidth` atribute.
 
 And finally, start drawing! Remeber to draw long lines, and vary the speed of drawing.
 */
//#-hidden-code
import UIKit
import PlaygroundSupport

let canvas = Canvas()
let drawingView = canvas.drawingView!
//#-end-hidden-code
canvas.colors = /*#-editable-code */[#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 0.1107811555, green: 0.6159881353, blue: 0.9731459022, alpha: 1),#colorLiteral(red: 0.8675035834, green: 0.3287483454, blue: 0.3285664618, alpha: 1),#colorLiteral(red: 1, green: 0.7898763021, blue: 0, alpha: 1),#colorLiteral(red: 0, green: 0.8585883247, blue: 0, alpha: 1),#colorLiteral(red: 0.5811903212, green: 0.2674967448, blue: 1, alpha: 1)]/*#-end-editable-code*/

drawingView.backgroundColor = /*#-editable-code */#colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)/*#-end-editable-code*/

drawingView.lineWidth = /*#-editable-code */5/*#-end-editable-code*/
//#-hidden-code
PlaygroundPage.current.liveView = canvas
//#-end-hidden-code
/*:
 Although It creates stunning drawings, my inner engineer wasn't satisfied. I did't feel like I could see where mathematics was contributing for these drawings. So I decided to go further, and make a whole coordinates system visible! **Polar coordinates**. 🤓
 */
