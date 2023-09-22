//
//  locationService.swift
//  Neostore
//
//  Created by Neosoft on 21/09/23.
//

import Foundation

class LocationService{
    func locationNearbyData(baseUrl:String ,locationString:String,radius:String,apiKey:String,type:String,complition: @escaping (Result<[String:Any],Error>)->Void ){
        guard var components = URLComponents(string: baseUrl) else { return }
        components.queryItems = [
            URLQueryItem(name: "location", value: locationString),
            URLQueryItem(name: "radius", value: radius),
            URLQueryItem(name: "type", value: type),
            URLQueryItem(name: "key", value: apiKey)
        ]
        guard let finalUrl = components.url else { return }
        
        let task = URLSession.shared.dataTask(with: finalUrl) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                complition(.failure(error))
                return
            }
            
            guard let data = data else {
                complition(.failure(error!))
                return
                
            }
            
            do {
                if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    complition(.success(jsonObject))
                }
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
                complition(.failure(error))
            }
        }
        task.resume()
    }
    
    
}

