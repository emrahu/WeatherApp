//
//  Weather.swift
//  BuilditWeather
//
//  Created by Emrah Usar on 6/4/18.
//  Copyright © 2018 Emrah Usar. All rights reserved.
//

import Foundation
import CoreLocation
struct Weather:Decodable {
    var city:City
    var forecast:[Forecast]
    
    enum CodingKeys:String, CodingKey {
        case city
        case forecast = "list"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        forecast = try values.decode([Forecast].self, forKey: Weather.CodingKeys.forecast)
        city = try values.decode(City.self, forKey: Weather.CodingKeys.city)
    }
}


struct ListWeather:Decodable{
    var main:String
    var description:String
    var icon:String
    
    enum CodingKeys:CodingKey {
        case main, description, icon
    }
    init(from decoder:Decoder) throws{
        let values = try decoder.container(keyedBy: CodingKeys.self)
        main = try values.decode(String.self, forKey: ListWeather.CodingKeys.main)
        description = try values.decode(String.self, forKey: ListWeather.CodingKeys.description)
        icon = try values.decode(String.self, forKey: ListWeather.CodingKeys.icon)
    }

    
}







