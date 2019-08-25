//
//  Weather.swift
//  Current weather
//
//  Created by Vladimir on 24/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation

struct WeatherWrapper: Decodable {
    let cod: Int
    let calculateTime: Float
    let count: Int
    let list: [WeatherModel]
}

struct WeatherModel: Decodable {
    let cityId: Int
    let coordinate: Coordinate
    let weather: Weather
    
    private enum CoddingKeys: String, CodingKey {
        case cityId = "id"
        case coordinate = "coord"
        case weather
    }
    
    struct Coordinate: Decodable {
        let longitude: Double
        let latitude: Double
        
        enum CodingKeys: String, CodingKey {
            case longitude = "lon"
            case latitude = "lat"
        }
    }
    
    struct Weather: Decodable {
        let weatherConditionId: Int
        let weatherParameters: String
        let conditionIcon: String
        
        enum CodingKeys: String, CodingKey {
            case weatherConditionId = "id"
            case weatherParameters = "main"
            case conditionIcon = "icon"
        }
    }
}
