//
//  AddressListViewController.swift
//  Neostore
//
//  Created by Neosoft on 02/09/23.
//

import UIKit

class AddressListViewController: UIViewController {
    var selectedIndexPath: IndexPath?
    @IBOutlet weak var orderButton: UIButton!
    var viewModel = AddAddressViewModel()
    @IBOutlet weak var addressListTableview: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        addressListTableview.reloadData()
        if viewModel.addressData.count >= 0 {
            let attributedString = NSMutableAttributedString(string: "ORDER")
            let range = NSRange(location: 0, length: 5)
            attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 24), range: range)
            orderButton.setAttributedTitle(attributedString, for: .normal)
        }
        
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        addressListTableview.separatorStyle = .none

        addressListTableview.delegate = self
        addressListTableview.dataSource = self
        
        addressListTableview.register(UINib(nibName: "FirstViewCell", bundle: nil), forCellReuseIdentifier: "FirstViewCell")
        addressListTableview.register(UINib(nibName: "AddressListCell", bundle: nil), forCellReuseIdentifier: "AddressListCell")
        addressListTableview.register(UINib(nibName: "PlaceOrderCell", bundle: nil), forCellReuseIdentifier: "PlaceOrderCell")
        addressListTableview.register(UINib(nibName: "AddAddressCell", bundle: nil), forCellReuseIdentifier: "AddAddressCell")
        
        
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
        
        if viewModel.addressData.count >= 0 {
            let attributedString = NSMutableAttributedString(string: "ORDER")
            let range = NSRange(location: 0, length: 5)
            attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 24), range: range)
            orderButton.setAttributedTitle(attributedString, for: .normal)
        }
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
        if selectedIndexPath != nil{
            if sender.titleLabel?.text == "ORDER" {
                let selecteddata = dataCollection(index: 1-(selectedIndexPath?.row ?? 0))
                
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
            }else{
                if viewModel.addressData.count != 0 && selectedIndexPath?.row != 0 && selectedIndexPath != nil{
                    self.navigationController?.pushViewController(AddAddressController(nibName: "AddAddressController", bundle: nil), animated: true)
                }else{
                    self.showAlert(msg: "Add an Address")
                }
            }
        }else{
            self.showAlert(msg: "Select the Address")
        }
    }
    
}
extension AddressListViewController : UITableViewDelegate ,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.addressData.count == 0 {
            return 1
        }else{
            return viewModel.addressData.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.addressData.count == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddAddressCell", for: indexPath) as! AddAddressCell
            cell.selectionStyle = .none
            return cell
        }
        
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirstViewCell", for: indexPath) as! FirstViewCell
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddressListCell", for: indexPath) as! AddressListCell
            cell.cellindex = indexPath.row - 1
            cell.deligate = self
            cell.addressLabel.text = "Address \(indexPath.row - 1)"
            cell.addressLabelDetails.text = dataCollection(index: indexPath.row - 1)
            cell.setSelected(indexPath == selectedIndexPath)
            cell.selectionStyle = .none
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel.addressData.count == 0{
            navigationController?.pushViewController(AddAddressController(nibName: "AddAddressController", bundle: nil), animated: true)
        }
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
            addresses.remove(at: indexPath.row-1)
            viewModel.addressData = addresses
            tableView.reloadData()
            selectedIndexPath = nil
            if viewModel.addressData.count <= 0{
                let attributedString = NSMutableAttributedString(string: "Add Address")
                let range = NSRange(location: 0, length: 11)
                attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 24), range: range)
                orderButton.setAttributedTitle(attributedString, for: .normal)
            }
        } else {
            print("no data")
        }
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    
}

extension AddressListViewController : RemoveCell{
    func removeAddressCell(index: Int) {
        var addresses = viewModel.addressData
        addresses.remove(at: index )
        viewModel.addressData = addresses
        addressListTableview.reloadData()
        selectedIndexPath = nil
        if viewModel.addressData.count <= 0{
            let attributedString = NSMutableAttributedString(string: "Add Address")
            let range = NSRange(location: 0, length: 11)
            attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 24), range: range)
            orderButton.setAttributedTitle(attributedString, for: .normal)
        }
    }
    
    
}
