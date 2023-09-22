//
//  Alert.swift
//  Neostore
//
//  Created by Neosoft on 24/08/23.
//
//
import Foundation
import UIKit

extension UIViewController{
    func showAlert(msg : String){
        let alert = UIAlertController(title: nil, message: msg , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: alertMsgConstant.ok, style: .cancel))
        present(alert, animated: true)
    }
}

