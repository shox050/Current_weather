//
//  Constants.swift
//  Current weather
//
//  Created by Vladimir on 26/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation
import MapKit

struct Constants {
    struct Identifiers {
        static let weatherViewAnnotation = "weatherViewAnnotation"
        static let networkServiceQueue = "networkServiceQueue"
        static let weatherNibNamed = "WeatherView"
    }
    
    struct Coordinates {
        static let initialLocation = CLLocation(latitude: 55.75222, longitude: 37.61556)
        static let initialDistance: CLLocationDistance = 40000
    }
}
