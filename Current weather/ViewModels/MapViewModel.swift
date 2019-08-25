//
//  MapViewModel.swift
//  Current weather
//
//  Created by Vladimir on 25/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation
import MapKit

class MapViewModel {
    
    var weatherInformation: [WeatherInformation] = []
    
    let networkService = NetworkService()
    

    func createBbox(mapRect: MKMapRect, zoom: Int) -> BoundingBoxCoordinate {
        let bottomLeftAngle = getCoordinateFromMapRectanglePoint(mapRect.maxX, mapRect.origin.y)
        let topRightAngle = getCoordinateFromMapRectanglePoint(mapRect.origin.x, mapRect.maxY)
        
        return BoundingBoxCoordinate(bottomLeftAngle: bottomLeftAngle, topRightAngle: topRightAngle, zoom: zoom)
    }
    
    func getCoordinateFromMapRectanglePoint(_ x: Double, _ y: Double) -> CLLocationCoordinate2D {
        let swMapPoint = MKMapPoint(x: x, y: y)
        
        return swMapPoint.coordinate
    }
}
