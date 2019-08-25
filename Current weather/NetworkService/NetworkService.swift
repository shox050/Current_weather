//
//  NetworkService.swift
//  Current weather
//
//  Created by Vladimir on 24/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation
import Alamofire
import MapKit

class NetworkService {
    
    private let executionQueue = DispatchQueue(label: "NetworkServiceQueue", qos: .background, attributes: .concurrent)
    
    private let dictionaryEncoder = DictionaryEncoder()
    
    
    private func request(_ endpoint: Endpoint,
                         method: HTTPMethod = .get,
                         parameters: [String:Any]?,
//                         encoding: ParameterEncoding = URLEncoding.default,
                         _ completion: @escaping (DataResponse<Data>) -> Void) {
        
        AF.request(endpoint,
                   method: method,
                   parameters: parameters)
            .validate()
            .responseData(queue: executionQueue) { response in
                
                print("Request ", response.request)
                print("Response ", response)
        }
    }
    
    func getCities(inBoundingBox coordinate: BoundingBoxCoordinate, _ completion: @escaping (Result<WeatherModel, Error>) -> Void) {
        
        let bboxCoordinate = "\(coordinate.bottomLeftAngel.longitude),\(coordinate.bottomLeftAngel.latitude),\(coordinate.rightTopAngel.longitude),\(coordinate.rightTopAngel.latitude),\(coordinate.zoom)"
        
        
        let requestParameters = RequestParameters(boundingBoxCoordinate: bboxCoordinate)
        let parametersEncoded = dictionaryEncoder.encode(entity: requestParameters)
        
        print("Parameters: ", parametersEncoded)

        request(.citiesInRectangleZone, parameters: parametersEncoded) { response in
            print(response)
        }
        
    }
}
