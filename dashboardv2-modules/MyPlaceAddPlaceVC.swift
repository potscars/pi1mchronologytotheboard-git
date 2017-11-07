//
//  MyPlaceAddPlaceTVC.swift
//  dashboardKB
//
//  Created by Mohd Zulhilmi Mohd Zain on 20/04/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import GoogleMaps
import DKImagePickerController

class MyPlaceAddPlaceVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var townTextField: UITextField!
    @IBOutlet weak var streetTextField: UITextField!
    @IBOutlet weak var postcodeTextField: UITextField!
    @IBOutlet weak var aboutTextview: UITextView!
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var addPhotoButton: UIButton!
    
    @IBOutlet weak var photoHolderCollectionView: PhotosHolderVC!
    
    var locationManager = CLLocationManager()
    
    var setZoom: Float = 16.0
    
    var images = [UIImage]()
    
    var menuTableViewController = UITableViewController()
    
    var categoryId: [Int]? = [Int]()
    var stateId: Int? = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        submitButton.addTarget(self, action: #selector(submitButtonTapped(_:)), for: .touchUpInside)
        
        self.configureNavBar()
        self.configureLocationManager()
        self.configureMapView()
        //self.addDoneButtonOnKeyboard()
        self.configureIBOutlet()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.scrollView.keyboardDismissMode = .onDrag
        
//        let lastItem = scrollView.subviews.last! as UIView
//        let lastOriginY = lastItem.frame.origin.y
//        let lastHeight = lastItem.frame.size.height
//        let totalHeight: CGFloat = lastOriginY + lastHeight
//        
//        scrollView.contentSize.height = totalHeight
        
        //REgister handler
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    func configureNavBar() {
        
        self.navigationController?.navigationBar.barTintColor = DBColorSet.mySoalColor
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationItem.backBarButtonItem?.title = nil
        title = "Add Place"
        
    }
    
    //MARK: - Configuration for the IBOutlet
    
    func configureIBOutlet() {
        
        nameTextField.autocapitalizationType = .words
        townTextField.autocapitalizationType = .words
        streetTextField.autocapitalizationType = .words
        
        aboutTextview.textColor = .lightGray
        aboutTextview.text = "About"
        aboutTextview.delegate = self
        
        addPhotoButton.addTarget(self, action: #selector(addPhotoButtonTapped(_:)), for: .touchUpInside)
        
        stateLabel.text = "Sila Pilih"
        stateLabel.isUserInteractionEnabled = true
        stateLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(stateTapped(_:))))
        
        categoryLabel.text = "Sila Pilih"
        categoryLabel.isUserInteractionEnabled = true
        categoryLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(categoryTapped(_:))))
    }
    
    //MARK: - Setup for the mapView
    
    func configureMapView() {
        
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: 0, longitude: 0, zoom: setZoom)
        mapView.camera = camera
        mapView.delegate = self
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
    }
    
    func configureLocationManager() {
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy =  kCLLocationAccuracyBest
    }
    
    //MARK: - POST LOCATION
    @objc func submitButtonTapped(_ sender: UIButton) {
        
        let loadingSpinner = LoadingSpinner.init(view: self.view, isNavBar: true)
        
        let alertController = AlertController()
        let warning = "Warning!"
        let urlString = "http://myplace.myapp.my/api/doLocation"
        
        let dbToken = UserDefaults.standard.object(forKey: "SuccessLoggerDashboardToken") as! String
        
        //Validation for each field.
        guard let name = nameTextField.text, !name.isEmpty else {
            alertController.alertController(self, title: warning, message: "Cannot let NAME field empty..!")
            return
        }
        
        guard let verifiedCatID = categoryId, verifiedCatID != [] else {
            alertController.alertController(self, title: warning, message: "Please select your CATEGORY..!")
            return
        }
        
        guard let about = aboutTextview.text, !about.isEmpty && about != "About" && aboutTextview.textColor != UIColor.lightGray else {
            alertController.alertController(self, title: warning, message: "Cannot let ABOUT field empty..!")
            return
        }
        
        guard let verifiedStateID = stateId, verifiedStateID != 0 else {
            alertController.alertController(self, title: warning, message: "Please select your STATE..!")
            return
        }
        
        guard let town = townTextField.text, !town.isEmpty else {
            alertController.alertController(self, title: warning, message: "Cannot let TOWN field empty..!")
            return
        }
        
        guard let street = streetTextField.text, !street.isEmpty else {
            alertController.alertController(self, title: warning, message: "Cannot let STREET field empty..!")
            return
        }
        
        guard let postcode = postcodeTextField.text, !postcode.isEmpty else {
            alertController.alertController(self, title: warning, message: "Cannot let POSTCODE field empty..!")
            return
        }
        
        guard let longitude = locationManager.location?.coordinate.longitude else {
            alertController.alertController(self, title: warning, message: "Cannot let name field empty..!")
            return
        }
        
        guard let latitude = locationManager.location?.coordinate.latitude else {
            alertController.alertController(self, title: warning, message: "Cannot let name field empty..!")
            return
        }
        
        loadingSpinner.setLoadingScreen()
        
        var categoryDictionary: [String : Bool]!
        
        for value in verifiedCatID {
            
            if categoryDictionary == nil {
                
                categoryDictionary = ["\(value)" : true]
            } else {
                categoryDictionary["\(value)"] = true
            }
        }
        
        //Add data into dictionary variable.
        let locationParameters : [String : Any] = ["location" : [ "place" : name,
                                                 "content" : about,
                                                 "city" : town,
                                                 "state" : verifiedStateID,
                                                 "street" : street,
                                                 "postcode" : postcode,
                                                 "longitude" : longitude,
                                                 "latitude" : latitude,
                                                 "category" : categoryDictionary
            ],
                                  "token" : dbToken
        ]
        
        print("\(locationParameters)")
        
        let networkProcessor = NetworkProcessor.init(urlString)
        
        if images.count > 0 {
            
            //Add location with image(s)
            
            print("Images uploaded")
            
            networkProcessor.uploadDataMultipart(locationParameters, images: images, completion: { (result, responses) in
                
                DispatchQueue.main.async {
                    
                    loadingSpinner.removeLoadingScreen()
                    
                    //print(result)
                    
                    guard responses == nil else {
                        alertController.alertController(self, title: "Warning!", message: responses!)
                        return
                    }
                    
                    guard let status = result?["status"] as? Int else { return }
                    
                    if status == 1 {
                        alertController.alertController(self, title: "Notice!", message: "Succesfully added!")
                    } else {
                        alertController.alertController(self, title: "Warning!", message: "Failed to add location")
                    }
                }
            })
        } else {
            
            //Add location without image(s)
            
            networkProcessor.postRequestJSONFromUrl(locationParameters) { (result, responses) in
                
                DispatchQueue.main.async {
                    
                    loadingSpinner.removeLoadingScreen()
                    
                    guard responses == nil else {
                        alertController.alertController(self, title: "Warning!", message: responses!)
                        return
                    }
                    
                    guard let status = result?["status"] as? Int else { return }
                    
                    if status == 1 {
                        alertController.alertController(self, title: "Notice!", message: "Succesfully added!")
                    } else {
                        alertController.alertController(self, title: "Warning!", message: "Failed to add location")
                    }
                }
            }
        }
    }
    
    func gotoCoordinate(_ latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: setZoom)
        
        //print("latitude \(locationManager.location?.coordinate.latitude) longitude \(locationManager.location?.coordinate.longitude)")
        
        mapView.animate(to: camera)
    }
    
    func reverseGeocodeCoordinate(coordinate: CLLocationCoordinate2D) {
        
        let geocoder = GMSGeocoder()
        
        geocoder.reverseGeocodeCoordinate(coordinate) { (response, error) in
            
            guard error == nil else { return }
            
            if let address = response?.firstResult() {
                
                self.townTextField.text = address.locality
                self.streetTextField.text = address.thoroughfare
                self.postcodeTextField.text = address.postalCode
                
                UIView.animate(withDuration: 0.25, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    //MARK: - Function to move up the field when keyboard appeared.
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        
        print("Keyboard showed!")
        
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height //- 30 //Set this value (30) according to your code as i have navigation tool bar for next and prev.
        self.scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        
        let contentInset: UIEdgeInsets = .zero
        self.scrollView.contentInset = contentInset
    }
    
    //MARK: - Function for button to take action
    
    @objc func addPhotoButtonTapped(_ sender: UIButton) {
        
        let picker = DKImagePickerController()
        picker.showsCancelButton = true
        
        picker.didSelectAssets = { assets in
            print("Done select..!")
            print(assets)
            
            self.images.removeAll()
            
            for asset in assets {
                
                asset.fetchImageWithSize(CGSize(width: 300, height: 300), completeBlock: { (image, info) in
                    
                    self.images.append(image!)
                })
            }
            
            if !assets.isEmpty {
                
                self.photoHolderCollectionView.images = self.images
                self.photoHolderCollectionView.reloadData()
            }

        }
        
        picker.didCancel = {
            print("Cancel..!")
        }
        
        self.present(picker, animated: true, completion: nil)
    }
    
    //MARK: - Popover view to show menu for state.
    
    @objc func stateTapped(_ sender: Any) {
        
        let vc = StatesMenuTVC()
        vc.modalPresentationStyle = .popover
        vc.delegates = self
        let popover = vc.popoverPresentationController!
        popover.delegate = self
        
        present(vc, animated: true, completion: nil)
    }
    
    @objc func categoryTapped(_ sender: Any) {
        
        let vc = CategoryMenuTVC()
        
        vc.modalPresentationStyle = .popover
        vc.delegates = self
        
        let popover = vc.popoverPresentationController!
        popover.delegate = self
        
        present(vc, animated: true, completion: nil)

    }
}

extension MyPlaceAddPlaceVC: CLLocationManagerDelegate {
    
    
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
        
        print("Location initiated")
        
        if let location = locations.last {
            
            let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: setZoom)
            mapView.camera = camera
            
            reverseGeocodeCoordinate(coordinate: location.coordinate)
            
            self.locationManager.stopUpdatingLocation()
            
            print("Location \(location)")
        }
    }
}


