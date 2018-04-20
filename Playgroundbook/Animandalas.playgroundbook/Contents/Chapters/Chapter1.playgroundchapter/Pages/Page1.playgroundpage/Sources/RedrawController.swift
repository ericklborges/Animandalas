//
//  RedrawController.swift
//  WWDCAuxiliar
//
//  Created by Erick Borges on 26/03/2018.
//  Copyright © 2018 Erick Borges. All rights reserved.
//

import UIKit

public class RedrawController: UIViewController {
    
    //MARK: - Properties
    var drawingView: DrawingView!
    var auxiliarDrawEngine: DrawEngine!
    var pointsArray = [[CGPoint]]()
    var lines = [Line]()
    var path = CGMutablePath()
    //button settings
    let buttonSize: CGFloat = 50
    let buttonsDistance: CGFloat = 10
    let margin: CGFloat = 10
    //animations delay control
    var delay: Double = 0
    
    //MARK: - Life Cycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.drawingView = DrawingView(frame: self.view.frame)
        self.drawingView.drawEngine = self.auxiliarDrawEngine
        self.drawingView.isUserInteractionEnabled = true
        self.view = self.drawingView
        self.drawLines(for: lines)
        self.setupButton()
    }
    
    //MARK: - Setup
    private func setupButton(){
        let y = self.view.frame.height - buttonSize - margin
        let x = (3*self.view.frame.width/4) - (buttonSize/2)
        let closeButton = CloseButton(frame: CGRect(x: x, y: y, width: 40, height: 40))
        closeButton.addTarget(self, action: #selector(self.selfDismiss), for: UIControlEvents.touchDown)
        self.view.addSubview(closeButton)
    }
    
    //MARK: - Drawing methods
    private func redraw(){
        self.drawLines(for: lines)
    }
    
    func drawLines(for lines: [Line]) {
        
        for line in lines {
            self.path = CGMutablePath()
            
            if line.points.count > 2 {
                
                for i in 2..<line.points.count{
                    
                    let subPath = self.drawingView.drawEngine.buildCGPaths(for: (line.points[i-2], line.points[i-1], line.points[i]))
                    self.path.addPath(subPath)
                    
                }
                
                var duration: Double = 0
                if self.drawingView.isSymmetryEnbled {
                    duration = Double(2*self.drawingView.numberOfSections*line.points.count) / 400
                } else {
                    duration = Double(self.drawingView.numberOfSections*line.points.count) / 400
                }
                
                let layer = CAShapeLayer()
                layer.strokeEnd = 0
                layer.lineWidth = line.width
                layer.strokeColor = line.color.cgColor
                layer.fillColor = UIColor.clear.cgColor
                layer.lineCap = kCALineCapRound
                layer.path = path
                
                let animation = CABasicAnimation(keyPath: "strokeEnd")
                animation.toValue = 1
                animation.duration = duration
                animation.beginTime = CACurrentMediaTime() + delay
                animation.isRemovedOnCompletion = false
                animation.fillMode = kCAFillModeForwards
                layer.add(animation, forKey: "drawLine")
                self.view.layer.addSublayer(layer)
                
                delay += duration
                
            }
        }
    }
    
    //MARK: - Navigation
    @objc
    public func selfDismiss(){
        self.dismiss(animated: true, completion: nil)
    }
}

