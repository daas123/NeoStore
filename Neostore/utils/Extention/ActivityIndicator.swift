import UIKit
import NVActivityIndicatorView

extension UIViewController {
    
    func startActivityIndicator() {
        let indicatorFrame = CGRect(x: 0, y: 0, width: 50, height: 50)
        let indicatorColor = UIColor.white
        let indicatorPadding: CGFloat = 10.0
        
        let indicator = NVActivityIndicatorView(
            frame: indicatorFrame,
            type: .circleStrokeSpin,
            color: indicatorColor,
            padding: indicatorPadding)
        indicator.center = view.center
        indicator.backgroundColor = ColorConstant.whiteTarnsperent
        indicator.layer.cornerRadius = 8.0
        let window = UIApplication.shared.keyWindow
        if let window = UIApplication.shared.keyWindow {
            indicator.center = window.center
            window.addSubview(indicator)
            indicator.startAnimating()
        }
        indicator.startAnimating()
    }
    func stopActivityIndicator() {
        if let indicator = UIApplication.shared.keyWindow?.subviews.first(where: { $0 is NVActivityIndicatorView }) as? NVActivityIndicatorView {
            indicator.stopAnimating()
            indicator.removeFromSuperview()
        }
    }
    
}




