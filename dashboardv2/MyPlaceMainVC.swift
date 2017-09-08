//
//  MyPlaceMainVC.swift
//  dashboardKB
//
//  Created by Mohd Zulhilmi Mohd Zain on 31/03/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit
import GooglePlaces

class MyPlaceMainVC: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var coordinateLabel: UILabel!
    //@IBOutlet weak var navigationButton: UIButton!
    
    let locationManager: CLLocationManager = CLLocationManager()
    var location: CLLocation = CLLocation()
    
    //var resultController: GMSAutocompleteResultsViewController?
    var resultController: UITableViewController?
    var searchController: UISearchController!
    
    var locationMarker: GMSMarker!
    var polyline: GMSPolyline!
    
    var didFindMyLocation = false
    var destinationString: String!
    
    //Used for draw the polyline.
    var destCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var destLatitude: CLLocationDegrees = 0.0
    var destLongitude: CLLocationDegrees = 0.0
    
    var searchTextResult: String?
    var locationList = [Location]()
    var filteredLocationList = [Location]()
    
    var setZoom: Float = 16.0
    var setMinZoom: Float = 5.0
    var setMaxZoom: Float = 16.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.configureLocationManager()
        self.configuringSearchBar()
        self.configureMapView()
        //self.configureNavButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let homeImage = UIImage(named: "ic_home_white")
        let homeButton = UIBarButtonItem(image: homeImage, style: .done, target: self, action: #selector(dismissMyPlace))
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped(_:)))
        
        self.navigationItem.leftBarButtonItem = homeButton
        self.navigationItem.rightBarButtonItem = addButton
        
    }
    
    func dismissMyPlace() {
        
        dismiss(animated: true, completion: nil)
    }
    
    func configureMapView() {
        
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: setZoom)
        
        mapView.frame = CGRect(x: self.searchController.searchBar.frame.height, y: 0, width: self.view.bounds.width, height: self.view.frame.height)
        
        mapView.camera = camera
        mapView.setMinZoom(setMinZoom, maxZoom: setMaxZoom)
        mapView.delegate = self

        self.mapView.addSubview(coordinateLabel)
    }
    
    func configureLocationManager() {

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy =  kCLLocationAccuracyBest
    }
    
    func configuringSearchBar() {
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = DBColorSet.mySoalColor
        navigationController?.navigationBar.shadowImage = UIImage()
        
        //Setup for result tableView
        resultController = UITableViewController()
        resultController?.tableView.dataSource = self
        resultController?.tableView.delegate = self
        resultController?.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "filteredLocationCell")
        
        self.searchController = UISearchController(searchResultsController: resultController)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        let searchBar = searchController.searchBar
        searchBar.frame = CGRect(x: 0, y: 0, width: (self.navigationController?.navigationBar.bounds.width)!, height: searchBar.frame.height)
        searchBar.placeholder = "Search here..."
        searchBar.delegate = self
        searchBar.tintColor = UIColor.white
        searchBar.barStyle = .default
        searchBar.isTranslucent = false
        searchBar.barTintColor = DBColorSet.mySoalColor
        searchBar.backgroundImage = UIImage()
        
        view.addSubview(searchBar)
    }
    
    //MARK: - Navigate route.
    func navButtonTapped(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Navigation", message: "Anda pasti untuk pergi ke \(destinationString!)?", preferredStyle: .alert)
        
        let goButton = UIAlertAction(title: "Go!", style: .default) { (response) in
            
            let url = URL(string: "comgooglemaps://")!
            
            if UIApplication.shared.canOpenURL(url) {
                
                let directionsUrl = URL(string: "comgooglemaps://?saddr=&daddr=\(self.destCoordinate.latitude),\(self.destCoordinate.longitude)&directionsmode=driving")!
                
                if #available(iOS 10.0, *) {
                    UIApplication.shared.canOpenURL(directionsUrl)
                } else {
                    UIApplication.shared.openURL(directionsUrl)
                }
                
            } else {
                
                let errorMessage = "Unable to open a Google Maps app."
                self.alertController(errorMessage)
            }
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(goButton)
        alertController.addAction(cancelButton)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    func setupLocationMarker(_ coordinate: CLLocationCoordinate2D, title: String) {
        
        if locationMarker != nil {
            
            locationMarker.map = nil
        }
        
        locationMarker = GMSMarker(position: coordinate)
        locationMarker.title = title
        locationMarker.appearAnimation = .pop
        locationMarker.icon = GMSMarker.markerImage(with: UIColor.blue)
        locationMarker.opacity = 0.75
        
        locationMarker.map = mapView
        
        self.getPolylineRoute(from: (self.locationManager.location?.coordinate)!, to: coordinate)
    }
    
    //MARK: - Focus on the searched coordinate.
    
    func gotoCoordinate(_ latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: setZoom)
        
        print("latitude \(locationManager.location?.coordinate.latitude) longitude \(locationManager.location?.coordinate.longitude)")
        
        mapView.animate(to: camera)
    }
    
    //MARK: - Display the address of the current location.
    
    func reverseGeocodeCoordinate(coordinate: CLLocationCoordinate2D) {
        
        let geocoder = GMSGeocoder()
        
        geocoder.reverseGeocodeCoordinate(coordinate) { (response, error) in
            
            guard error == nil else { return }
            
            if let address = response?.firstResult() {
                
                let line = address.lines
                self.coordinateLabel.text = line?.joined(separator: "\n")
                let labelHeight = self.coordinateLabel.intrinsicContentSize.height
                
                self.mapView.padding = UIEdgeInsets(top: self.topLayoutGuide.length, left: 0,
                                                    bottom: labelHeight, right: 0)
                
                UIView.animate(withDuration: 0.25, animations: { 
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    func mapRepositioning(sender: UIButton) {
        
        print("Pressed..!")
        
        if let myLocation = locationManager.location?.coordinate {
            
            let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: myLocation.latitude, longitude: myLocation.longitude, zoom: setZoom)
            
            mapView.animate(to: camera)
            reverseGeocodeCoordinate(coordinate: myLocation)
        }
    }
    
    //MARK: - Func to open add controller.
    
    func addButtonTapped(_ sender: UIBarButtonItem) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let addViewController = storyboard.instantiateViewController(withIdentifier: "MyPlaceAddPlaceVC") as? MyPlaceAddPlaceVC {
            
            self.navigationController?.pushViewController(addViewController, animated: true)
        }
    }
    
    //MARK: - Draw polyline route between two places
    
    func getPolylineRoute(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D){
        
        print("\(source) \(destination)")
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let url = URL(string: "http://maps.googleapis.com/maps/api/directions/json?origin=\(source.latitude),\(source.longitude)&destination=\(destination.latitude),\(destination.longitude)&sensor=false&mode=driving")!
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }else{
                do {
                    if let json : [String:Any] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]{
                        
                        let status = json["status"] as! String
                        
                        if status == "OK" {
                            
                            let routes = (json["routes"] as! Array<NSDictionary>)[0]
                            let overview_polyline = routes["overview_polyline"] as? NSDictionary
                            let polyString = overview_polyline?["points"] as! String

                            //Call this method to draw path on map
                            DispatchQueue.main.async {
                                self.showPath(polyStr: polyString)
                            }
                        } else {
                            
                            let errorMessage = "Unable to create routes for desired destination!"
                            
                            self.alertController(errorMessage)
                        }
                    }
                    
                }catch{
                    print("error in JSONSerialization")
                }
            }
        })
        task.resume()
    }
    
    func showPath(polyStr :String){
        
        //Clear previous polyline before adding a new one.
        if polyline != nil {
            
            polyline.map = nil
        }
        
        let path = GMSPath(fromEncodedPath: polyStr)
        polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 3.0
        polyline.map = mapView // Your map view
        
        let bounds = GMSCoordinateBounds(coordinate: (self.locationManager.location?.coordinate)!, coordinate: self.destCoordinate)
        
        let cameraUpdate = GMSCameraUpdate.fit(bounds)
        mapView.animate(with: cameraUpdate)
        
    }
    
    func alertController(_ message: String) {
        
        let alertController = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        
        let okayButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(okayButton)
        
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - Fetch All Location Data from api.
    func fetchAllLocation() {
        
        let location = Location.init()
        
        location.fetchAllLocationTitle { [weak self] (result) in
            
            if let result = result {
                self?.locationList = result
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "searchResultSegue" {
            
            if let destionation = segue.destination as? MyPlaceSearchResultVC {
                
                destionation.searchResultText = searchTextResult
            }
        }
    }
}

extension MyPlaceMainVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
            
        case .authorizedWhenInUse:
            
            locationManager.startUpdatingLocation()
            
            mapView.settings.myLocationButton = true
            mapView.isMyLocationEnabled = true
            
            print("Authorized")
            break;
        case .authorizedAlways:
            
            locationManager.startUpdatingLocation()
            
            mapView.settings.myLocationButton = true
            mapView.isMyLocationEnabled = true
            
            print("Always used!")
            break;
        case .notDetermined:
            
            locationManager.requestWhenInUseAuthorization()
            
            print("Not determined")
            break;
        default:
            break;
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if let location = locations.last {
            
            let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: setZoom)
            mapView.camera = camera
            
            reverseGeocodeCoordinate(coordinate: location.coordinate)
            
            self.locationManager.stopUpdatingLocation()
            
            print("Location \(location)")
        }
    }
}

