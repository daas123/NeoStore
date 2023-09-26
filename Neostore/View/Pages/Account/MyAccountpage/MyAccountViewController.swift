//
//  MyAccountViewController.swift
//  Neostore
//
//  Created by Neosoft on 02/09/23.
//

import UIKit

class MyAccountViewController: BaseViewController,UITextFieldDelegate {
    
    // MARK: file varible
    let viewModel = AccountViewModel()
    var accesstoken : String?
    var image: UIImage?
    let datePicker = UIPickerView()
    var selectedDate = ""
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainbackView: UIView!
    @IBOutlet var myAccountTextViews: [UIView]!
    @IBOutlet weak var accountFname: UITextField!
    @IBOutlet weak var accountLname: UITextField!
    @IBOutlet weak var accountEmail: UITextField!
    @IBOutlet weak var accountPhoneNo: UITextField!
    @IBOutlet weak var accountDateOfBirth: UITextField!
    @IBOutlet weak var editbutton: UIButton!
    @IBOutlet weak var accountImage: UIImageView!
    @IBOutlet weak var cancelButton: UIButton!
    
    
    let days = Array(1...31)
    let months = Array(1...12)
    let minYear = 1970
    let maxYear = Calendar.current.component(.year, from: Date())
    lazy var years: [Int] = {
        return Array(minYear...maxYear)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseScrollView = scrollView
        setupImage()
        setdeligate()
        setNotificationObserver()
        setupGuesture()
        setPickerview()
        setToolbar()
        setupTextfileds()
        setTitle(titleString: pageTitleConstant.acccountDetails)
        fillData()
        
    }
    
    func setupTextfileds(){
        accountFname.setIcon(UIImage(systemName: ImageConstants.person))
        accountLname.setIcon(UIImage(systemName: ImageConstants.person))
        accountEmail.setIcon(UIImage(named: ImageConstants.mail))
        accountPhoneNo.setIcon(UIImage(systemName: ImageConstants.phone))
        accountDateOfBirth.setIcon(UIImage(named: ImageConstants.cake))
        accountFname.setBorder()
        accountLname.setBorder()
        accountEmail.setBorder()
        accountPhoneNo.setBorder()
        accountDateOfBirth.setBorder()
    }
    
