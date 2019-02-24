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
import FFPopup
import ClusterKit

class jobController: UIViewController, CLLocationManagerDelegate, MGLMapViewDelegate {

    let locationManager = CLLocationManager()
    fileprivate var filtered = [String]()
    fileprivate var filterring = false
    var jobsArray = [ListObject]() //Array of dictionary

    @IBOutlet weak var listViewButton: UIBarButtonItem!
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var mapboxView: MGLMapView!
    @IBOutlet weak var augmentedControl: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeMapBoxCompoenents()
        clusterKitSetup()
        addSwipe()
        navigationInit()
        mapboxView.delegate = self
        
    }
    
    private func navigationInit() {
self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        title = "Jobs"
        let searchbarComponent = UISearchController(searchResultsController: nil)
        searchbarComponent.searchResultsUpdater = self as? UISearchResultsUpdating
        self.navigationItem.searchController = searchbarComponent
    }
    
    private func clusterKitSetup() {
        let algorithm = CKNonHierarchicalDistanceBasedAlgorithm()
        algorithm.cellSize = 50
//        mapboxView.clusterManager.algorithm = algorithm
//        mapboxView.clusterManager.marginFactor = 1
//
//        loadData()
    }
    
    
    
    func addSwipe() {
        let directions: [UISwipeGestureRecognizer.Direction] = [.right, .left, .up, .down]
        for direction in directions {
            let gesture = UISwipeGestureRecognizer(target: self, action: Selector(("handleSwipe:")))
            gesture.direction = direction
            self.view.addGestureRecognizer(gesture);
            
        }
    }
    
    @IBAction func openCamera(_ sender: Any) {
        performSegue(withIdentifier: "openARCameraComponent", sender: nil)
    }
    
    
    func handleSwipe(sender: UISwipeGestureRecognizer) {
        performSegue(withIdentifier: "openARCameraComponent", sender: self)
    }
    
    private func initializeMapBoxCompoenents() {
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        mapboxView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let locManager = CLLocationManager()
        var currentLocation: CLLocation!
        
        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){
            
            currentLocation = locManager.location
            // Centering the map
            mapboxView.setCenter(currentLocation.coordinate, zoomLevel: 7, direction: 0, animated: true)
            
        }

    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        // Wait for the map to load before initiating the first camera movement.
        
        // Create a camera that rotates around the same center point, rotating 180°.
        // `fromDistance:` is meters above mean sea level that an eye would have to be in order to see what the map view is showing.
        let camera = MGLMapCamera(lookingAtCenter: mapView.centerCoordinate, altitude: 10000, pitch: 15, heading: 180)
        
        // Animate the camera movement over 5 seconds.
        mapView.setCamera(camera, withDuration: 5, animationTimingFunction: CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut))
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


extension jobController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, !text.isEmpty {
            self.filterring = true
        }
        else {
            self.filterring = false
            self.filtered = [String]()
        }
        self.mapboxView.reloadInputViews()
    }
}
