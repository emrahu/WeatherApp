//
//  Coordinate.swift
//  BuilditWeather
//
//  Created by Emrah Usar on 6/5/18.
//  Copyright © 2018 Emrah Usar. All rights reserved.
//

import Foundation
struct Coordinate:Codable {
    var latitude:Double
    var longitude:Double
    
    enum CodingKeys:String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
    }
}
enum DateError:String, Error {
    case invalidDate
}
