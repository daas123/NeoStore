import GoogleMaps
import GooglePlaces
import UIKit
import CoreLocation

class StoreLocatorViewController: BaseViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    // MARK: FILE VARIABLE
    var previousLocation: CLLocation?
    let locationManager = CLLocationManager()
    let apiKey = apikeyConstant.googleMapApiKeyPaid
    var mapView: GMSMapView!
    let viewModel = StorelocationViewmodel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle(titleString: pageTitleConstant.Store_Locator)
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
        guard let userLocation = locations.first else { return }
        if var previousLocation = previousLocation {
            let distance = userLocation.distance(from: previousLocation)
            if distance >= 10 {
                findNearbyNatureLocations(userLocation: userLocation)
                previousLocation = userLocation
            }
        } else {
            findNearbyNatureLocations(userLocation: userLocation)
            previousLocation = userLocation
        }
    }
    
    static func loadFromNib()-> UIViewController{
        return StoreLocatorViewController(nibName: navigationVCConstant.storeLocatorVC , bundle: nil)
    }
    // MARK: API CALL
    func findNearbyNatureLocations(userLocation: CLLocation) {
        self.startActivityIndicator()
        let baseUrl = storelocatorConstant.baseUrl
        let locationString = "\(userLocation.coordinate.latitude),\(userLocation.coordinate.longitude)"
        let radius = storelocatorConstant.radius
        let type = storelocatorConstant.type
        
        viewModel.getLocationData(baseUrl: baseUrl, locationString: locationString, radius: radius, apiKey: apiKey, type: type){
            responce,data in
            DispatchQueue.main.async {
                self.stopActivityIndicator()
                if responce{
                    let camera = GMSCameraPosition.camera(withLatitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude, zoom: 15.0)
                    self.mapView.animate(to: camera)
                    if let results = self.viewModel.nearbyResturentData?[storelocatorConstant.results] as? [[String: Any]] {
                        for result in results {
                            if let name = result[storelocatorConstant.name] as? String,
                               let geometry = result[storelocatorConstant.geometry] as? [String: Any],
                               let location = geometry[storelocatorConstant.location] as? [String: Any],
                               let lat = location[storelocatorConstant.lat] as? Double,
                               let lng = location[storelocatorConstant.lng] as? Double,
                               let types = result[storelocatorConstant.types] as? [String] {
                                if types.contains(storelocatorConstant.restaurant) {
                                    let marker = GMSMarker()
                                    marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                                    marker.title = name
                                    marker.icon = UIImage(named: ImageConstants.red_pin)
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
                self.stopActivityIndicator()
            }
        }
        
    }
}
