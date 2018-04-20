import UIKit

public class ColorButton: UIButton, UserInterface {

    public var color: UIColor
    
    public init(frame: CGRect, color: UIColor) {
        self.color = color
        super.init(frame: frame)
        self.layer.cornerRadius = self.frame.size.width / 2
        self.layer.backgroundColor = color.cgColor
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UserInterface
    public func hide() {
        UIView.animate(withDuration: 0.25) {
            self.alpha = 0
        }
    }
    
    public func appear() {
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1
        }
    }
}
