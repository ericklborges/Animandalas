import UIKit
import PlaygroundSupport

let canvas = Canvas()

canvas.drawingView.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
canvas.drawingView.numberOfSections = 7
canvas.drawingView.isSymmetryEnbled = true
canvas.drawingView.lineWidth = 5
canvas.colors = [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 0.1107811555, green: 0.6159881353, blue: 0.9731459022, alpha: 1),#colorLiteral(red: 0.8675035834, green: 0.3287483454, blue: 0.3285664618, alpha: 1),#colorLiteral(red: 1, green: 0.7898763021, blue: 0, alpha: 1),#colorLiteral(red: 0, green: 0.8585883247, blue: 0, alpha: 1),#colorLiteral(red: 0.5811903212, green: 0.2674967448, blue: 1, alpha: 1)]

PlaygroundPage.current.liveView = canvas
