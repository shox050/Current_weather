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
    
    let constants = Constants()
    let mapViewModel = MapViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInitialRegion()
        
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let this = self else { return }
            
            this.mapViewModel.getCities(forMapRect: this.mapView.visibleMapRect, zoom: 10) { weatherAnnotations in
                this.mapView.addAnnotations(weatherAnnotations)
                
                DispatchQueue.main.sync {
                    this.mapView.showAnnotations(this.mapView.annotations, animated: true)
                }
                
            }
        }
    }
}


// MARK: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? WeatherAnnotation else { return nil }
        
        let identifier = constants.weatherViewIdentifier
        
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = false
//            view.calloutOffset = CGPoint(x: -5, y: 5)
//            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        return view
    }
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        
    }
    
    
}

extension MapViewController {
    private func setInitialRegion() {
        let initialLocation = CLLocation(latitude: 55.75222, longitude: 37.61556)
        let initialDistance: CLLocationDistance = 40000
        let initialRegion = MKCoordinateRegion(center: initialLocation.coordinate, latitudinalMeters: initialDistance, longitudinalMeters: initialDistance)
        mapView.setRegion(initialRegion, animated: true)
    }
    

    
//    private func getImage(with view: UIView) -> UIImage? {
//        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
//        defer { UIGraphicsEndImageContext() }
//        if let context = UIGraphicsGetCurrentContext() {
//            view.layer.render(in: context)
//            let image = UIGraphicsGetImageFromCurrentImageContext()
//            return image
//        }
//        return nil
//    }
}
