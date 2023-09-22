import GoogleMaps
import GooglePlaces
import UIKit
import CoreLocation

class StoreLocatorViewController: BaseViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    // MARK: FILE VARIABLE
    let locationManager = CLLocationManager()
    let apiKey = apikeyConstant.googleMapApiKeyPaid
    var mapView: GMSMapView!
    let viewModel = StorelocationViewmodel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitalMapCamara()
        setupDeligate()
        activatingGpsButton()
        setlocationFirstTime()
    }
    
    func setInitalMapCamara(){
        let camera = GMSCameraPosition.camera(withLatitude: 0, longitude: 0, zoom: 15.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupDeligate(){
        mapView.delegate = self
        locationManager.delegate = self
    }
    
    func activatingGpsButton(){
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
    }
    
    func setlocationFirstTime(){
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLocation = locations.first {
            findNearbyNatureLocations(userLocation: userLocation)
        }
    }
    
    static func loadFromNib()-> UIViewController{
        return StoreLocatorViewController(nibName: "StoreLocatorViewController", bundle: nil)
    }
    
    func findNearbyNatureLocations(userLocation: CLLocation) {
        let baseUrl = storelocatorConstant.baseUrl
        let locationString = "\(userLocation.coordinate.latitude),\(userLocation.coordinate.longitude)"
        let radius = storelocatorConstant.radius
        let type = storelocatorConstant.type
        
        viewModel.getLocationData(baseUrl: baseUrl, locationString: locationString, radius: radius, apiKey: apiKey, type: type){
            responce,data in
            DispatchQueue.main.async {
                if responce{
                    let camera = GMSCameraPosition.camera(withLatitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude, zoom: 15.0)
                    self.mapView.animate(to: camera)
                    if let results = self.viewModel.nearbyResturentData?["results"] as? [[String: Any]] {
                        for result in results {
                            if let name = result["name"] as? String,
                               let geometry = result["geometry"] as? [String: Any],
                               let location = geometry["location"] as? [String: Any],
                               let lat = location["lat"] as? Double,
                               let lng = location["lng"] as? Double,
                               let types = result["types"] as? [String] {
                                if types.contains("restaurant") {
                                    let marker = GMSMarker()
                                    marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                                    marker.title = name
                                    marker.icon = UIImage(named: "red_pin")
                                    marker.map = self.mapView
                                } else {
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
        }
        
    }
}
