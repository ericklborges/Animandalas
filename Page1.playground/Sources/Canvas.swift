//
//  CanvasView.swift
//  WWDCAuxiliar
//
//  Created by Erick Borges on 25/03/2018.
//  Copyright © 2018 Erick Borges. All rights reserved.
//

public protocol UserInterface{
    func hide()
    func appear()
}

import UIKit

public class Canvas: UIViewController, DrawingDelegate {
    
    public var drawingView: DrawingView!
    private var redrawController: RedrawController!
    public var colors = [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 0.1107811555, green: 0.6159881353, blue: 0.9731459022, alpha: 1),#colorLiteral(red: 0.8675035834, green: 0.3287483454, blue: 0.3285664618, alpha: 1),#colorLiteral(red: 1, green: 0.7898763021, blue: 0, alpha: 1),#colorLiteral(red: 0, green: 0.8585883247, blue: 0, alpha: 1),#colorLiteral(red: 0.5811903212, green: 0.2674967448, blue: 1, alpha: 1)] {
        didSet{ self.setupColorButtons() }
    }
    private let buttonSize: CGFloat = 50
    private let buttonsDistance: CGFloat = 10
    private let margin: CGFloat = 10
    
    //MARK: - Life Cycle
    public override func viewDidLoad() {
        self.setup()
    }
    
    public override func viewDidLayoutSubviews() {
        // remove buttons from superview
        for view in self.view.subviews {
            if view is UserInterface {
                view.removeFromSuperview()
            }
        }
        // setup buttons again
        self.setupColorButtons()
        self.setupActionButtons()
    }
    
    //MARK: - Initializers
    public init(){
        super.init(nibName: nil, bundle: nil)
        self.setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Setup
    private func setup(){
        self.setupDrawingView()
        self.setupRedrawController()
        self.setupColorButtons()
        self.setupActionButtons()
    }
    
    private func setupDrawingView(){
        self.drawingView = DrawingView(frame: self.view.frame)
        self.drawingView.delegate = self
        self.view = self.drawingView
    }
    
    private func setupRedrawController(){
        self.redrawController = RedrawController()
    }
    
    private func setupColorButtons(){
        let x: CGFloat = self.view.frame.width - buttonSize
        var y = (self.view.frame.height/2) - (buttonSize/2) - buttonsDistance
        y -= (buttonSize + buttonsDistance) * CGFloat(colors.count/2)
        
        for i in 0..<colors.count {
            let button = ColorButton(frame: CGRect(x: x, y: y, width: 40, height: 40), color: colors[i])
            button.addTarget(self, action: #selector(self.changeColor), for: UIControlEvents.touchDown)
            y += 50
            
            self.view.addSubview(button)
        }
        
    }
    
    public func setupActionButtons(){
        let width = self.view.frame.width
        let height = self.view.frame.height
        
        let y = self.view.frame.height - buttonSize - margin
        var x: CGFloat = (self.view.frame.width/4) - (buttonSize/2) - buttonsDistance
        if height > width {
            x = (self.view.frame.width/6) - margin
        }
        
        let clearButton = ClearButton(frame: CGRect(x: x, y: y, width: 40, height: 40))
        clearButton.addTarget(self, action: #selector(self.clear), for: UIControlEvents.touchDown)
        self.view.addSubview(clearButton)
        x += buttonSize + buttonsDistance
        
        let undoButton = UndoButton(frame: CGRect(x: x, y: y, width: 40, height: 40))
        undoButton.addTarget(self, action: #selector(self.undo), for: UIControlEvents.touchDown)
        self.view.addSubview(undoButton)
        x = (3*self.view.frame.width/4) - (buttonSize/2)
        
//        let playButton = PlayButton(frame: CGRect(x: x, y: y, width: 40, height: 40))
//        playButton.addTarget(self, action: #selector(self.presentRedrawController), for: UIControlEvents.touchDown)
//        self.view.addSubview(playButton)
        
    }
    
    //MARK: - Button Actions
    @objc
    private func changeColor(sender: ColorButton){
        self.drawingView.lineColor = sender.color
    }
    
    @objc
    private func clear(){
        self.drawingView.clear()
    }
    
    @objc
    private func undo(){
        self.drawingView.undo()
    }
    
    //MARK: - DrawingDelegate
    public func drawingBegan() {
        for view in self.view.subviews {
            if let userInterface = view as? UserInterface {
                userInterface.hide()
            }
        }
    }
    
    public func drawingEnded() {
        for view in self.view.subviews {
            if let userInterface = view as? UserInterface {
                userInterface.appear()
            }
        }
    }
    
    //MARK: - Navigation
    @objc
    private func presentRedrawController(){
        self.setupRedrawController()
        self.redrawController.lines = drawingView.lines
        self.redrawController.auxiliarDrawEngine = drawingView.drawEngine
        self.present(self.redrawController, animated: true, completion: nil)
    }
    
}


