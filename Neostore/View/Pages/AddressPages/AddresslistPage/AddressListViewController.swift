//
//  AddressListViewController.swift
//  Neostore
//
//  Created by Neosoft on 02/09/23.
//

import UIKit

class AddressListViewController: UIViewController {
    var selectedIndexPath: IndexPath?
    var viewModel = AddAddressViewModel()
    @IBOutlet weak var addressListTableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        addressListTableview.delegate = self
        addressListTableview.dataSource = self
        
        addressListTableview.register(UINib(nibName: "FirstViewCell", bundle: nil), forCellReuseIdentifier: "FirstViewCell")
        addressListTableview.register(UINib(nibName: "AddressListCell", bundle: nil), forCellReuseIdentifier: "AddressListCell")
        addressListTableview.register(UINib(nibName: "PlaceOrderCell", bundle: nil), forCellReuseIdentifier: "PlaceOrderCell")
        
        
        // nvigation
        navigationController?.isNavigationBarHidden = false
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
        
        // addding search bitton on screen
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addAddressbutton))
        navigationItem.rightBarButtonItem = searchButton
        self.navigationItem.title = "Select Address"
    }
    @objc func addAddressbutton() {
        navigationController?.pushViewController(AddAddressController(nibName: "AddAddressController", bundle: nil), animated: true)
    }
    func dataCollection(index: Int) -> String{
        let viewmodeldata = viewModel.addressData[index]
        let additionOfData = "\(viewmodeldata.address),\(viewmodeldata.landmark),\(viewmodeldata.city), \(viewmodeldata.state), \(viewmodeldata.zipCode) , \(viewmodeldata.country)"
        return additionOfData
    }
    
    @IBAction func orderButtonAction(_ sender: UIButton) {
        let selecteddata = dataCollection(index: selectedIndexPath?.row ?? 0)
        viewModel.OrderCart(address: selecteddata){
            responce in
            DispatchQueue.main.async {
                if responce{
                    self.navigationController?.pushViewController(HomeViewController(nibName: "HomeViewController", bundle: nil), animated: true)
                    self.showAlert(msg: "Order done Succesfully")
                }else{
                    self.showAlert(msg: "something went Wrong")
                }
            }
                
    }

        
    }
    
}
extension AddressListViewController : UITableViewDelegate ,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.addressData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirstViewCell", for: indexPath) as! FirstViewCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddressListCell", for: indexPath) as! AddressListCell
            cell.addressLabel.text = "Address \(indexPath.row)"
            cell.addressLabelDetails.text = dataCollection(index: indexPath.row)
            cell.setSelected(indexPath == selectedIndexPath)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath != selectedIndexPath {
            selectedIndexPath = indexPath
            tableView.reloadData()
        }
    }

    
    // for deleting
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete
        {
            var addresses = viewModel.addressData
            addresses.remove(at: indexPath.row)
            viewModel.addressData = addresses
            tableView.reloadData()
        } else {
            print("no data")
        }
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    
}
