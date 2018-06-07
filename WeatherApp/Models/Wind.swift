//
//  Wind.swift
//  BuilditWeather
//
//  Created by Emrah Usar on 6/5/18.
//  Copyright © 2018 Emrah Usar. All rights reserved.
//

import Foundation
struct Wind:Codable {
    var speed:Float
    var degree:Float
    
    enum CodingKeys:String, CodingKey{
        case speed
        case degree = "deg"
    }

}
