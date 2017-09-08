//
//  MyPlaceSearchedResultDetails.swift
//  dashboardv2
//
//  Created by Hainizam on 17/08/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import MapKit

class MyPlaceSearchedResultDetails: UITableViewController {
    
    var placeDetails: Place!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200.0
        
        let navigateImage = UIImage(named: "ic_navigation")!
        let navigateBarButton = UIBarButtonItem(image: navigateImage, style: .plain, target: self, action: #selector(navigateBarButtonTapped(_:)))
        
        navigationItem.rightBarButtonItem = navigateBarButton
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    //MARK: - Navigate to apple maps with given coordinates.
    func navigateBarButtonTapped(_ sender: UIBarButtonItem) {
        
        let latitude: CLLocationDegrees = Double(placeDetails.latitude!)!
        let longitude: CLLocationDegrees = Double(placeDetails.longitude!)!
        let placeName = placeDetails.title
//        
//        let regionDistance: CLLocationDistance = 1000;
//        let coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
//        
//        let options = [
//            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
//            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
//        ]
//        
//        let placeMark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
//        let mapItems = MKMapItem(placemark: placeMark)
//        mapItems.name = placeDetails.title
//        mapItems.openInMaps(launchOptions: options)
        
        
        //Get direction to desired place using google maps application.
        let alertController = UIAlertController(title: "Navigation", message: "Google maps diperlukan untuk memdapatkan haluan ke \(placeName!). Teruskan?", preferredStyle: .alert)
        
        let goButton = UIAlertAction(title: "Go!", style: .default) { (response) in
            
            
            
            if let url = URL(string: "comgooglemaps://"), UIApplication.shared.canOpenURL(url) {
                
                if let directionsUrl = URL(string: "comgooglemaps://?saddr=&daddr=\(latitude),\(longitude)&directionsmode=driving") {
                    
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.canOpenURL(directionsUrl)
                    } else {
                        UIApplication.shared.openURL(directionsUrl)
                    }
                }
            } else {
                
                if let url = URL(string: "itms-apps://itunes.apple.com/app/id/id585027354?mt=8"),
                    UIApplication.shared.canOpenURL(url)
                {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            }
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(goButton)
        alertController.addAction(cancelButton)
        
        present(alertController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = indexPath.row
        
        if index == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "titleDetailsCell", for: indexPath)
            
            let titleLabel = cell.viewWithTag(1) as! UILabel
            
            titleLabel.text = placeDetails.title
            
            return cell
        } else if index == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "contentDetailsCell", for: indexPath)
            
            
            let contentLabel = cell.viewWithTag(1) as! UILabel
            let dateLabel = cell.viewWithTag(2) as! UILabel
            
            contentLabel.text = placeDetails.content
            dateLabel.text = placeDetails.createdAt
            
            return cell
        } else {
            
            return UITableViewCell()
        }
    }
}