extension MyPlaceMainVC: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        //self.navigationButton.isHidden = false
        
        destinationString = marker.title
        
        return false
    }
    
    func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay) {
        //self.navigationButton.isHidden = true
    }
}

//MARK: - Update result extension, all the filter happened in here.
extension MyPlaceMainVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if DBWebServices.checkConnectionToDashboard(viewController: self) {
            
            if locationList.count == 0 {
                self.fetchAllLocation()
            }
        } else {
            print("No network connection..!")
        }
        
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        
        filteredLocationList = locationList.filter({( location : Location) -> Bool in
            return (location.title?.lowercased().contains(searchText.lowercased()))!
        })
        
        resultController?.tableView.reloadData()
    }
    
}

extension MyPlaceMainVC: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchTextResult = searchBar.text
        
        performSegue(withIdentifier: "searchResultSegue", sender: self)
    }
}

//MARK: - Result TableView Datasource and Delegates

extension MyPlaceMainVC: UITableViewDataSource, UITableViewDelegate {
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering() {
            return filteredLocationList.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "filteredLocationCell", for: indexPath)
        
        cell.textLabel?.text = filteredLocationList[indexPath.item].title
        cell.textLabel?.textColor = .darkGray
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let _ = tableView.cellForRow(at: indexPath) {
            
            searchTextResult = filteredLocationList[indexPath.item].title
            performSegue(withIdentifier: "searchResultSegue", sender: self)
        }
    }
}
























