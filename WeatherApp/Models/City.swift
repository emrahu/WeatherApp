//
//  City.swift
//  BuilditWeather
//
//  Created by Emrah Usar on 6/5/18.
//  Copyright © 2018 Emrah Usar. All rights reserved.
//

import Foundation
struct City:Codable {
    var id:Int
    var name: String
    var coord:Coordinate
    var country:String
}
