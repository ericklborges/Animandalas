//
//  TachingPolarView.swift
//  WWDCAuxiliar
//
//  Created by Erick Borges on 31/03/2018.
//  Copyright © 2018 Erick Borges. All rights reserved.
//

import UIKit

public class TeachingPolarView: UIView {
    
    //MARK: - Properties
    private var pathLine: CGMutablePath = CGMutablePath()
    private var pathAngle: CGMutablePath = CGMutablePath()
    public var numberOfSections: Int = 3 {
        didSet{
            for layer in self.layer.sublayers! {
                layer.removeFromSuperlayer()
            }
            self.setup()
        }
    }
    
    //MARK: - Initializers
    override public init(frame: CGRect){
        super.init(frame: frame)
        self.setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup
    private func setup(){
        self.drawLines()
        self.drawAngles()
        self.angleLabels()
        self.backgroundColor = UIColor.white
    }
    
    //MARK: - Methods
    public func drawLines() {
        if numberOfSections <= 1 { return }
        //view
        let width = self.frame.width
        let height = self.frame.height
        //lines
        let angle = (2*CGFloat.pi) / CGFloat(numberOfSections)
        //        let center = self.center.polar()
        let center = CGPoint(x: self.center.x/2, y: self.center.y).polar()
        var point = CGPolar(radius: 0, angle: 0)
        if width > height {
            point.radius = width*sqrt(2)
        } else {
            point.radius = height*sqrt(2)
        }
        
        for i in 0..<numberOfSections{
            self.pathLine = CGMutablePath()
            
            let subPath = CGMutablePath()
            subPath.move(to: center.cgpoint)
            point.angle = -(angle * CGFloat(i))
            subPath.addLine(to: point.cgpoint + center.cgpoint)
            self.pathLine.addPath(subPath)
            
            let layer = CAShapeLayer()
            layer.path = pathLine
            layer.strokeEnd = 0
            layer.fillColor = UIColor.clear.cgColor
            layer.lineWidth = 2
            layer.strokeColor = UIColor.black.cgColor
            
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.toValue = 1
            animation.duration = 0.25
            animation.beginTime = CACurrentMediaTime() + 0.5*Double(i)
            animation.isRemovedOnCompletion = false
            animation.fillMode = kCAFillModeForwards
            layer.add(animation, forKey: "drawLine")
            
            self.layer.addSublayer(layer)
        }
        
    }
    
    public func drawAngles(){
        if numberOfSections < 1 { return }
        let angle = (2*CGFloat.pi) / CGFloat(numberOfSections)
        //view
        let width = self.frame.width
        let height = self.frame.height
        //lines
        let center = CGPoint(x: self.center.x/2, y: self.center.y).polar()
        
        for i in 0..<numberOfSections{
            self.pathAngle = CGMutablePath()
            
            let subPath = CGMutablePath()
            subPath.addRelativeArc(center: center.cgpoint, radius: 40 + 5*CGFloat(i), startAngle: -angle*CGFloat(i), delta: -angle)
            self.pathAngle.addPath(subPath)
            
            let layer = CAShapeLayer()
            layer.path = pathAngle
            layer.strokeEnd = 0
            layer.fillColor = UIColor.clear.cgColor
            layer.lineWidth = 2
            layer.strokeColor = UIColor.red.cgColor
            
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.toValue = 1
            animation.duration = 0.25
            animation.beginTime = CACurrentMediaTime() + 0.25 + 0.5*Double(i)
            animation.isRemovedOnCompletion = false
            animation.fillMode = kCAFillModeForwards
            layer.add(animation, forKey: "drawLine")
            
            self.layer.addSublayer(layer)
        }
    }
    
    public func angleLabels(){
        if numberOfSections < 1 { return }
        let angle = (2*CGFloat.pi) / CGFloat(numberOfSections)
        
        let center = CGPoint(x: self.center.x/2, y: self.center.y).polar()
        
        for i in 0..<numberOfSections{
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 70, height: 30))
            let labelPosition = CGPolar(radius: 70 + 5*CGFloat(i), angle: -angle*(CGFloat(i) + 0.66)).cgpoint
            label.frame.origin = CGPoint(x: labelPosition.x + center.cgpoint.x,
                                         y: labelPosition.y + center.cgpoint.y)
            
            label.text = "\(rand2deg(angle))º"
            label.alpha = 0
            UIView.animate(withDuration: 0, delay: 0.25 + 0.5*Double(i), options: UIViewAnimationOptions.allowAnimatedContent , animations: {
                label.alpha = 1
            }, completion: nil)
            
            self.addSubview(label)
        }
    }
    
    private func rand2deg(_ angle: CGFloat) -> CGFloat{
        return (angle*180)/CGFloat.pi
    }
    
}
