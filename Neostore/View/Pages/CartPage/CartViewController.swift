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
    
    var selectedTextField: UITextField?
    var selectedOption = 0
    let viewModel = CartViewModel()
    var toolbar = UIToolbar()
    var cellIndexpath : IndexPath = []
    
    @IBOutlet weak var CartPickerView: UIPickerView!
    @IBOutlet weak var CartTableview: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CartPickerView.isHidden = true
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
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped))
        navigationItem.rightBarButtonItem = searchButton
        
        
        self.navigationItem.title = "ProductDetails"
        //adding deligate and datasource
        CartTableview.dataSource = self
        CartTableview.dataSource = self
        
        CartPickerView.delegate = self
        CartPickerView.dataSource = self
        
        //reg cells
        CartTableview.register(UINib(nibName: "ProductDetailsCartCell", bundle: nil), forCellReuseIdentifier: "ProductDetailsCartCell")
        CartTableview.register(UINib(nibName: "CartTotalCell", bundle: nil), forCellReuseIdentifier: "CartTotalCell")
        CartTableview.register(UINib(nibName: "CartOrderCell", bundle: nil), forCellReuseIdentifier: "CartOrderCell")
        
        //getData
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.tintColor = #colorLiteral(red: 0.05993984508, green: 0.04426076461, blue: 0.08429525985, alpha: 1)
        toolbar.setItems([cancelButton, flexibleSpace, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        toolbar.sizeToFit()
    }
    
 
    @objc func searchButtonTapped() {
        navigationController?.pushViewController(CartViewController(nibName: "CartViewController", bundle: nil), animated: true)
    }
    
    
    func getData(){
        viewModel.getCartDetails(){
            responce in
            DispatchQueue.main.async {
                if responce{
                    self.CartTableview.reloadData()
                }
            }
        }
    }
    
    func deleteCartData(indexpath : Int){
        viewModel.deleteCartDetails(id : indexpath){
            responce in
            DispatchQueue.main.async {
                if responce{
                    self.CartTableview.reloadData()
                }
            }
        }
    }
    
    // ui picker view
    @objc func textFieldTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        if let textField = gestureRecognizer.view as? UITextField {
            selectedTextField = textField
            textField.inputView = CartPickerView // Show the picker view
            textField.inputAccessoryView = toolbar // Set the toolbar as an accessory view
            CartPickerView.isHidden = false
            textField.becomeFirstResponder()
            cellIndexpath = IndexPath(row: textField.tag, section: 0)
        }
    }
    @objc func doneButtonTapped() {
        print(selectedOption)
        if selectedOption != 0 {
            viewModel.editToCart(productid: viewModel.cartData?.data?[cellIndexpath.row].productID ?? 0, quantity: String(selectedOption ?? 0) ){
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
            CartPickerView.isHidden = true
        }else{
            deleteCartData(indexpath: viewModel.cartData?.data?[cellIndexpath.row].productID ?? 0 )
            self.getData()
        }
    }
    
    @objc func cancelButtonTapped() {
        selectedTextField?.resignFirstResponder() // Hide the keyboard/picker view
        CartPickerView.isHidden = true
    }
    
    
    
    
}
extension CartViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2+(viewModel.cartData?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let TotalData = viewModel.cartData?.count ?? 0
        if (TotalData ) > 0 {
            
            if (indexPath.row) < TotalData{
                let productCell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailsCartCell", for: indexPath) as! ProductDetailsCartCell

                //for picker view
                productCell.CartProductQuantity.delegate = self
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(textFieldTapped(_:)))
                productCell.CartProductQuantity.addGestureRecognizer(tapGestureRecognizer)
                productCell.CartProductQuantity.tag = indexPath.row
                
                
                productCell.CartProductName.text = viewModel.cartData?.data?[indexPath.row].product?.name
                productCell.cartProductCategory.text = viewModel.cartData?.data?[indexPath.row].product?.productCategory
                productCell.CartProductQuantity.text = String(viewModel.cartData?.data?[indexPath.row].quantity ?? 0)
                productCell.CartProuductTotalCost.text = String(viewModel.cartData?.data?[indexPath.row].product?.subTotal ?? 0)
                if let imageUrl = URL(string: viewModel.cartData?.data?[indexPath.row].product?.productImages ?? "invalid" ) {
                    productCell.CartProductImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "bg.jpg"))
                } else {
                    productCell.CartProductImage.image = UIImage(named: "bg.jpg")
                }
                productCell.selectionStyle = .none
                return productCell
                
            }else if indexPath.row == TotalData{
                let productCell = tableView.dequeueReusableCell(withIdentifier: "CartTotalCell", for: indexPath) as! CartTotalCell
                productCell.CartTotalCost.text = String(viewModel.cartData?.total ?? 0)
                productCell.selectionStyle = .none
                return productCell
                
            }else if indexPath.row == TotalData+1{
                let productCell = tableView.dequeueReusableCell(withIdentifier: "CartOrderCell", for: indexPath) as! CartOrderCell
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
                productCell.CartTotalCost.text = String(0)
                productCell.selectionStyle = .none
                return productCell
            }else if indexPath.row == 1{
                let productCell = tableView.dequeueReusableCell(withIdentifier: "CartOrderCell", for: indexPath) as! CartOrderCell
                productCell.selectionStyle = .none
                return productCell
            }else{
                let productCell = tableView.dequeueReusableCell(withIdentifier: "CartOrderCell", for: indexPath) as! CartOrderCell
                productCell.selectionStyle = .none
                return productCell
            }
        }
    }
    
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
            deleteCartData(indexpath: viewModel.cartData?.data?[indexPath.row].productID ?? 1)
            getData()
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


