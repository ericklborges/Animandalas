import UIKit

public class CloseButton: UIButton, UserInterface {
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setImage(UIImage(named: "Close") ,for: .normal)
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
