//
//  Wind.swift
//  BuilditWeather
//
//  Created by Emrah Usar on 6/5/18.
//  Copyright © 2018 Emrah Usar. All rights reserved.
//

import Foundation
struct Wind:Decodable {
    var speed:Float
    var degree:Float
    
    enum CodingKeys:String, CodingKey{
        case speed
        case degree = "deg"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        speed = try values.decode(Float.self, forKey: Wind.CodingKeys.speed)
        degree = try values.decode(Float.self, forKey: Wind.CodingKeys.degree)
    }
}
