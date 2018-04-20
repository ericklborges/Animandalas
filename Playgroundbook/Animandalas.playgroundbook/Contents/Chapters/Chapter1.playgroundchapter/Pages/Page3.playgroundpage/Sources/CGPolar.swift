import UIKit

public struct CGPolar {
    
    //MARK: - Atributes
    public var radius: CGFloat
    public var angle: CGFloat
    // rectangular representation
    public var cgpoint: CGPoint {
        get {
            let x = radius * cos(angle)
            let y = radius * sin(angle)
            return CGPoint(x: x, y: y)
        }
    }
    
    //MARK: - Inits
    public init(radius: CGFloat, angle: CGFloat){
        self.radius = radius
        self.angle = angle
    }
    
    public init(from cgpoint: CGPoint){
        self.radius = cgpoint.polar().radius
        self.angle = cgpoint.polar().angle
    }
    
}
