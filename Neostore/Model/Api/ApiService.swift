
import Foundation

let Dev_Root_Point = "http://staging.php-dev.in:8844/trainingapp"
let Prod_Root_Point = ""

let contentValue_Post = "application/x-www-form-urlencoded"
//let contentValue_Get = "text/html; charset=UTF-8"
let contentKey = "Content-Type"

enum  NetworkEnvironment : String{
    case dev
    case prod
}

var networkEnvironment: NetworkEnvironment {
    return .dev
}

var baseURL : String{
    switch networkEnvironment {
    case .dev:
        return Dev_Root_Point
    case .prod:
        return Prod_Root_Point
    }
}

enum APIServices{
    case ImageFetching(imageurl : String)
    case userRegister(param: [String:Any])
    case userLogin(param: [String:Any])
    case fetchAccountDetails
    case productList(param : [String:Any])
    case productDetails(param: [String:Any])
    case productRating(param: [String:Any])
    case productAddToCart(param: [String:Any])
    case productEditCart(param: [String:Any])
    case productDeleteCart(param:[String:Any])
    case CartList
    case Order(param:[String:Any])
    case OrderList
    case OrderListDetials(param:[String:Any])
    
    var isImageFetching: Bool {
            if case .ImageFetching = self {
                return true
            }
            return false
        }
    
    var path: String{
        let apiDomain = "/api/"
        var urlPath:String = ""
        switch self{
        case .userRegister:
        urlPath = apiDomain + "users/register"
            return baseURL + urlPath
            
        case .userLogin:
        urlPath = apiDomain + "users/login"
            return baseURL + urlPath
            
        case .productList:
        urlPath = apiDomain + "products/getList"
            return baseURL + urlPath
            
        case .ImageFetching(imageurl: let imageurl):
            return imageurl
        
        case .productDetails:
        urlPath = apiDomain + "products/getDetail"
            return baseURL + urlPath
            
        case .productRating:
        urlPath = apiDomain + "products/setRating"
            return baseURL + urlPath
            
        case .productAddToCart:
        urlPath = apiDomain + "addToCart"
            return baseURL + urlPath
            
        case .fetchAccountDetails:
            urlPath = apiDomain + "users/getUserData"
                return baseURL + urlPath
            
        case .productEditCart:
            urlPath = apiDomain + "editCart"
                return baseURL + urlPath
        
        case .productDeleteCart:
            urlPath = apiDomain + "deleteCart"
                return baseURL + urlPath
            
        case .CartList:
            urlPath = apiDomain + "cart"
                return baseURL + urlPath
            
        case .Order:
            urlPath = apiDomain + "order"
                return baseURL + urlPath
            
        case .OrderList:
            urlPath = apiDomain + "orderList"
                return baseURL + urlPath
            
        case .OrderListDetials:
            urlPath = apiDomain + "orderDetail"
                return baseURL + urlPath
        }
        
        
    }
    
    var httpMethod: String {
        switch self {
        case .productList , .productDetails , .fetchAccountDetails, .CartList , .OrderList , .OrderListDetials :
            return "GET"
        default:
            return "POST"
        }
    }
    
    var param: [String:Any]? {
        switch self {
        case .userRegister(param: let param), .userLogin(let param) , .productList(param: let param), .productDetails(param: let param) , .productRating(param: let param),.productAddToCart(param: let param),.productEditCart(param: let param),.productDeleteCart(param: let param),.Order(param: let param),.OrderListDetials(let param):
            return param
        default:
            return nil
        }
    }
    
    var header: [String:String] {
        var dict:[String:String]
        dict = [contentKey:contentValue_Post,"access_token":UserDefaults.standard.string(forKey:"accessToken") ?? ""]
        return dict
    }
}
