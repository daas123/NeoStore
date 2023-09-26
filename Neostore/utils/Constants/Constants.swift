//
//  Constants.swift
//  Neostore
//
//  Created by Neosoft on 18/09/23.
//

import Foundation
import UIKit

struct ColorConstant{
    static let primary_red = UIColor(red: 0.9568627451, green: 0.09411764706, blue: 0.05490196078, alpha: 1.0)
    // tool bar backgound color
    static let black = UIColor(red: 0.05993984508, green: 0.04426076461, blue: 0.08429525985, alpha: 1)
    // for activity indicator transperent color
    static let whiteTarnsperent = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3096592379)
    // for border
    static let white = UIColor.white
}

struct toolbarBtnConstant{
    static let done = "Done"
    static let cancel = "Cancel"
}

struct pageTitleConstant{
    static let register = "Register"
    // sdiemenu cell title
    static let cart = "Cart"
    static let account = "My Account"
    static let Store_Locator = "Store Locator"
    static let My_Orders = "My Orders"
    static let logOut = "logOut"
    static let selectAddress = "Select Address"
    static let addAddress = "Add Address"
    static let acccountDetails = "Account Details"
    static let saveDetails = "Save Details"
    static let reset_Password = "Reset Password"
}

struct navigationVCConstant{
    static let loginVC = "LoginViewController"
    static let registerVC = "RegisterViewController"
    static let homeVC = "HomeViewController"
    static let sideMenuVC = "SideMenuViewController"
    static let productListVC = "ProductViewController"
    static let productDetailsVC = "ProductDetailsController"
    static let productDetailsOrderVC = "ProductDetailsOrderViewController"
    static let productDetailsRateController = "ProductDetailsRateController"
    static let cartVC = "CartViewController"
    static let addressListVC = "AddressListViewController"
    static let addAddressVC = "AddAddressController"
    static let myOrdersVC = "MyOrdersViewController"
    static let myOrdersDetailsVC = "OrderIdViewController"
    static let storeLocatorVC = "StoreLocatorViewController"
    static let myAccountVC = "MyAccountViewController"
    static let reSetPassVC = "ResetPassViewController"
}

struct cellRegNibConstant{
    static let homeCollectionViewCell = "HomeCollectionViewCell"
    static let categoryCollectionCell = "CategoryCollectionCell"
    static let imageCollectionviewCell = "ImageCollectionviewCell"
    static let sideMenuTableViewCell = "SideMenuTableViewCell"
    static let cartTableViewCell = "CartTableViewCell"
    static let productTableViewCell = "ProductTableViewCell"
    static let productDetailsTitleCell = "ProductDetailsTitleCell"
    static let productDetailsImageCell = "ProductDetailsImageCell"
    static let productDetailsDescriptionCell = "ProductDetailsDescriptionCell"
    static let productDetailsBuynowCell = "ProductDetailsBuynowCell"
    static let sepratorCell = "SepratorCell"
    static let productDetailsCartCell = "ProductDetailsCartCell"
    static let cartTotalCell = "CartTotalCell"
    static let cartOrderCell = "CartOrderCell"
    static let firstViewCell = "FirstViewCell"
    static let addressListCell = "AddressListCell"
    static let placeOrderCell = "PlaceOrderCell"
    static let addAddressCell = "AddAddressCell"
    static let orderIdCell = "OrderIdCell"
    static let orderIdListCell = "OrderIdListCell"
    static let orderIdTotalCell = "OrderIdTotalCell"
    static let emptyCartCell = "EmptyCartCell"
}

struct ImageConstants {
    static let default_img = "newbg"
    static let circle = "circle"
    static let circle_fill = "circle.fill"
    static let square = "square"
    static let square_fill = "checkmark.square"
    // for side menu
    static let side_menu_Image = "saad"
    static let user_Defaults = "userdefault"
    // for productviewController
    static let magnifyingglass = "magnifyingglass"
    // for cart page
    static let trash = "trash.fill"
    // for adddrss lis tpage
    static let plus = "plus"
    // for location
    static let red_pin = "red_pin"
    // for raring
    static let starFill = "star.fill"
    static let star = "star"
    static let empty = ""
    // for textfiles
    static let person = "person.fill"
    static let lock = "lock.fill"
    static let mail = "mail"
    static let phone = "phone.fill"
    static let cake = "cake"
    static let userdefault = "userdefault"
//    static let  = ""
    
    
    

}

struct homeCollectionViewConstant{
    static let name = "name"
    static let lblPosition = "lblPosition"
    static let imgName = "imgName"
    static let imgPosition = "imgPosition"
}