extension MyPlaceAddPlaceVC: GMSMapViewDelegate {
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        
        if let locationCoordinate = locationManager.location?.coordinate {
            
            mapView.animate(to: GMSCameraPosition.camera(withTarget: locationCoordinate, zoom: setZoom))
            reverseGeocodeCoordinate(coordinate: locationCoordinate)
            return true
        }
        
        return false
    }
}

extension MyPlaceAddPlaceVC: UIPopoverPresentationControllerDelegate, StatesMenuDelegates, CategoryMenuDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        
        return .fullScreen
    }
    
    func presentationController(_ controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        
        let navigationController = UINavigationController(rootViewController: controller.presentedViewController)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        navigationController.topViewController?.navigationItem.rightBarButtonItem = doneButton
        navigationController.navigationBar.barTintColor = DBColorSet.mySoalColor
        navigationController.navigationBar.tintColor = UIColor.white
        
        return navigationController
    }
    
    @objc func doneTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getStateName(_ state: (String, Int)?) {
        
        if let state = state, state.0 != "" {
            
            self.stateLabel.text = "\(state.0)"
            self.stateId = state.1
        } else {
            
            self.stateLabel.text = "Sila Pilih"
        }
    }
    
    func getCategory(_ category: [String: Int]?) {
        
        var categoryString = ""
        
        if let category = category {
            
            categoryId?.removeAll()
            
            for (key, value) in category {
                
                categoryString += "\(key), "
                categoryId?.append(value)
            }
            
            categoryString = String(categoryString.characters.dropLast(2))
            self.categoryLabel.text = "\(categoryString)"
            
        } else {
            
            self.categoryLabel.text = "Sila Pilih"
        }
    }
}


//MARK: - Textview Delegates

extension MyPlaceAddPlaceVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.text == "About" || (textView.textColor?.isEqual(UIColor.lightGray))! {
            
            textView.text.removeAll()
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text.isEmpty {
            
            textView.text = "About"
            textView.textColor = .lightGray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        textView.sizeToFit()
    }
}























