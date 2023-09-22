//
//  TextFieldImage.swift
//  Neostore
//
//  Created by Neosoft on 22/09/23.
//

import Foundation
import UIKit

extension UITextField {
    
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame:
                                    CGRect(x: 10, y: 5, width: 25, height: 25))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame:
                                                CGRect(x: 10, y: 0, width: 25, height: 25))
        iconContainerView.addSubview(iconView)
        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: iconContainerView.leadingAnchor),
            iconView.trailingAnchor.constraint(equalTo: iconContainerView.trailingAnchor,constant: -10),
            iconView.topAnchor.constraint(equalTo: iconContainerView.topAnchor),
            iconView.bottomAnchor.constraint(equalTo: iconContainerView.bottomAnchor)
        ])
        leftView = iconContainerView
        leftViewMode = .always
    }
    
    func setBorder(){
        self.layer.borderWidth = 1.2
        self.layer.borderColor = ColorConstant.white.cgColor
        self.layer.cornerRadius = 5.0
    }
    
}
