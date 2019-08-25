//
//  RequestParametrs.swift
//  Current weather
//
//  Created by Vladimir on 24/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation

struct RequestParameters: Encodable {
    var boundingBoxCoordinate: String
    var count: Int
    var measurementType: String
    
    let apiKey: String = NetworkServiceConfiguration.apiKey
    
    
    init(boundingBoxCoordinate: String, count: Int = 10, measurementType: String = "metric") {
        self.boundingBoxCoordinate = boundingBoxCoordinate
        self.count = count
        self.measurementType = measurementType
    }
    
    
    private enum CodingKeys: String, CodingKey {
        case boundingBoxCoordinate = "bbox"
        
        case count = "cnt"
        
        case measurementType = "units"
        
        case apiKey = "appid"
    }
}
