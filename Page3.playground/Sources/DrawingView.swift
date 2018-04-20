//MARK: - Line
public struct Line {
    var points: [CGPoint]
    var color: UIColor
    var width:CGFloat
}

//MARK: - DrawingDelegate
public protocol DrawingDelegate {
    func drawingBegan()
    func drawingEnded()
}

import UIKit

//MARK: - DrawingView
public class DrawingView: UIImageView {
    
    //MARK: Properties
    
    // delegate
    public var delegate: DrawingDelegate?
    // points
    private var currentPoint = CGPoint.zero
    private var lastPoint = CGPoint.zero
    private var previousLastPoint = CGPoint.zero
    public var lines = [Line]()
    // versions
    private var imageArray = [UIImage]()
    // draw engine
    public var drawEngine: DrawEngine!
    public var numberOfSections: Int = 4 {
        didSet{
            drawEngine.numberOfSections = numberOfSections
        }
    }
    public var isSymmetryEnbled: Bool = true {
        didSet{
            drawEngine.isSymmetryEnbled = isSymmetryEnbled
        }
    }
    public var isDetailEnabled: Bool = false {
        didSet{
            drawEngine.isDetailEnabled = isDetailEnabled
        }
    }
    // main line style
    public var lineColor = UIColor.black {
        didSet{
            drawEngine.lineColor = lineColor
        }
    }
    public var lineWidth: CGFloat = 5.0 {
        didSet{
            drawEngine.lineWidth = lineWidth
        }
    }
    public var lineOpacity: CGFloat = 1.0 {
        didSet{
            drawEngine.lineOpacity = lineOpacity
        }
    }
    
    //MARK: - Setup
    private func setup(){
        self.drawEngine = DrawEngine(of: self)
        print("DrawingView setup frame: \(self.frame)")
        self.isUserInteractionEnabled = true
        self.backgroundColor = UIColor.white
    }
    
    //MARK: - Initializers
    override public init(frame: CGRect){
        super.init(frame: frame)
        print("DrawingView init frame: \(frame)")
        self.setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.drawEngine = DrawEngine(of: self)
        
    }
    
    //MARK: - Touches
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //delegate
        self.delegate?.drawingBegan()
        if let touch = touches.first {
            self.setTouchPoints(touch, view: self)
        }
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            self.updateTouchPoints(touch, view: self)
            self.drawEngine.drawLines(for: (previousLastPoint, lastPoint, currentPoint))
        }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //delegate
        self.delegate?.drawingEnded()
        guard let image = self.image else { return }
        self.imageArray.append(image)
    }
    
    // Versioning
    public func undo(){
        if imageArray.count <= 1 {
            self.clear()
        } else {
            self.image = imageArray[imageArray.count - 2]
            imageArray.remove(at: imageArray.count - 1)
            self.lines.remove(at: lines.count - 1)
        }
    }
    
    public func clear(){
        self.image = nil
        self.imageArray = []
        self.lines = []
    }
    
    //MARK: - Private Auxiliary Methods
    private func setTouchPoints(_ touch: UITouch,view: UIView) {
        // reset points array when new line starts
        // get first points of interest
        previousLastPoint = touch.previousLocation(in: view)
        lastPoint = touch.previousLocation(in: view)
        currentPoint = touch.location(in: view)
        
        //start newLine
        self.lines.append(Line(points: [currentPoint],
                               color: self.lineColor,
                               width: self.lineWidth))
    }
    
    private func updateTouchPoints(_ touch: UITouch,view: UIView) {
        // update points of interest
        previousLastPoint = lastPoint
        lastPoint = touch.previousLocation(in: view)
        currentPoint = touch.location(in: view)
        
        // updateLine
        self.lines[self.lines.count - 1].points.append(currentPoint)
    }
    
}
