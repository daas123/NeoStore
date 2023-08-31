
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
    case productList(param : [String:Any])
    case productDetails(param: [String:Any])
    
    
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
        }
        
    }
    
    var httpMethod: String {
        switch self {
        case .productList , .productDetails:
            return "GET"
        default:
            return "POST"
        }
    }
    
    var param: [String:Any]? {
        switch self {
        case .userRegister(param: let param), .userLogin(let param) , .productList(param: let param), .productDetails(param: let param):
            return param
        default:
            return nil
        }
    }
    
    var header: [String:String] {
        var dict:[String:String]
//        switch self{
//        case .userRegister , .userLogin:
            dict = [contentKey:contentValue_Post]
//        case .productList:
//            dict = [contentKey:contentValue_Get]
//        }
        return dict
    }
}
