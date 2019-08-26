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
    
    // Get weather information
//    func getCities(forMapRect mapRect: MKMapRect, zoom: Int, _ completion: @escaping ([WeatherAnnotation]) -> Void) {
//        let bbox = createBbox(by: mapRect, zoom: zoom)
//        networkService.getCities(inBoundingBox: bbox) { [weak self] response in
//            guard let this = self else { return }
//            switch response {
//            case .success(let weatherWrapper):
//                this.weatherInformations = weatherWrapper.weatherInformation
//                this.weatherAnnotations = this.convert(weatherInformations: this.weatherInformations)
//
//                completion(this.weatherAnnotations)
//
//            case .failure(let error):
//                print("Failure response in func getCities - MapViewModel ", error)
//            }
//        }
//    }
    
    func getCities(forMapRect mapRect: MKMapRect, zoom: Int, _ completion: @escaping ([WeatherAnnotation]) -> Void) {
        let bbox = createBbox(by: mapRect, zoom: zoom)
        networkService.getCities(inBoundingBox: bbox) { [weak self] response in
            guard let this = self else { return }
            switch response {
            case .success(let weatherWrapper):
                this.weatherInformations = weatherWrapper.weatherInformation
                this.weatherAnnotations = this.convert(weatherInformations: this.weatherInformations)
                
                completion(this.weatherAnnotations)
                
            case .failure(let error):
                print("Failure response in func getCities - MapViewModel ", error)
            }
        }
    }
    
    // Convert weatherInformation to annotation
    private func convert(weatherInformations: [WeatherInformation]) -> [WeatherAnnotation] {
        
        let annotations: [WeatherAnnotation] = weatherInformations.compactMap { weatherInformation in
            let temperature = String(Int(weatherInformation.weatherParameters.temperature))
            let title = "\(weatherInformation.name), \(temperature)"
            let subtitle = weatherInformation.weather.description
            let coordinate = CLLocationCoordinate2D(latitude: weatherInformation.coordinate.latitude, longitude: weatherInformation.coordinate.longitude)
            return WeatherAnnotation(coordinate: coordinate, title: title, subtitle: subtitle)
        }
        
        return annotations
    }
    
    private func createBbox(by mapRect: MKMapRect, zoom: Int) -> BoundingBoxCoordinate {
        let topRightAngle = getCoordinateFromMapRectanglePoint(mapRect.maxX, mapRect.origin.y) 
        let bottomLeftAngle = getCoordinateFromMapRectanglePoint(mapRect.origin.x, mapRect.maxY)
        
        return BoundingBoxCoordinate(bottomLeftAngle: bottomLeftAngle, topRightAngle: topRightAngle, zoom: zoom)
    }
    
    private func getCoordinateFromMapRectanglePoint(_ x: Double, _ y: Double) -> CLLocationCoordinate2D {
        let swMapPoint = MKMapPoint(x: x, y: y)
        
        return swMapPoint.coordinate
    }
    
    func getRadius(centralLocation: CLLocation) -> Double{
        let topCentralLat:Double = centralLocation.coordinate.latitude -  mapView.region.span.latitudeDelta/2
        let topCentralLocation = CLLocation(latitude: topCentralLat, longitude: centralLocation.coordinate.longitude)
        let radius = centralLocation.distance(from: topCentralLocation)
        return radius / 1000.0 // to convert radius to meters
    }
    
    
    func getR()
}
