//
//  Alert.swift
//  Neostore
//
//  Created by Neosoft on 24/08/23.
//
//
//import Foundation
//import UIKit
//class AlertError{
//    func showAlert(msg:String) {
//        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
//        if msg == "Registered Successfull"{
//
//            let action = UIAlertAction(title: "OK", style: .default) { (action) in
//                let nextViewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
//                self.navigationController?.pushViewController(nextViewController, animated: true)
//                self.dismiss(animated: true, completion: nil)
//            }
//
//            alert.addAction(action)
//
//        } else {
//
//            let action = UIAlertAction(title: "OK", style: .default) { (action) in
//                self.dismiss(animated: true, completion: nil)
//            }
//
//            alert.addAction(action)
//        }
//
//        self.present(alert, animated: true, completion: nil)
//    }
//}
//
