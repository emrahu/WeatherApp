//
//  Forecast.swift
//  BuilditWeather
//
//  Created by Emrah Usar on 6/5/18.
//  Copyright © 2018 Emrah Usar. All rights reserved.
//

import Foundation

struct Forecast {
    var dateTime:Date
    var weather: [ListWeather]
    var temperature:Float
    var tempMin:Float
    var tempMax:Float
    var pressure: Float
    var seaLevel:Float
    var groundLevel:Float
    var humidity:Float
    var wind:Wind
    
    enum CodingKeys:String, CodingKey {
        case dateTime = "dt_txt"
        case list,main, weather, wind
        
    }
    enum MainKeys:String, CodingKey {
        case temperature = "temp"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case groundLevel = "grnd_level"
        case humidity
    }
    
    enum WindKeys:String, CodingKey {
        case windSpeed = "speed"
        case windDegree = "deg"
    }
}

extension Forecast:Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dateTime = try values.decode(Date.self, forKey: .dateTime)
        weather = try values.decode([ListWeather].self, forKey: Forecast.CodingKeys.weather)
        wind = try values.decode(Wind.self, forKey: .wind)
        
        let mainBlock = try values.nestedContainer(keyedBy: MainKeys.self, forKey: Forecast.CodingKeys.main)
        temperature = try mainBlock.decode(Float.self, forKey: Forecast.MainKeys.temperature)
        tempMin = try mainBlock.decode(Float.self, forKey: Forecast.MainKeys.tempMin)
        tempMax = try mainBlock.decode(Float.self, forKey: Forecast.MainKeys.tempMax)
        pressure = try mainBlock.decode(Float.self, forKey: Forecast.MainKeys.pressure)
        seaLevel = try mainBlock.decode(Float.self, forKey: Forecast.MainKeys.seaLevel)
        groundLevel = try mainBlock.decode(Float.self, forKey: Forecast.MainKeys.groundLevel)
        humidity = try mainBlock.decode(Float.self, forKey: Forecast.MainKeys.humidity)
    }
}
extension Forecast:Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(dateTime, forKey: .dateTime)
        
        var main = container.nestedContainer(keyedBy: MainKeys.self, forKey: Forecast.CodingKeys.main)
        try main.encode(temperature, forKey: Forecast.MainKeys.temperature)
    }
}
