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
    
    var weatherAnnotations: [WeatherAnnotation] = []
    private var weatherInformations: [WeatherInformation] = []
    
    let networkService = NetworkService()
    
    func getCities(forMapView mapView: MKMapView, _ completion: @escaping ([WeatherAnnotation]) -> Void) {
        
        let radius = getRadius(forMapView: mapView)
        
        let bbox = createBbox(by: mapView.visibleMapRect, radius: radius)
        networkService.getCities(inBoundingBox: bbox) { [weak self] response in
            guard let this = self else { return }
            switch response {
            case .success(let weatherWrapper):
                this.weatherInformations = weatherWrapper.weatherInformation
                this.weatherAnnotations = this.convert(weatherInformations: this.weatherInformations)
                
                completion(this.weatherAnnotations)
                
            case .failure(let error):
                print("Failure response ", error)
            }
        }
    }
    
    // Convert weatherInformation to annotation
    private func convert(weatherInformations: [WeatherInformation]) -> [WeatherAnnotation] {
        
        let annotations: [WeatherAnnotation] = weatherInformations.compactMap { weatherInformation in
            let temperature = String(Int(weatherInformation.weatherParameters.temperature))
            let subtitle = weatherInformation.weather.first?.description ?? ""
            let title = "\(weatherInformation.name),\n\(temperature) ℃"
            let coordinate = CLLocationCoordinate2D(latitude: weatherInformation.coordinate.latitude, longitude: weatherInformation.coordinate.longitude)
            return WeatherAnnotation(coordinate: coordinate, title: title, subtitle: subtitle)
        }
        
        return annotations
    }
    
    private func createBbox(by mapRect: MKMapRect, radius: Int) -> BoundingBoxCoordinate {
        let topRightAngle = getCoordinateFromMapRectanglePoint(mapRect.maxX, mapRect.origin.y) 
        let bottomLeftAngle = getCoordinateFromMapRectanglePoint(mapRect.origin.x, mapRect.maxY)
        
        return BoundingBoxCoordinate(bottomLeftAngle: bottomLeftAngle, topRightAngle: topRightAngle, radius: radius)
    }
    
    private func getCoordinateFromMapRectanglePoint(_ x: Double, _ y: Double) -> CLLocationCoordinate2D {
        let swMapPoint = MKMapPoint(x: x, y: y)
        
        return swMapPoint.coordinate
    }
    
    
    private func getRadius(forMapView mapView: MKMapView) -> Int {
        let centralLocation = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        let topCentralLatitude = centralLocation.coordinate.latitude - mapView.region.span.latitudeDelta / 2
        let topCentralLocation = CLLocation(latitude: topCentralLatitude, longitude: centralLocation.coordinate.longitude)
        let radius = centralLocation.distance(from: topCentralLocation)
        
        return Int(radius / 1000) // to convert radius to meters
    }
}
