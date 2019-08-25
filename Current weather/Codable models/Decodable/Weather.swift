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
    let weatherInformation: [WeatherInformation]
    
    private enum CodingKeys: String, CodingKey {
        case cod
        case calculateTime = "calctime"
        case count = "cnt"
        case weatherInformation = "list"
    }
}

struct WeatherInformation: Decodable {
    let cityId: Int
    let name: String
    let weatherParameters: WeatherParameters
    let coordinate: Coordinate
    let weather: [Weather]
    
    private enum CodingKeys: String, CodingKey {
        case cityId = "id"
        case name
        case weatherParameters = "main"
        case coordinate = "coord"
        case weather
    }
}

struct Coordinate: Decodable {
    let longitude: Double
    let latitude: Double
    
    private enum CodingKeys: String, CodingKey {
        case longitude = "Lon"
        case latitude = "Lat"
    }
}

struct Weather: Decodable {
    let weatherConditionId: Int
    let weatherIcon: String
    
    private enum CodingKeys: String, CodingKey {
        case weatherConditionId = "id"
        case weatherIcon = "icon"
    }
}

struct WeatherParameters: Decodable {
    let temperature: Float

    private enum CodingKeys: String, CodingKey {
        case temperature = "temp"
    }
}
