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
    var date:String
    var time:String
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
        case time, date, list,main, weather, wind
        
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
    
//    static func ==(lhs:Forecast, rhs:Forecast) -> Bool{
//        return lhs.dateTime == rhs.dateTime
//    }
//
//    static func <(lhs:Forecast, rhs:Forecast) -> Bool{
//        return lhs.dateTime == rhs.dateTime
//    }
}

extension Forecast:Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dateTime = try values.decode(Date.self, forKey: .dateTime)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: dateTime)
        date = dateString
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "ha"
        let timeString = timeFormatter.string(from: dateTime)
        time = timeString
        
        
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
        try container.encode(date, forKey: .date)
        
        var main = container.nestedContainer(keyedBy: MainKeys.self, forKey: Forecast.CodingKeys.main)
        try main.encode(temperature, forKey: Forecast.MainKeys.temperature)
    }
}
