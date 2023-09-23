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
        setupTextfileds()
        baseScrollView = scrollView
        setTitle(titleString: pageTitleConstant.register )
        setDefaultImages()
        setTextFieldDeligates()
        setTapGuesture()
    }
    
    func setTapGuesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func setupTextfileds(){
        registerFirstname.setIcon(UIImage(systemName: ImageConstants.person)!)
        registerlastname.setIcon(UIImage(systemName: ImageConstants.person)!)
        registerEmail.setIcon(UIImage(systemName: ImageConstants.mail)!)
        registerPassword?.setIcon(UIImage(systemName: ImageConstants.lock)!)
        registerConformPassword.setIcon(UIImage(systemName: ImageConstants.lock)!)
        registerPhoneNumber?.setIcon(UIImage(systemName: ImageConstants.phone)!)
        
        registerFirstname.setBorder()
        registerlastname.setBorder()
        registerEmail.setBorder()
        registerPassword?.setBorder()
        registerConformPassword.setBorder()
        registerPhoneNumber?.setBorder()
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
    
    static func loadFromNib()-> UIViewController{
        return RegisterViewController(nibName: navigationVCConstant.registerVC, bundle: nil)
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
       startActivityIndicator()
        viewModel.registervalidation(Fname: registerFirstname.text ?? txtfieldValConst.emptyStr, Lname: registerlastname.text ?? txtfieldValConst.emptyStr, Email: registerEmail.text ?? txtfieldValConst.emptyStr, Pass: registerPassword?.text ?? txtfieldValConst.emptyStr, Cpass: registerConformPassword?.text ?? txtfieldValConst.emptyStr, Gender: gender ?? GenderConstant.NaN , Phone: registerPhoneNumber?.text ?? txtfieldValConst.emptyStr, chkBox: registerchkBox.isSelected ){
            (validateBool , resultStrng) in
            DispatchQueue.main.async {
                if validateBool{
                    self.navigationController?.pushViewController(LoginViewController.loadFromNib(), animated: true)
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
