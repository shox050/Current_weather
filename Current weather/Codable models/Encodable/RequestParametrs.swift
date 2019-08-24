//
//  RequestParametrs.swift
//  Current weather
//
//  Created by Vladimir on 24/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation

struct RequestParameters: Encodable {
    let latitude: Double
    
    let longitude: Double
    
    let count: Int = 10
    
    let measurementType: String = "metric"
    
    
    private enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        
        case longitude = "lon"
        
        case count = "cnt"
        
        case measurementType = "units"
    }
}
