//
//  BoundingBoxCoordinate.swift
//  Current weather
//
//  Created by Vladimir on 25/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation
import MapKit

struct BoundingBoxCoordinate {
    let bottomLeftAngle: CLLocationCoordinate2D
    let topRightAngle: CLLocationCoordinate2D
    let zoom: Int
}
