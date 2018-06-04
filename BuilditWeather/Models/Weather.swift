//
//  Weather.swift
//  BuilditWeather
//
//  Created by Emrah Usar on 6/4/18.
//  Copyright © 2018 Emrah Usar. All rights reserved.
//

import Foundation
import CoreLocation
struct Weather:Codable {
    var city:City
    var forecast:[Forecast]
}

struct City:Codable {
    var id:Int
    var name: String
    var coordinates:String//(lat:Double, lng:Double)
    var country:String
    var population:Int
}

struct Forecast:Codable {
    var dateTime:Double
    var main:String
    var description:String
    var icon:String
    var temp:Float
    var temp_min:Float
    var temp_max:Float
    var pressure: Float
    var seaLevel:Float
    var groundLevel:Float
    var humidity:Float
    var windSpeed:Float
    var windDegree:Float
}
