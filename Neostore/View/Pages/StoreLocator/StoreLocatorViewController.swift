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
