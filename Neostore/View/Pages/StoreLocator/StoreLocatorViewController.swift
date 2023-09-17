

import GoogleMaps
import GooglePlaces
import UIKit
import CoreLocation

class StoreLocatorViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {

    let locationManager = CLLocationManager()
    let apiKey = "AIzaSyDu8Jcaz3rWu-e9I8xP2y2hSWnXYnW6IfY" // Replace with your actual API key
    var mapView: GMSMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        // for removing back button title
        let backButton = UIBarButtonItem()
        backButton.title = "" // Set an empty title
        navigationItem.backBarButtonItem = backButton
        title = "Near By Store"
        // navigation bar back image
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "chevron.left")
        
        // navigation bar back text
        navigationController?.navigationBar.backItem?.title = ""
        
        // navigation bar items color
        navigationController?.navigationBar.tintColor = UIColor.white
        // Initialize the map view
        let camera = GMSCameraPosition.camera(withLatitude: 0, longitude: 0, zoom: 15.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)

        // Constrain the map view
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        // Set the delegate for the map view
        mapView.delegate = self
        mapView.settings.myLocationButton = true

        // Enable the "My Location" button
        mapView.isMyLocationEnabled = true

        // Request location authorization and start updating location
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLocation = locations.first {
            // Make an API request to find nearby nature locations.
            findNearbyNatureLocations(userLocation: userLocation)
        }
    }

    func findNearbyNatureLocations(userLocation: CLLocation) {
        let baseUrl = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
        let locationString = "\(userLocation.coordinate.latitude),\(userLocation.coordinate.longitude)"
        let radius = "1000"  // 1 km
        let type = "restaurant"  // You can adjust this to your specific needs

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
                // Handle the error here
                return
            }

            guard let data = data else { return }

            do {
                if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    DispatchQueue.main.async {
                        // Handle the JSON data and update your UI as needed
//                        print(jsonObject)
                        let camera = GMSCameraPosition.camera(withLatitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude, zoom: 15.0)
                        self.mapView.animate(to: camera)

                        if let results = jsonObject["results"] as? [[String: Any]] {
                            for result in results {
                                if let name = result["name"] as? String,
                                   let geometry = result["geometry"] as? [String: Any],
                                   let location = geometry["location"] as? [String: Any],
                                   let lat = location["lat"] as? Double,
                                   let lng = location["lng"] as? Double,
                                   let types = result["types"] as? [String] {

                                    // Check if the place is a restaurant
                                    if types.contains("restaurant") {
                                        // Create a marker with a custom red pin icon for restaurants
                                        let marker = GMSMarker()
                                        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                                        marker.title = name
                                        marker.icon = UIImage(named: "red_pin") // Use your custom red pin image here
                                        marker.map = self.mapView
                                    } else {
                                        // Create a default marker for other types of places
                                        let marker = GMSMarker()
                                        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                                        marker.title = name
                                        marker.map = self.mapView
                                    }
                                }
                            }
                        }
                    }
                }
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        }

        task.resume()
    }
}








