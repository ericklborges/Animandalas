import UIKit

public class DrawEngine {
    
    //MARK: - Properties
    
    // main line style
    public var lineColor = UIColor.black
    public var lineWidth: CGFloat = 5.0
    public var lineOpacity: CGFloat = 1.0
    // imageView
    public var imageView: DrawingView
    // context
    private var context: CGContext?
    
    // symmetry
    public var numberOfSections: Int = 1
    public var isSymmetryEnbled: Bool = false
    public var isDetailEnabled: Bool = false
    
    public init(of imageView: DrawingView){
        self.imageView = imageView
        self.setup()
    }
    
    //MARK: - Setup
    private func setup(){
        self.lineColor = imageView.lineColor
        self.lineWidth = imageView.lineWidth
        self.lineOpacity = imageView.lineOpacity
        self.numberOfSections = imageView.numberOfSections
        self.isSymmetryEnbled = imageView.isSymmetryEnbled
        self.isDetailEnabled = imageView.isDetailEnabled
    }
    
    //MARK: - Draw methods
    public func drawLines(for coordinates: (CGPoint,CGPoint,CGPoint)) {
        let pathsArray = buildPaths(for: coordinates, numberOfSections: numberOfSections)
        if isDetailEnabled{
            drawDetails(for: pathsArray)
        }
        
        UIGraphicsBeginImageContextWithOptions(imageView.frame.size, false, 0)
        imageView.image?.draw(in: imageView.frame)
        context = UIGraphicsGetCurrentContext()
        
        for line in pathsArray {
            let mid1 = calculateMidPoint(line.0, line.1)
            let mid2 = calculateMidPoint(line.1, line.2)
            context?.move(to: mid1)
            context?.addQuadCurve(to: mid2, control: line.1)
        }
        
        context?.setBlendMode(CGBlendMode.normal)
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(lineWidth)
        context?.setStrokeColor(lineColor.cgColor)
        
        context?.strokePath()
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    public func buildCGPaths(for coordinates: (CGPoint,CGPoint,CGPoint)) -> CGMutablePath{
        let pathsArray = buildPaths(for: coordinates, numberOfSections: numberOfSections)
        let cgPath = CGMutablePath()
        
        for line in pathsArray {
            let mid1 = calculateMidPoint(line.0, line.1)
            let mid2 = calculateMidPoint(line.1, line.2)
            cgPath.move(to: mid1)
            cgPath.addQuadCurve(to: mid2, control: line.1)
        }
        
        return cgPath
    }
    
    //FIXME: - context properties
    private func drawDetails(for coordinatesArray: [(CGPoint,CGPoint,CGPoint)]){
        
        UIGraphicsBeginImageContextWithOptions(imageView.frame.size, false, 0)
        imageView.image?.draw(in: imageView.frame)
        context = UIGraphicsGetCurrentContext()
        
        guard var currentPointsArray = imageView.lines.last?.points else { return }
        
        //code
        if currentPointsArray.count > 30{
            for line in coordinatesArray{
//                let rand = randomInt(min: 5, max: 30)
                context?.move(to: line.2)
                context?.addLine(to: currentPointsArray[currentPointsArray.count - 20])
            }
        }
        
        context?.setBlendMode(CGBlendMode.normal)
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(lineWidth/5)
        context?.setStrokeColor(lineColor.cgColor)
        
        context?.strokePath()
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    //MARK: - Build Methods
    private func buildPaths(for coordinates: (CGPoint,CGPoint,CGPoint),
                            numberOfSections n: Int) -> [(CGPoint,CGPoint,CGPoint)] {
        // given points
        let previousLastPoint = coordinates.0
        let lastPoint = coordinates.1
        let currentPoint = coordinates.2
        var coordinatesArray = [(CGPoint,CGPoint,CGPoint)]()
        // polar given points, center referenced
        var previousLastPolar = (previousLastPoint - imageView.center).polar()
        var lastPolar = (lastPoint - imageView.center).polar()
        var currentPolar = (currentPoint - imageView.center).polar()
        // angle based on number of sections
        let angle = (2*CGFloat.pi) / CGFloat(n)
        
        coordinatesArray.append((previousLastPolar.cgpoint + imageView.center,
                                 lastPolar.cgpoint + imageView.center,
                                 currentPolar.cgpoint + imageView.center))
        
        // main lines
        for _ in 0..<n {
            currentPolar.angle += angle
            lastPolar.angle += angle
            previousLastPolar.angle += angle
            coordinatesArray.append((previousLastPolar.cgpoint + imageView.center,
                                     lastPolar.cgpoint + imageView.center,
                                     currentPolar.cgpoint + imageView.center))
        }
        
        // mirror lines
        if isSymmetryEnbled {
            currentPolar.angle = angle + (angle - currentPolar.angle)
            lastPolar.angle = angle + (angle - lastPolar.angle)
            previousLastPolar.angle = angle + (angle - previousLastPolar.angle)
            for _ in 0...n {
                currentPolar.angle += angle
                lastPolar.angle += angle
                previousLastPolar.angle += angle
                coordinatesArray.append((previousLastPolar.cgpoint + imageView.center,
                                         lastPolar.cgpoint + imageView.center,
                                         currentPolar.cgpoint + imageView.center))
            }
        }
        
        return coordinatesArray
    }
    
    
    
    //MARK: - Private Auxiliary Methods
    
    // return a random int in given range
    private func randomInt(min: Int, max:Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    
    // return mid point between two CGPoints
    private func calculateMidPoint(_ p1 : CGPoint, _ p2 : CGPoint) -> CGPoint {
        return CGPoint(x: (p1.x + p2.x) * 0.5, y: (p1.y + p2.y) * 0.5);
    }
    
}
