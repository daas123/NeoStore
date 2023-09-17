//
//  CartViewController.swift
//  Neostore
//
//  Created by Neosoft on 22/08/23.
//

import UIKit
import SDWebImage
struct cartDetails{
    var name : String
    var category : String
    var image : String
}
class CartViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var cartStackView: UIStackView!
    
    var selectedTextField: UITextField?
    var selectedOption = 0
    let viewModel = CartViewModel()
    var toolbar = UIToolbar()
    var cellIndexpath : IndexPath = []
    var cartPickerView = UIPickerView()
    @IBOutlet weak var cartTableview: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartPickerView.isHidden = true
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
//        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped))
//        navigationItem.rightBarButtonItem = searchButton
        
        
        self.navigationItem.title = "My Cart"
        //adding deligate and datasource
        cartTableview.dataSource = self
        cartTableview.dataSource = self
        
        cartPickerView.delegate = self
        cartPickerView.dataSource = self
        
        //reg cells
        cartTableview.register(UINib(nibName: "ProductDetailsCartCell", bundle: nil), forCellReuseIdentifier: "ProductDetailsCartCell")
        cartTableview.register(UINib(nibName: "CartTotalCell", bundle: nil), forCellReuseIdentifier: "CartTotalCell")
        cartTableview.register(UINib(nibName: "CartOrderCell", bundle: nil), forCellReuseIdentifier: "CartOrderCell")
        
        //getData
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.tintColor = #colorLiteral(red: 0.05993984508, green: 0.04426076461, blue: 0.08429525985, alpha: 1)
        toolbar.setItems([cancelButton, flexibleSpace, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        toolbar.sizeToFit()
        // tap guesture for picker view
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
        // guesture for keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            
            // Check if the active text field is not FirstName or LastName
            if let activeTextField = UIResponder.currentFirstResponder as? UITextField{
                UIView.animate(withDuration: 0.3) {
                    var contentInset:UIEdgeInsets = self.cartTableview.contentInset
                            contentInset.bottom = keyboardFrame.size.height
                    self.cartTableview.contentInset = contentInset
                    self.cartTableview.scrollToRow(at: IndexPath(row: self.cellIndexpath.row, section: self.cellIndexpath.section), at: .top, animated: true)
                }
                
            }
        }
    }
    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            // Restore the view to its original position
            self.cartTableview.contentInset = UIEdgeInsets.zero
        }
    }







    @objc func viewTapped() {
        cartTableview.reloadData()
        selectedTextField?.resignFirstResponder() // Hide the keyboard/picker view
        cartPickerView.isHidden = true
    }
    
    @objc func searchButtonTapped() {
        //        navigationController?.pushViewController(CartViewController(nibName: "CartViewController", bundle: nil), animated: true)
    }
    
    
    func getData(){
        viewModel.getCartDetails(){
            responce in
            DispatchQueue.main.async {
                if responce{
                    self.cartTableview.reloadData()
                    self.stopActivityIndicator()
                    
                    self.cartPickerView.reloadAllComponents()
                    
                    if let selectedTextField = self.selectedTextField {
                        self.cartPickerView.selectRow(self.selectedOption - 1, inComponent: 0, animated: false)
                        selectedTextField.text = String(self.selectedOption)
                    }
                }
            }
        }
    }
    
    func deleteCartData(indexpath : Int){
        viewModel.deleteCartDetails(id : indexpath){
            responce in
            DispatchQueue.main.async {
                if responce{
                    self.cartTableview.reloadData()
                }
            }
        }
    }
    
    // ui picker view
    @objc func textFieldTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        if let textField = gestureRecognizer.view as? UITextField {
            cellIndexpath = IndexPath(row: textField.tag, section: 0)
            cartTableview.scrollToRow(at: cellIndexpath, at: .middle, animated: true)
            selectedTextField = textField
            textField.inputView = cartPickerView // Show the picker view
            textField.inputAccessoryView = toolbar // Set the toolbar as an accessory view
            cartPickerView.isHidden = false
            textField.becomeFirstResponder()
            // Calculate the IndexPath of the selected cell
            cartTableview.scrollToRow(at: cellIndexpath, at: .top, animated: true)
            
            if let initialQuantity = viewModel.cartData?.data?[cellIndexpath.row].quantity {
                selectedOption = initialQuantity
                cartPickerView.selectRow(initialQuantity - 1, inComponent: 0, animated: false)
            }
        }
    }

    @objc func doneButtonTapped() {
        print(selectedOption)
        if selectedOption != 0 {
            viewModel.editToCart(productid: viewModel.cartData?.data?[cellIndexpath.row].productID ?? 0, quantity: String(selectedOption ) ){
                (responce,msg) in
                if responce {
                    DispatchQueue.main.async {
                        if responce{
                            self.getData()
                            
                        }
                    }
                }
            }
            selectedTextField?.resignFirstResponder()
            cartPickerView.isHidden = true
        }else{
            deleteCartData(indexpath: viewModel.cartData?.data?[cellIndexpath.row].productID ?? 0 )
            NotificationCenter.default.post(name: .reloadSideMenuData, object: nil)
            self.getData()
        }
    }
    
    @objc func cancelButtonTapped() {
        cartTableview.reloadData()
        selectedTextField?.resignFirstResponder() // Hide the keyboard/picker view
        cartPickerView.isHidden = true
    }
    
    
    @IBAction func orderAction(_ sender: UIButton) {
        if viewModel.cartData?.count != 0 && viewModel.cartData?.count != nil{
            let addressListController = AddressListViewController(nibName: "AddressListViewController", bundle: nil)
            self.navigationController?.pushViewController(addressListController,animated: true)
        }
    }
    
    
    
}
extension CartViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1+(viewModel.cartData?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let TotalData = viewModel.cartData?.count ?? 0
        if (TotalData ) > 0 {
            
            if (indexPath.row) < TotalData{
                let productCell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailsCartCell", for: indexPath) as! ProductDetailsCartCell
                
                //for picker view
                productCell.cartProductQuantity.delegate = self
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(textFieldTapped(_:)))
                productCell.cartProductQuantity.addGestureRecognizer(tapGestureRecognizer)
                productCell.cartProductQuantity.tag = indexPath.row
                
                
                productCell.cartProductName.text = viewModel.cartData?.data?[indexPath.row].product?.name
                productCell.cartProductCategory.text = viewModel.cartData?.data?[indexPath.row].product?.productCategory
                productCell.cartProductQuantity.text = String(viewModel.cartData?.data?[indexPath.row].quantity ?? 0)
                productCell.cartProuductTotalCost.text = String(viewModel.cartData?.data?[indexPath.row].product?.subTotal ?? 0)
                if let imageUrl = URL(string: viewModel.cartData?.data?[indexPath.row].product?.productImages ?? "invalid" ) {
                    productCell.cartProductImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "bg.jpg"))
                } else {
                    productCell.cartProductImage.image = UIImage(named: "bg.jpg")
                }
                productCell.selectionStyle = .none
                return productCell
                
            }else if indexPath.row == TotalData{
                let productCell = tableView.dequeueReusableCell(withIdentifier: "CartTotalCell", for: indexPath) as! CartTotalCell
                productCell.cartTotalCost.text = String(viewModel.cartData?.total ?? 0)
                productCell.selectionStyle = .none
                return productCell
                
            }else{
                let productCell = tableView.dequeueReusableCell(withIdentifier: "CartTotalCell", for: indexPath) as! CartTotalCell
                productCell.selectionStyle = .none
                return productCell
            }
        }else{
            if indexPath.row == 0{
                let productCell = tableView.dequeueReusableCell(withIdentifier: "CartTotalCell", for: indexPath) as! CartTotalCell
                productCell.cartTotalCost.text = String(0)
                productCell.selectionStyle = .none
                return productCell
            }else{
                let productCell = tableView.dequeueReusableCell(withIdentifier: "CartOrderCell", for: indexPath) as! CartOrderCell
                productCell.selectionStyle = .none
                return productCell
            }
        }
    }
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        if viewModel.cartData?.count == nil || viewModel.cartData?.count == 0 {
    //            return 100
    //        }
    //        else if indexPath.row == viewModel.cartData?.count{
    //            return 200
    //        }else{
    //            return UITableView.automaticDimension
    //        }
    //        return 200
    //    }
    // extra functions
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete
        {
            let deletedata = viewModel.cartData?.data?[indexPath.row].product?.name
            deleteCartData(indexpath: viewModel.cartData?.data?[indexPath.row].productID ?? 1)
            NotificationCenter.default.post(name: .reloadSideMenuData, object: nil)
            getData()
            self.showAlert(msg: "\(deletedata!) is Removed From Cart")
        } else {
            print("Insert")
        }
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    
    
    
}

extension CartViewController : UIPickerViewDelegate , UIPickerViewDataSource{
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.cartPickerviewData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(viewModel.cartPickerviewData[row])
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedOption = viewModel.cartPickerviewData[row]
        print(selectedOption)
    }
}

extension CartViewController : CartAction{
    
    func pushOrderViewController() {
        
        if viewModel.cartData?.count == 0 || viewModel.cartData == nil{
            self.showAlert(msg: "Add product to cart")
        }else{
            let addressListController = AddressListViewController(nibName: "AddressListViewController", bundle: nil)
            self.navigationController?.pushViewController(addressListController,animated: true)
        }
    }
    
    
}
