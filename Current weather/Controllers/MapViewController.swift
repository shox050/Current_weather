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
        
        setInitialRegion()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didDragMap(_:)))
        panGesture.delegate = self
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(zoomChanged(_:)))
        pinchGesture.delegate = self
        
        mapView.addGestureRecognizer(panGesture)
        mapView.addGestureRecognizer(pinchGesture)
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let this = self else { return }
            this.mapViewModel.getCities(forMapView: this.mapView) { weatherAnnotations in
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
        
        let identifier = Constants.Identifiers.weatherViewAnnotation
        
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = false
        }
        
        return view
    }
}

// MARK: - UIGestureRecognizerDelegate
extension MapViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension MapViewController {
    private func setInitialRegion() {
        let initialLocation = Constants.Coordinates.initialLocation
        let initialDistance = Constants.Coordinates.initialDistance
        let initialRegion = MKCoordinateRegion(center: initialLocation.coordinate, latitudinalMeters: initialDistance, longitudinalMeters: initialDistance)
        mapView.setRegion(initialRegion, animated: true)
    }
    
    @objc private func didDragMap(_ sender: UIGestureRecognizer) {
        if sender.state == .ended {
            DispatchQueue.global(qos: .background).async { [weak self] in
                guard let this = self else { return }
                this.mapViewModel.getCities(forMapView: this.mapView) { weatherAnnotations in
                    this.mapView.addAnnotations(weatherAnnotations)
                    
                    DispatchQueue.main.sync {
                        this.mapView.showAnnotations(this.mapView.annotations, animated: true)
                    }
                }
            }
        } else {
            let annotations = mapView.annotations
            mapView.removeAnnotations(annotations)
        }
    }
    
    @objc private func zoomChanged(_ sender: UIGestureRecognizer) {
        if sender.state == .ended {
            DispatchQueue.global(qos: .background).async { [weak self] in
                guard let this = self else { return }
                this.mapViewModel.getCities(forMapView: this.mapView) { weatherAnnotations in
                    this.mapView.addAnnotations(weatherAnnotations)
                    
                    DispatchQueue.main.sync {
                        this.mapView.showAnnotations(this.mapView.annotations, animated: true)
                    }
                }
            }
        } else {
            let annotations = mapView.annotations
            mapView.removeAnnotations(annotations)
        }
    }
}
