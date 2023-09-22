import Foundation
class StorelocationViewmodel{
    var nearbyResturentData : [String:Any]?
    func getLocationData(baseUrl:String,locationString:String,radius:String,apiKey:String,type:String,complition: @escaping (Bool,[String:Any])->Void){
        LocationService().locationNearbyData(baseUrl:baseUrl, locationString: locationString, radius: radius, apiKey: apiKey, type: type){ [weak self]
            responce in
            switch responce{
            case .success(let data):
                self?.nearbyResturentData = data
                complition(true,data)
            case .failure(let error):
                print("there is some eror\(error)")
            }
        }
    }

}

