//
//  ViewController.swift
//  Current weather
//
//  Created by Vladimir on 24/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet private weak var mapView: MKMapView!
    
    let initialLocation = CLLocation(latitude: 55.75222, longitude: 37.61556)
    let initialDistance: CLLocationDistance = 40000
    

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        print(mapView.visibleMapRect)
        
        let initialRegion = MKCoordinateRegion(center: initialLocation.coordinate, latitudinalMeters: initialDistance, longitudinalMeters: initialDistance)
        
        mapView.setRegion(initialRegion, animated: true)
        
    }
}


// MARK: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
//    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
//        print("New region: ", mapView.region)
//    }
}

