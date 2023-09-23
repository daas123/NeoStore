//
//  CartViewController.swift
//  Neostore
//
//  Created by Neosoft on 22/08/23.
//

import UIKit
import SDWebImage
class CartViewController: BaseViewController , UITextFieldDelegate {
    
    //MARK: File Variable
    var selectedTextField: UITextField?
    var selectedOption = 0
    let viewModel = CartViewModel()
    var toolbar = UIToolbar()
    var cellIndexpath : IndexPath = []
    var cartPickerView = UIPickerView()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var cartStackView: UIStackView!
    @IBOutlet weak var cartTableview: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseScrollView = scrollView
        title = pageTitleConstant.cart
        setDeligate()
        setToolBarPickerView()
        setupTapGuesture()
        regCell()
    }
    
    func setupTapGuesture(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func setToolBarPickerView(){
        let doneButton = UIBarButtonItem(title: toolbarBtnConstant.done, style: .plain, target: self, action: #selector(doneButtonTapped))
        let cancelButton = UIBarButtonItem(title: toolbarBtnConstant.cancel, style: .plain, target: self, action: #selector(cancelButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.tintColor = ColorConstant.black
        toolbar.setItems([cancelButton, flexibleSpace, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        toolbar.sizeToFit()
    }
    
    
    func regCell(){
        cartTableview.register(UINib(nibName: cellRegNibConstant.productDetailsCartCell, bundle: nil), forCellReuseIdentifier: cellRegNibConstant.productDetailsCartCell)
        cartTableview.register(UINib(nibName: cellRegNibConstant.cartTotalCell, bundle: nil), forCellReuseIdentifier: cellRegNibConstant.cartTotalCell)
        cartTableview.register(UINib(nibName: cellRegNibConstant.emptyCartCell, bundle: nil), forCellReuseIdentifier: cellRegNibConstant.emptyCartCell)
    }
    
    func setDeligate(){
        cartPickerView.isHidden = true
        cartTableview.delegate = self
        cartTableview.dataSource = self
        cartPickerView.delegate = self
        cartPickerView.dataSource = self
    }
    
    static func loadFromNib()-> UIViewController{
        return CartViewController(nibName: navigationVCConstant.cartVC, bundle: nil)
    }
    
    @objc func viewTapped() {
        cartTableview.reloadData()
        selectedTextField?.resignFirstResponder()
        cartPickerView.isHidden = true
    }
    
    func getData(){
        self.startActivityIndicator()
        viewModel.getCartDetails(){
            responce in
            DispatchQueue.main.async {
                if responce{
                    self.stopActivityIndicator()
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
    
    @objc func textFieldTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        if let textField = gestureRecognizer.view as? UITextField {
            cellIndexpath = IndexPath(row: textField.tag, section: 0)
            cartTableview.scrollToRow(at: cellIndexpath, at: .middle, animated: true)
            selectedTextField = textField
            textField.inputView = cartPickerView
            textField.inputAccessoryView = toolbar
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
        selectedTextField?.resignFirstResponder()
        cartPickerView.isHidden = true
    }
    
    @IBAction func orderAction(_ sender: UIButton) {
        if viewModel.cartData?.count != 0 && viewModel.cartData?.count != nil{
            let addressListController = AddressListViewController.loadFromNib()
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
        if (TotalData) > 0 && TotalData != nil {
            if (indexPath.row) < TotalData{
                let productCell = tableView.dequeueReusableCell(withIdentifier: cellRegNibConstant.productDetailsCartCell, for: indexPath) as! ProductDetailsCartCell
                productCell.cartProductQuantity.delegate = self
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(textFieldTapped(_:)))
                productCell.cartProductQuantity.addGestureRecognizer(tapGestureRecognizer)
                productCell.cartProductQuantity.tag = indexPath.row
                productCell.cartProductName.text = viewModel.cartData?.data?[indexPath.row].product?.name
                productCell.cartProductCategory.text = viewModel.cartData?.data?[indexPath.row].product?.productCategory
                productCell.cartProductQuantity.text = String(viewModel.cartData?.data?[indexPath.row].quantity ?? 0)
                productCell.cartProuductTotalCost.text = String(viewModel.cartData?.data?[indexPath.row].product?.subTotal ?? 0)
                if let imageUrl = URL(string: viewModel.cartData?.data?[indexPath.row].product?.productImages ?? ImageConstants.default_img ) {
                    productCell.cartProductImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: ImageConstants.default_img))
                } else {
                    productCell.cartProductImage.image = UIImage(named: ImageConstants.default_img)
                }
                productCell.selectionStyle = .none
                return productCell
            }else if indexPath.row == TotalData{
                let productCell = tableView.dequeueReusableCell(withIdentifier: cellRegNibConstant.cartTotalCell, for: indexPath) as! CartTotalCell
                productCell.cartTotalCost.text = String(viewModel.cartData?.total ?? 0)
                productCell.selectionStyle = .none
                return productCell
            }
        }
        let emptyCell = tableView.dequeueReusableCell(withIdentifier: cellRegNibConstant.emptyCartCell, for: indexPath) as! EmptyCartCell
        emptyCell.selectionStyle = .none
        return emptyCell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if indexPath.row < viewModel.cartData?.count ?? 0{
            let deleteAction = UIContextualAction(style: .destructive, title: txtfieldValConst.emptyStr) { (_, _, completionHandler) in
                let deletedata = self.viewModel.cartData?.data?[indexPath.row].product?.name
                let alert = UIAlertController(title: alertMsgConstant.conformDeletion, message: "\(alertMsgConstant.deleteConformMsg) \(deletedata!)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: alertMsgConstant.cancel, style: .cancel, handler: { (_) in
                    completionHandler(false) // Do not perform the delete action
                }))
                alert.addAction(UIAlertAction(title: alertMsgConstant.delete, style: .destructive, handler: { (_) in
                    // Perform the delete action
                    self.deleteCartData(indexpath: self.viewModel.cartData?.data?[indexPath.row].productID ?? 1)
                    NotificationCenter.default.post(name: .reloadSideMenuData, object: nil)
                    self.getData()
                    completionHandler(true)
                }))
                self.present(alert, animated: true, completion: nil)
            }
            
            deleteAction.image = UIImage(systemName: ImageConstants.trash) // Set your delete button image
            
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            return configuration
        }
        let configuration = UISwipeActionsConfiguration(actions: [])
        return configuration
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
            self.showAlert(msg: alertMsgConstant.addproduct)
        }else{
            let addressListController = AddressListViewController.loadFromNib()
            self.navigationController?.pushViewController(addressListController,animated: true)
        }
    }
}
