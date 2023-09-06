//
//  MyAccountViewController.swift
//  Neostore
//
//  Created by Neosoft on 02/09/23.
//

import UIKit

class MyAccountViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        // for activating navigation bar
        
        // for removing back button title
        let backButton = UIBarButtonItem()
        backButton.title = "" // Set an empty title
        navigationItem.backBarButtonItem = backButton
        
        // navigation bar back image
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "chevron.left")
        
        // navigation bar back text
        navigationController?.navigationBar.backItem?.title = ""
        
        // navigation bar items color
        navigationController?.navigationBar.tintColor = UIColor.white
        
        
        // setting title for navigation bar
        title = "AccountDetails"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        // Do any additional setup after loading the view.
    }



}
