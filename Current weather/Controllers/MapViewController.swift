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
    
    
    let mapViewModel = MapViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        setInitialRegion()
        
       

        
        let coordinateMSK = CLLocationCoordinate2D(latitude: 55.75222, longitude: 37.61556)
        
         let weatherAnnotation = WeatherAnnotation(coordinate: coordinateMSK, title: "wow Moscow", subtitle: "Hello")
        
        mapView.addAnnotation(weatherAnnotation)
//
//        let pointAnnotation = WeatherPinAnnotation()
//        pointAnnotation.title = "Moscow99"
//        pointAnnotation.subtitle = "RUSSIA"
//        pointAnnotation.coordinate = coordinateMSK
//        pointAnnotation.pinCustomImageName = "sun"
//
//        let pointView = MKPinAnnotationView(annotation: pointAnnotation, reuseIdentifier: "pin")
//
//        mapView.addAnnotation(pointView.annotation!)
        
//        let weatherAnnotation = WeatherPinAnnotation(title: "Moscow", subtitle: "Russia", coordinate: coordinateMSK)
        
//        print("mapView.addAnnotation")
//        mapView.addAnnotation(weatherAnnotation)
        
        ///////// -------------
        let bbox = mapViewModel.createBbox(mapRect: mapView.visibleMapRect, zoom: 10)
        mapViewModel.networkService.getCities(inBoundingBox: bbox) { [weak self] response in
            print("Response ", response)

            switch response {
            case .success(let weatherWrapper):
                print("Success, get weatherWrapper")
                self?.mapViewModel.weatherInformation = weatherWrapper.weatherInformation
            case .failure(let error):
                print("Failure: ", error)
            }
        }
    }
}


// MARK: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
//    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
//        print("New region: ", mapView.region)
//    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "weatherViewAnnotation"
        
//        let weatherView = WeatherView(frame: CGRect(x: 20, y: 20, width: 20, height: 20))
//        let image = getImage(with: weatherView)
//        weatherView.ivImage.image = image
//        weatherView.lTemperatureInfo.text = "MSK, 29"
        
        
        
        guard let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) else {
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView.image = UIImage(named: "sun")
            annotationView.canShowCallout = true
            print("HERE")
            return annotationView
        }
        
        annotationView.annotation = annotation
        
        return annotationView
    }
}

// TODO: - need delete this method before release
extension MapViewController {
    func setInitialRegion() {
        let initialLocation = CLLocation(latitude: 55.75222, longitude: 37.61556)
        let initialDistance: CLLocationDistance = 40000
        let initialRegion = MKCoordinateRegion(center: initialLocation.coordinate, latitudinalMeters: initialDistance, longitudinalMeters: initialDistance)
        mapView.setRegion(initialRegion, animated: true)
    }
    
    func getImage(with view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
}
