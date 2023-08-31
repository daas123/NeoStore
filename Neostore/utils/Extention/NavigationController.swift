//
//  TintRemove.swift
//  Neostore
//
//  Created by Neosoft on 30/08/23.
//

import Foundation
import UIKit
extension UINavigationController{
    open override func viewDidLoad() {
            super.viewDidLoad()
            
            // Configure the navigation bar appearance
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            navigationBarAppearance.backgroundColor = UIColor(named: "Primary Background")
            navigationBarAppearance.titleTextAttributes = [
//                NSAttributedString.Key.font: UIFont(name: Font.fontBold.rawValue, size: 26)!,
                NSAttributedString.Key.foregroundColor: UIColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
            ]
            navigationBar.standardAppearance = navigationBarAppearance
            navigationBar.scrollEdgeAppearance = navigationBarAppearance
            
            // Optionally, set other navigation bar properties
            navigationBar.tintColor = UIColor(named: "Primary Foreground")
        
        
        }
}
