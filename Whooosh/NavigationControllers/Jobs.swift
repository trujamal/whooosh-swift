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

    @IBOutlet weak var mapboxView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeMapBoxCompoenents()
        alertCameraAccessNeeded()
    }
    
    private func initializeMapBoxCompoenents() {
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        mapboxView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func alertCameraAccessNeeded() {
        let settingsAppURL = URL(string: UIApplication.openSettingsURLString)!
        
        let alert = UIAlertController(
            title: "Need Camera Access",
            message: "Camera access is required to make full use of this app.",
            preferredStyle: UIAlertController.Style.alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Allow Camera", style: .cancel, handler: { (alert) -> Void in
            UIApplication.shared.open(settingsAppURL, options: [:], completionHandler: nil)
        }))
        
        present(alert, animated: true, completion: nil)
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
        
    }

    private func enableMyAlwaysFeatures() {
        
    }

}

