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
            iconView.trailingAnchor.constraint(equalTo: iconContainerView.trailingAnchor, constant: -10),
            iconView.centerYAnchor.constraint(equalTo: iconContainerView.centerYAnchor) // Center vertically
        ])
        leftView = iconContainerView
        leftViewMode = .always
    }
    
    func setBorder() {
        self.layer.borderWidth = 1.2
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = 5.0
    }
}

