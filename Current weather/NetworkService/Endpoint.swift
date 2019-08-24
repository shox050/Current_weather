//
//  Endpoint.swift
//  Current weather
//
//  Created by Vladimir on 24/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation
import Alamofire

enum Endpoint: URLRequestConvertible {
    
    
    
    func asURLRequest() throws -> URLRequest {
        <#code#>
    }
}




// MARK: - URLConvertible
extension Endpoint: URLConvertible {
    func asURL() throws -> URL {
        return try asURLRequest().url!
    }
}
