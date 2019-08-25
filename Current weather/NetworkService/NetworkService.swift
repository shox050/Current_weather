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
                
                completion(response)
        }
    }
    
    func getCities(inBoundingBox coordinate: BoundingBoxCoordinate, _ completion: @escaping (Result<WeatherWrapper, Error>) -> Void) {
        
        let bboxCoordinate = "\(coordinate.bottomLeftAngle.longitude),\(coordinate.bottomLeftAngle.latitude),\(coordinate.bottomLeftAngle.longitude),\(coordinate.topRightAngle.latitude),\(coordinate.zoom)"
        
        
        let requestParameters = RequestParameters(boundingBoxCoordinate: bboxCoordinate)
        let parametersEncoded = dictionaryEncoder.encode(entity: requestParameters)
        
        print("Parameters: ", parametersEncoded)

        request(.citiesInRectangleZone, parameters: parametersEncoded) { response in
            print(response)
            
            guard let responseData = response.data else {
                print("Response have error: ", response.error)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let weatherWrapper = try jsonDecoder.decode(WeatherWrapper.self, from: responseData)
                print("weatherWrapper decode: ", weatherWrapper)
                completion(.success(weatherWrapper))
            } catch let error {
                print("Error decode: ", error)
                completion(.failure(error))
            }
        }
        
    }
}
