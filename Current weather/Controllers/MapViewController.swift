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
    
    let networkService = NetworkService()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        print(mapView.visibleMapRect)
        
        let initialRegion = MKCoordinateRegion(center: initialLocation.coordinate, latitudinalMeters: initialDistance, longitudinalMeters: initialDistance)
        
        mapView.setRegion(initialRegion, animated: true)
        
        let mRect = mapView.visibleMapRect
        
        let getNECoordinate = getCoordinateFromMapRectanglePoint(mRect.maxX, mRect.origin.y)
        let getSWCoordinate = getCoordinateFromMapRectanglePoint(mRect.origin.x, mRect.maxY)
        
        let bottomLeft = getSWCoordinate
        let topRight = getNECoordinate
        
        print("bottomLeft.longitude ", bottomLeft.longitude)
        print("bottomLeft.latitude ", bottomLeft.latitude)
        print("topRight.longitude ", topRight.longitude)
        print("topRight.latitude ", topRight.latitude)
        
        let bbox = BoundingBoxCoordinate(bottomLeftAngel: bottomLeft, rightTopAngel: topRight, zoom: 10)

        networkService.getCities(inBoundingBox: bbox) { response in
            print("Response ", response)
        }
        
//
//        print(mapView.topLeftCoordinate())
//        print(mapView.bottomRightCoordinate())
        
        

    }
    
    func getCoordinateFromMapRectanglePoint(_ x: Double, _ y: Double) -> CLLocationCoordinate2D {
        let swMapPoint = MKMapPoint(x: x, y: y)
        return swMapPoint.coordinate
    }
    
}


// MARK: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
//    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
//        print("New region: ", mapView.region)
//    }
}

//extension MKMapView {
//    func topLeftCoordinate() -> CLLocationCoordinate2D {
//        return convert(.zero, toCoordinateFrom: self)
//    }
//
//    func bottomRightCoordinate() -> CLLocationCoordinate2D {
//        return convert(CGPoint(x: frame.width, y: frame.height), toCoordinateFrom: self)
//    }
//}