    func setNotificationObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(pickerWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(pickerWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        originalViewYPosition = view.frame.origin.y
    }
    
    func setupGuesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleImageTap))
        accountImage.addGestureRecognizer(tapGesture)
        
        let viewtapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(viewtapGesture)
    }
    func setPickerview(){
        accountDateOfBirth.inputView = datePicker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: toolbarBtnConstant.done, style: .plain, target: self, action: #selector(doneButtonTapped))
        let cancelButton = UIBarButtonItem(title: toolbarBtnConstant.cancel, style: .plain, target: self, action: #selector(cancelButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([cancelButton, flexibleSpace, doneButton], animated: false)
        accountDateOfBirth.inputAccessoryView = toolbar
        toolbar.tintColor = ColorConstant.black
    }
    
    func setToolbar(){
        let currentDate = Date()
        let currentDay = Calendar.current.component(.day, from: currentDate)
        let currentMonth = Calendar.current.component(.month, from: currentDate)
        let currentYear = Calendar.current.component(.year, from: currentDate)
        datePicker.selectRow(currentDay - 1, inComponent: 0, animated: false)
        datePicker.selectRow(currentMonth - 1, inComponent: 1, animated: false)
        if let yearIndex = years.firstIndex(of: currentYear) {
            datePicker.selectRow(yearIndex, inComponent: 2, animated: false)
        }
        accountDateOfBirth.text = "\(currentMonth)-\(currentDay)-\(currentYear)"
    }
    
    func setdeligate(){
        datePicker.delegate = self
        datePicker.dataSource = self
        accountFname.delegate = self
        accountLname.delegate = self
        accountEmail.delegate = self
        accountPhoneNo.delegate = self
    }
    
    func setupImage(){
        accountImage.image = UIImage(named: ImageConstants.default_img)
        accountImage.layer.cornerRadius = accountImage.frame.size.width / 2
        accountImage.clipsToBounds = true
    }
    
    static func loadFromNib()-> UIViewController{
        return MyAccountViewController(nibName: navigationVCConstant.myAccountVC, bundle: nil)
    }
    
    @objc func handleImageTap() {
        view.endEditing(true)
        openActionSheetForUploadImage()
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == accountFname {
            accountLname.becomeFirstResponder()
        } else if textField == accountLname {
            accountEmail.becomeFirstResponder()
        } else if textField == accountEmail {
            accountPhoneNo.becomeFirstResponder()
        } else if textField == accountPhoneNo {
            accountDateOfBirth.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    
    @objc func pickerWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            _ = keyboardFrame.height
            if let activeTextField = UIResponder.currentFirstResponder as? UITextField,
               activeTextField != accountFname && activeTextField != accountLname {
                UIView.animate(withDuration: 0.3) {
                    UIView.animate(withDuration: 0.3) {
                        var contentInset:UIEdgeInsets = self.scrollView.contentInset
                        contentInset.bottom = keyboardFrame.size.height + 20
                        self.scrollView.contentInset = contentInset
                    }
                }
                
            }
        }
    }
    @objc func pickerWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentInset = UIEdgeInsets.zero
        }
    }
    
    @objc func doneButtonTapped() {
        accountDateOfBirth.resignFirstResponder()
        if selectedDate.isEmpty{
            self.showAlert(msg: alertMsgConstant.selectDate)
        }else{
            accountDateOfBirth.text = selectedDate
        }
    }
    @objc func cancelButtonTapped() {
        accountDateOfBirth.resignFirstResponder()
        
    }
    // MARK: INITIAL DATA FILL
    func fillData(){
        self.accountFname.text = SideMenuViewmodel.menuDemoData.data?.user_data?.first_name
        self.accountLname.text = SideMenuViewmodel.menuDemoData.data?.user_data?.last_name
        self.accountEmail.text = SideMenuViewmodel.menuDemoData.data?.user_data?.email
        self.accountPhoneNo.text = String(SideMenuViewmodel.menuDemoData.data?.user_data?.phone_no ?? txtfieldValConst.emptyStr)
        self.accountDateOfBirth.text = String(SideMenuViewmodel.menuDemoData.data?.user_data?.dob ?? txtfieldValConst.emptyStr)
        // MARK: SET Data tot view model
        viewModel.storeData(firstname: (SideMenuViewmodel.menuDemoData.data?.user_data?.first_name)!,
                            lastname: (SideMenuViewmodel.menuDemoData.data?.user_data?.last_name)!,
                            email: (SideMenuViewmodel.menuDemoData.data?.user_data?.email)!,
                            dob: String(SideMenuViewmodel.menuDemoData.data?.user_data?.dob ?? txtfieldValConst.emptyStr),
                            phoneno: String(SideMenuViewmodel.menuDemoData.data?.user_data?.phone_no ?? txtfieldValConst.emptyStr))
        if let accessToken = self.accesstoken,
           let imageData = UserDefaults.standard.data(forKey: accessToken),
           let image = UIImage(data: imageData) {
            DispatchQueue.main.async {
                self.stopActivityIndicator()
                self.accountImage.image = image
            }
        }else{
            DispatchQueue.main.async {
                self.stopActivityIndicator()
            }
        }
        
        stopActivityIndicator()
    }
    func setButtonState(val:Bool){
        accountFname.isUserInteractionEnabled = val
        accountLname.isUserInteractionEnabled = val
        accountEmail.isUserInteractionEnabled = val
        accountPhoneNo.isUserInteractionEnabled = val
        accountDateOfBirth.isUserInteractionEnabled = val
        
    }
    func succeessSetup(sender : UIButton){
        self.setTitle(titleString: pageTitleConstant.acccountDetails)
        self.accountImage.isUserInteractionEnabled = false
        self.cancelButton.isHidden = true
        sender.setAttributedTitle(self.setEditButtontext(), for: .normal)
        self.setButtonState(val: false)
        
        if let image = self.image  {
            if let imageData = image.pngData(), let accessToken = self.accesstoken {
                UserDefaults.standard.set(imageData, forKey: accessToken)
                self.accountImage.image = image
            }
        }
        NotificationCenter.default.post(name: .reloadSideMenuData, object: nil)
    }
    
    @IBAction func EditProfileAction(_ sender: UIButton) {
        
        if sender.titleLabel?.text == btnString.editProfile {
            accountImage.isUserInteractionEnabled = true
            cancelButton.isHidden = false
            sender.setAttributedTitle(setSaveButtontext(), for: .normal)
            setButtonState(val: true)
            accountFname.becomeFirstResponder()
        }else{
            guard !viewModel.chkChanges(firstname: accountFname.text!, lastname: accountLname.text!, email: accountEmail.text!, dob: accountDateOfBirth.text!, phoneno: accountPhoneNo.text!) else{
                succeessSetup(sender: sender)
                return
            }
            // MARK: API CALL
            validation().editAccountValidation(fname: accountFname.text ?? txtfieldValConst.emptyStr, lname: accountLname.text ?? txtfieldValConst.emptyStr , email: accountEmail.text  ?? txtfieldValConst.emptyStr, phone: accountPhoneNo.text ?? txtfieldValConst.emptyStr){
                (resultMsg) in
                if resultMsg == txtfieldValConst.emptyStr {
                    self.viewModel.editAccountDetails(first_name: self.accountFname.text ?? txtfieldValConst.emptyStr, last_name: self.accountLname.text ?? txtfieldValConst.emptyStr, email: self.accountEmail.text  ?? txtfieldValConst.emptyStr, dob: self.selectedDate , phone_no: self.accountPhoneNo.text ?? txtfieldValConst.emptyStr){
                        resultStr in
                        DispatchQueue.main.async {
                            if resultStr == txtfieldValConst.emptyStr{
                                NotificationCenter.default.post(name: .reloadSideMenuData, object: nil)
                                self.showAlert(msg: alertMsgConstant.details_Updated_Succefully)
                                self.succeessSetup(sender: sender)
                                
                                self.viewModel.storeData(firstname: self.accountFname.text!,
                                                         lastname: self.accountLname.text!,
                                                         email: self.accountEmail.text!,
                                                         dob: String(self.accountDateOfBirth.text!),
                                                         phoneno: String(self.accountPhoneNo.text!))
                                
                            }else{
                                self.showAlert(msg: resultStr)
                            }
                        }
                    }
                }else{
                    self.showAlert(msg: resultMsg)
                }
            }
            
        }
        
    }
    
    func setEditButtontext()-> NSAttributedString{
        let attributedString = NSMutableAttributedString(string: btnString.editProfile)
        let range = NSRange(location: 0, length: 12)
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 24), range: range)
        return attributedString
    }
    
    func setSaveButtontext()-> NSAttributedString{
        let attributedString = NSMutableAttributedString(string: btnString.save)
        setTitle(titleString: pageTitleConstant.saveDetails)
        let range = NSRange(location: 0, length: 4)
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 24), range: range)
        return attributedString
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        cancelButton.isHidden = true
        fillData()
        setTitle(titleString: pageTitleConstant.acccountDetails)
        accountImage.isUserInteractionEnabled = false
        editbutton.setAttributedTitle(self.setEditButtontext(), for: .normal)
        accountFname.isUserInteractionEnabled = false
        accountLname.isUserInteractionEnabled = false
        accountEmail.isUserInteractionEnabled = false
        accountPhoneNo.isUserInteractionEnabled = false
        accountDateOfBirth.isUserInteractionEnabled = false
    }
    
    @IBAction func ResetPasswordAction(_ sender: UIButton) {
        navigationController?.pushViewController(ResetPassViewController.loadFromNib(), animated: true)
    }
}

