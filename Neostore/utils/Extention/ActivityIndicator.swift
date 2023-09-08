import UIKit
import NVActivityIndicatorView

extension UIViewController {
    
    func startActivityIndicator() {
        // Define the frame for the activity indicator (adjust as needed)
        let indicatorFrame = CGRect(x: 0, y: 0, width: 50, height: 50)
        
        // Choose a color for the activity indicator
        let indicatorColor = UIColor.white
        
        // Set padding for the activity indicator (adjust as needed)
        let indicatorPadding: CGFloat = 10.0
        
        
        
        let indicator = NVActivityIndicatorView(
            frame: indicatorFrame,
            type: .circleStrokeSpin,
            color: indicatorColor,
            padding: indicatorPadding)
        
        // Center the activity indicator in the view
        indicator.center = view.center
        indicator.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3096592379)
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
        // Find the activity indicator in the view hierarchy
        if let indicator = UIApplication.shared.keyWindow?.subviews.first(where: { $0 is NVActivityIndicatorView }) as? NVActivityIndicatorView {
            indicator.stopAnimating()
            indicator.removeFromSuperview()
        }
    }
    
}