struct NavigationbarConstant{
    static let backButton_image = "chevron.left"
}

struct GenderConstant{
    static let male = "M"
    static let female = "F"
    static let NaN = "NaN"
}

struct txtfieldValConst{
    static let address = "Address"
    static let emptyStr = ""
    static let someThingWentWrong = "Some Thing Went Wrong"
    static let productAddedToCart = "Added To Cart Successfully"
    static let ratingDoneSuccessfull = "Rated Successfully"
    static let passwordSentSuccess = "Password Sent Successfully"
    static let passwordResetSuccess = "Password Reset Successfully"
}

struct alertMsgConstant{
    static let password_send_succesfully = "Reset Email send succesfully"
    // for cart page
    static let cancel = "Cancel"
    static let delete = "Delete"
    static let conformDeletion = "Confirm Deletion"
    static let deleteConformMsg = "Are you sure you want to delete"
    static let addproduct = "Add product to cart"
    // for picker view in my acccount
    static let selectDate = "Select the Proper Date"
    static let details_Updated_Succefully = "Details Updated Succefully"
    // for my accocunt page
    static let choose_Image = "Choose Image"
    static let camera = "Camera"
    static let gallery = "Gallery"
    // for addresslist vc
    static let order_done_Succesfully = "Order done Succesfully"
    static let add_an_Address = "Add an Address"
    static let select_the_Address = "Select the Address"
    
    static let ok = "OK"
}

struct btnString{
    // for login
    static let sendEmail = "SEND EMAIL"
    static let login = "LOGIN"
    static let save = "SAVE"
    static let editProfile = "Edit Profile"
    // for addreslist page
    static let order = "ORDER"
    static let add_Address = "Add Address"
}

struct errorConstant{
    static let error = "some thing went wrong"
}

struct apikeyConstant{
    static let googleMapApiKeyPaid = "AIzaSyDu8Jcaz3rWu-e9I8xP2y2hSWnXYnW6IfY"
}

struct notificationString{
    static let message = "message"
    static let viewWillDisappearNotification = "ViewWillDisappearNotification"
    static let reloadSideMenuData = "ReloadSideMenuData"
    static let ratingDoneNotification = "RatingDoneNotification"
    
}

struct storelocatorConstant{
    static let baseUrl = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
    static let radius = "1000"
    static let type = "restaurant"
    static let queryLocation = "location"
    static let queryRadius = "radius"
    static let queryKey = "key"
    static let queryType = "type"
    static let results = "results"
    static let name = "name"
    static let geometry = "geometry"
    static let location = "location"
    static let lat = "lat"
    static let lng = "lng"
    static let types = "types"
    static let restaurant = "restaurant"
}

struct userDefConstant{
    static let accessToken = "accessToken"
    static let empty = ""
    static let myAddress = "myAddress"
}

struct validationConstant{
    static let emptyStr = ""
    static let enterTheUsername = "Enter the Username"
    static let enterThePassword = "Enter the Password"
    static let emailAllowedChar = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    static let emailStruct = "SELF MATCHES %@"
    static let enterTheValidEmail = "enter the valid email"
    static let phoneNoMustBeEqualTo = "Phone No Must be Equal To 10 Number"
    static let  ook = "OK"
    //register constant
    static let firstNameMustBeAtLeastCharactersLong = "First Name must be at least 4 characters long."
    static let lastNameMustBeAtLeastCharactersLong = "Last Name must be at least 4 characters long."
    static let invalidEmailAddress = "Invalid Email Address"
    static let passwordMustBeAtLeastCharactersLong = "Password must be at least 8 characters long"
    static let confirmPasswordDoesNotMatchPassword = "Confirm Password does not match Password"
    static let pleaseSelectaGender = "Please select a Gender"
    static let invalidMobileNumber = "Invalid Mobile Number"
    static let agreeTermsAndCondition = "You must agree to the Terms and Conditions"
    static let numberAllowed = "0123456789"
    static let quantityMustBeBetweenAndContainOnlyNumbers = "Quantity must be between 1 to 7 and contain only numbers"
    static let allTextFilledMustBeFilled = "all Text Filled must be Filled"
    static let enterTheAddress = "Enter the address"
    static let enterTheLandmark = "Enter the landmark"
    static let enterTheCity = "Enter the City"
    static let enterTheState = "Enter the State"
    static let enterTheCountry = "Enter the Country"
    static let zipcodeShouldBeNumber = "Zipcode should be a number"
    
}
