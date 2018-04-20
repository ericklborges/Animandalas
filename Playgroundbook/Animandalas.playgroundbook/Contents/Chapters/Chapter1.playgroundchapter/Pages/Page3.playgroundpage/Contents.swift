/*:
 # Mandalas
 
 Now that you know Polar coordinates, you know exactly what is happening here!
 
 Besides replicating the lines equidistantly, I add a symmetry feature that makes a mirror line for each section, making even more stunnig drawings.
 
 Now you can draw mandalas like this:
 
 ![Mandala](Mandala.png)
 
 Come on, give it a try!
 
 You already know how it works.
 
 `drawingView.backgroundColor` to change background color.
 
 `canvas.colors` to add, remove or change colors.
 
 `drawingView.lineWidth` to change line width.
 
 `drawingView.numberOfSections` to change the number of lines.
 
 `drawingView.isSymmetryEnbled` activate/deactivate mirroring.
 
 I have also prepared a surprise for you! After you finish drawing your mandala, hit the play button!
 */
//#-hidden-code
import UIKit
import PlaygroundSupport

let canvas = Canvas()
let drawingView = canvas.drawingView!
//#-end-hidden-code

drawingView.backgroundColor = /*#-editable-code */#colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)/*#-end-editable-code*/

canvas.colors = /*#-editable-code */[#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 0.1107811555, green: 0.6159881353, blue: 0.9731459022, alpha: 1),#colorLiteral(red: 0.8675035834, green: 0.3287483454, blue: 0.3285664618, alpha: 1),#colorLiteral(red: 1, green: 0.7898763021, blue: 0, alpha: 1),#colorLiteral(red: 0, green: 0.8585883247, blue: 0, alpha: 1),#colorLiteral(red: 0.5811903212, green: 0.2674967448, blue: 1, alpha: 1)]/*#-end-editable-code*/

drawingView.lineWidth = /*#-editable-code */5/*#-end-editable-code*/

drawingView.numberOfSections = /*#-editable-code */5/*#-end-editable-code*/

drawingView.isSymmetryEnbled = /*#-editable-code */true/*#-end-editable-code*/

//#-hidden-code
PlaygroundPage.current.liveView = canvas
//#-end-hidden-code
