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
                         parameters: [String:Any]? = nil,
                         encoding: ParameterEncoding,
                         _ completion: @escaping (DataResponse<Data>) -> Void) {
        
        AF.request(endpoint,
                   method: method,
                   parameters: parameters,
                   encoding: encoding)
            .validate()
            .responseData(queue: executionQueue) { response in
                
                completion(response)
        }
    }
    
//    private func getCities(inRegion region: MKCoordinateRegion, _ completion: @escaping (Result)) {
//
//    }
}
