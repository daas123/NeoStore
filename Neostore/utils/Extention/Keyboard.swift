//
//  Keyboard.swift
//  Neostore
//
//  Created by Neosoft on 05/09/23.
//

import Foundation
import UIKit
extension UIResponder {
    private static weak var _currentFirstResponder: UIResponder? = nil

    static var currentFirstResponder: UIResponder? {
        _currentFirstResponder = nil
        UIApplication.shared.sendAction(#selector(UIResponder.findFirstResponder(_:)), to: nil, from: nil, for: nil)
        return _currentFirstResponder
    }

    @objc private func findFirstResponder(_ sender: Any) {
        UIResponder._currentFirstResponder = self
    }
}
