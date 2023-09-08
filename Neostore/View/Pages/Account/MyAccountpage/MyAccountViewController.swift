//
//  MyAccountViewController.swift
//  Neostore
//
//  Created by Neosoft on 02/09/23.
//

import UIKit

class MyAccountViewController: UIViewController {
    
    let viewModel = SideMenuViewmodel()
    
    @IBOutlet var myAccountTextViews: [UIView]!
    @IBOutlet weak var accountFname: UITextField!
    @IBOutlet weak var accountLname: UITextField!
    @IBOutlet weak var accountEmail: UITextField!
    @IBOutlet weak var accountPhoneNo: UITextField!
    @IBOutlet weak var accountDateOfBirth: UITextField!
    @IBOutlet weak var editbutton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    var originalViewYPosition: CGFloat = 0.0
    let datePicker = UIPickerView()
    var selectedDate = ""
    
    //
    //pickerview data
    let days = Array(1...31)
    let months = Array(1...12)
    let minYear = 1970
    let maxYear = Calendar.current.component(.year, from: Date())
    lazy var years: [Int] = {
        return Array(minYear...maxYear)
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for textViews in myAccountTextViews{
            textViews.layer.borderWidth = 1
            textViews.layer.borderColor = UIColor.white.cgColor
        }
        
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
        
        // deligate for picker view
        datePicker.delegate = self
        datePicker.dataSource = self
        
        accountDateOfBirth.inputView = datePicker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([cancelButton, flexibleSpace, doneButton], animated: false)
        accountDateOfBirth.inputAccessoryView = toolbar
        toolbar.tintColor = #colorLiteral(red: 0.05993984508, green: 0.04426076461, blue: 0.08429525985, alpha: 1)
        
        // setting th ecurrent data for pickedr view
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
        
        
        // for pickerview
        NotificationCenter.default.addObserver(self, selector: #selector(pickerWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(pickerWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        originalViewYPosition = view.frame.origin.y
        fillData()
    }
    
    @objc func pickerWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            
            // Check if the active text field is not FirstName or LastName
            if UIResponder.currentFirstResponder is UITextField{
                UIView.animate(withDuration: 0.3) {
                    // Move the view upward by the keyboard's height
                    self.view.frame.origin.y = self.originalViewYPosition - keyboardHeight + 80
                }
            }
        }
    }
    @objc func pickerWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            // Restore the view to its original position
            self.view.frame.origin.y = self.originalViewYPosition
        }
    }
    
    @objc func doneButtonTapped() {
        accountDateOfBirth.resignFirstResponder()
        if selectedDate.isEmpty{
            self.showAlert(msg: "selcet the proper date")
        }else{
            accountDateOfBirth.text = selectedDate
            print(selectedDate)
        }
    }
    @objc func cancelButtonTapped() {
        accountDateOfBirth.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textField.inputView = datePicker
    }
    func assignDatatoTextfields(){
        
    }
    
    func fillData(){
        self.accountFname.text = SideMenuViewmodel.menuDemoData.data?.user_data?.first_name
        self.accountLname.text = SideMenuViewmodel.menuDemoData.data?.user_data?.last_name
        self.accountEmail.text = SideMenuViewmodel.menuDemoData.data?.user_data?.email
        self.accountPhoneNo.text = String(SideMenuViewmodel.menuDemoData.data?.user_data?.phone_no ?? "0")
        self.accountDateOfBirth.text = String(SideMenuViewmodel.menuDemoData.data?.user_data?.dob ?? "0")
        
    }
//    func getData(){
//        viewModel.fetchAccountDetails(){
//            responce in
//            DispatchQueue.main.async {
//                if responce {
//                    self.fillData()
//                }
//            }
//        }
//    }
    
    
    @IBAction func EditProfileAction(_ sender: UIButton) {
        print("button is clicked")
        if sender.titleLabel?.text == "Edit Profile" {
            cancelButton.isHidden = false
            let attributedString = NSMutableAttributedString(string: "Save")
            title = "Save Details"
            let range = NSRange(location: 0, length: 4)
            attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 24), range: range)
            sender.setAttributedTitle(attributedString, for: .normal)
            accountFname.isUserInteractionEnabled = true
            accountLname.isUserInteractionEnabled = true
            accountEmail.isUserInteractionEnabled = true
            accountPhoneNo.isUserInteractionEnabled = true
            accountDateOfBirth.isUserInteractionEnabled = true
            accountFname.becomeFirstResponder()
        }else{
            title = "AccountDetails"
            cancelButton.isHidden = true
            let attributedString = NSMutableAttributedString(string: "Edit Profile")
            let range = NSRange(location: 0, length: 12)
            attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 24), range: range)
            sender.setAttributedTitle(attributedString, for: .normal)
            accountFname.isUserInteractionEnabled = false
            accountLname.isUserInteractionEnabled = false
            accountEmail.isUserInteractionEnabled = false
            accountPhoneNo.isUserInteractionEnabled = false
            accountDateOfBirth.isUserInteractionEnabled = false
            //            viewModel.editAccountDetails(first_name: accountFname.text, last_name: accountLname.text, email: accountEmail.text, dob: <#T##String#>, phone_no: <#T##String#>, profile_pic: <#T##String#>, complition: <#T##(Bool) -> Void#>)
        }
        
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        cancelButton.isHidden = true
        fillData()
        title = "AccountDetails"
        let attributedString = NSMutableAttributedString(string: "Edit Profile")
        let range = NSRange(location: 0, length: 12)
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 24), range: range)
        editbutton.setAttributedTitle(attributedString, for: .normal)
        accountFname.isUserInteractionEnabled = false
        accountLname.isUserInteractionEnabled = false
        accountEmail.isUserInteractionEnabled = false
        accountPhoneNo.isUserInteractionEnabled = false
        accountDateOfBirth.isUserInteractionEnabled = false
        
    }
    
    @IBAction func ResetPasswordAction(_ sender: UIButton) {
        
    }
}

extension MyAccountViewController : UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3 // Three components: day, month, year
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
        // Handle the selected date components
        let selectedDay = days[pickerView.selectedRow(inComponent: 0)]
        let selectedMonth = months[pickerView.selectedRow(inComponent: 1)]
        let selectedYear = years[pickerView.selectedRow(inComponent: 2)]
        
        // You can use these components to construct the selected date
        selectedDate = "\(selectedMonth)-\(selectedDay)-\(selectedYear)"
//        print("Selected Date: \(selectedDate)")
    }
    
    
}