extension MyAccountViewController : UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return days.count
        case 1:
            return months.count
        case 2:
            return years.count
        default:
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(days[row])"
        case 1:
            return "\(months[row])"
        case 2:
            return "\(years[row])"
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedDay = days[pickerView.selectedRow(inComponent: 0)]
        let selectedMonth = months[pickerView.selectedRow(inComponent: 1)]
        let selectedYear = years[pickerView.selectedRow(inComponent: 2)]
        selectedDate = "\(selectedMonth)-\(selectedDay)-\(selectedYear)"
    }
    
    
}

extension MyAccountViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: For Upload the image
    func openActionSheetForUploadImage(){
        let alert:UIAlertController=UIAlertController(title: alertMsgConstant.choose_Image, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let cameraAction = UIAlertAction(title: alertMsgConstant.camera, style: UIAlertAction.Style.default){
            UIAlertAction in
            self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: alertMsgConstant.gallery, style: UIAlertAction.Style.default){
            UIAlertAction in
            self.openGallary()
        }
        
        let cancelAction = UIAlertAction(title: alertMsgConstant.cancel, style: UIAlertAction.Style.cancel){
            UIAlertAction in
        }
        imagePicker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    // MARK: For opning the camera
    func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            
        }
    }
    // MARK: for opningthe gallery
    func openGallary(){
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    // MARK: Selected Image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            image = img
            accountImage.image = image
        } else if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = img
            accountImage.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
