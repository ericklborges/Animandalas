import UIKit

public extension CGPoint {
    
    func polar() -> CGPolar {
        let radius = sqrt(pow(self.x, 2) + pow(self.y, 2))
        var angle = atan(y/x)
        
        if x < 0 {
            angle += CGFloat.pi
        }
        
        return CGPolar(radius: radius, angle: angle)
    }
    
}

public func +(left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

public func +=(left: inout CGPoint, right: CGPoint) {
    left = left + right
}

public func -(left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

public func -=(left: inout CGPoint, right: CGPoint) {
    left = left - right
}
