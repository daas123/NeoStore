//
//  RegisterViewController.swift
//  Neostore
//
//  Created by Neosoft on 17/08/23.
//

import UIKit

class RegisterViewController: BaseViewController{
    // MARK: File variable
    var gender:String?
    var chkbtn = false
    let viewModel = RegisterViewModel()
    
    // MARK: IBOutlet for Uiview
    @IBOutlet var registerDetailsView: [UIView]!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: IBOutlet for Textfields
    @IBOutlet weak var registerFirstname: UITextField!
    @IBOutlet weak var registerlastname: UITextField!
    @IBOutlet weak var registerEmail: UITextField!
    @IBOutlet weak var registerPassword: UITextField?
    @IBOutlet weak var registerConformPassword: UITextField!
    @IBOutlet weak var registerPhoneNumber: UITextField?
    
    // MARK: IBOutlet for Button
    @IBOutlet weak var registerFemaleradio: UIButton!
    @IBOutlet weak var registerMaleRadio: UIButton!
    @IBOutlet weak var registerchkBox: UIButton!
    
    // MARK: ViewDidload
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Setting scroll View in base view controller
        baseScrollView = scrollView
        
        // MARK: Page Title
        title = pageTitleConstant.register
        
        // MARK: Creating the border
        for registerViews in registerDetailsView{
            registerViews.layer.borderWidth = 2
            registerViews.layer.borderColor = UIColor.white.cgColor
        }
        
        // MARK: Male Female Radio Btn Defalut Images
        setDefaultImages()
        
        // MARK: TextField Deligate
        setTextFieldDeligates()
        
        // MARK: Tap Guesture For View
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
    }
    
    //MARK: Default Images
    func setDefaultImages(){
        registerMaleRadio.setImage(UIImage(systemName: ImageConstants.circle), for: .normal)
        registerMaleRadio.setImage(UIImage(systemName: ImageConstants.circle_fill), for: .selected)
        registerFemaleradio.setImage(UIImage(systemName: ImageConstants.circle), for: .normal)
        registerFemaleradio.setImage(UIImage(systemName: ImageConstants.circle_fill), for: .selected)
        registerchkBox.setImage(UIImage(systemName: ImageConstants.square), for: .normal)
        registerchkBox.setImage(UIImage(systemName: ImageConstants.square_fill), for: .selected)
    }
    
    //MARK: VD Func Settitng the deligate for textfields
    func setTextFieldDeligates(){
        registerFirstname.delegate = self
        registerlastname.delegate = self
        registerEmail.delegate = self
        registerPassword?.delegate = self
        registerConformPassword.delegate = self
        registerPhoneNumber?.delegate = self
    }
    
    @IBAction func radioTapped(_ sender: UIButton) {
        if sender == registerMaleRadio{
            gender = GenderConstant.male
            registerMaleRadio.isSelected = true
            registerFemaleradio.isSelected = false
        }else{
            gender = GenderConstant.female
            registerMaleRadio.isSelected = false
            registerFemaleradio.isSelected = true
        }
    }
    
    @IBAction func checkbutton(_ sender: UIButton) {
        if chkbtn {
            registerchkBox.isSelected = true
            chkbtn = false
        }else{
            registerchkBox.isSelected = false
            chkbtn = true
        }
    }
    
    @IBAction func registerButtonAction(_ sender: UIButton) {
        self.startActivityIndicator()
        viewModel.registervalidation(Fname: registerFirstname.text ?? "", Lname: registerlastname.text ?? "", Email: registerEmail.text ?? "", Pass: registerPassword?.text ?? "", Cpass: registerConformPassword?.text ?? "", Gender: gender ?? GenderConstant.NaN , Phone: registerPhoneNumber?.text ?? "", chkBox: registerchkBox.isSelected ){
            (validateBool , resultStrng) in
            DispatchQueue.main.async {
                if validateBool{
                    self.navigationController?.pushViewController(LoginViewController(nibName:"LoginViewController", bundle: nil), animated: true)
                    self.showAlert(msg: resultStrng)
                }else{
                    self.showAlert(msg: resultStrng)
                }
                self.stopActivityIndicator()
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
extension RegisterViewController : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case registerFirstname:
            registerlastname.becomeFirstResponder()
        case registerlastname:
            registerEmail.becomeFirstResponder()
        case registerEmail:
            registerPassword?.becomeFirstResponder()
        case registerPassword:
            registerConformPassword.becomeFirstResponder()
        case registerConformPassword:
            registerPhoneNumber?.resignFirstResponder()
        default:
            break
        }
        return true
    }
}
