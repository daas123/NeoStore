import UIKit
import NVActivityIndicatorView

extension UIViewController {
    
    private var activityIndicator: NVActivityIndicatorView? {
        return view.subviews.first(where: { $0 is NVActivityIndicatorView }) as? NVActivityIndicatorView
    }
    
    func startActivityIndicator() {
        if activityIndicator == nil {
            let indicatorFrame = CGRect(x: 0, y: 0, width: 50, height: 50)
            let newActivityIndicator = NVActivityIndicatorView(frame: indicatorFrame)
            newActivityIndicator.color = UIColor.white
            newActivityIndicator.layer.cornerRadius = 25
            newActivityIndicator.backgroundColor = ColorConstant.whiteTarnsperent
            newActivityIndicator.type = .circleStrokeSpin
            newActivityIndicator.padding = 5
            newActivityIndicator.center = view.center
            
            view.addSubview(newActivityIndicator)
        }
        
        activityIndicator?.startAnimating()
        view.isUserInteractionEnabled = false
    }
    
    func stopActivityIndicator() {
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
        view.isUserInteractionEnabled = true
    }
}
