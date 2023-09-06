//
//  StoreLocatorViewController.swift
//  Neostore
//
//  Created by Neosoft on 02/09/23.
//

import UIKit

class StoreLocatorViewController: UIViewController {

    @IBOutlet weak var storeLocatorTableview: UITableView!
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
        title = "Navigate Store"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        storeLocatorTableview.delegate = self
        storeLocatorTableview.dataSource = self
        
        
        storeLocatorTableview.register(UINib(nibName: "AddressCell", bundle: nil), forCellReuseIdentifier: "AddressCell")

    }
}

extension StoreLocatorViewController : UITableViewDelegate ,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressCell", for: indexPath) as! AddressCell
        return cell
    }
    
    
}
