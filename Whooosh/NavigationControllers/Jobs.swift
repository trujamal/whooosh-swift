//
//  FirstViewController.swift
//  Whooosh
//
//  Created by Jamal Rasool on 2/20/19.
//  Copyright © 2019 Jamal Rasool. All rights reserved.
//

import UIKit
import Mapbox
import CoreLocation

class jobController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()


    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var mapboxView: MGLMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeMapBoxCompoenents()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        title = "Jobs"
        let searchbarComponent = UISearchController(searchResultsController: nil)
        searchbarComponent.searchResultsUpdater = self as? UISearchResultsUpdating
        self.navigationItem.searchController = searchbarComponent
    }
    
    private func initializeMapBoxCompoenents() {
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        mapboxView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocationCoordinate2D = manager.location!.coordinate
        
        mapboxView.setCenter(CLLocationCoordinate2D(latitude: userLocation.latitude, longitude: userLocation.longitude), zoomLevel: 9, animated: true)
}
    

    
    func enableLocationServices() {
        locationManager.delegate = self
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // Request when-in-use authorization initially
            locationManager.requestWhenInUseAuthorization()
            break
            
        case .restricted, .denied:
            // Disable location features
            disableMyLocationBasedFeatures()
            break
            
        case .authorizedWhenInUse:
            // Enable basic location features
            enableMyWhenInUseFeatures()
            break
            
        case .authorizedAlways:
            // Enable any of your app's location features
            enableMyAlwaysFeatures()
            break
        }
    }
    
    private func disableMyLocationBasedFeatures() {
        
    }

    private func enableMyWhenInUseFeatures() {
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }

    private func enableMyAlwaysFeatures() {
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }

}
