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
    
    enum CodingKeys:String, CodingKey {
        case city
        case forecast = "list"
    }
}

struct City:Codable {
    var id:Int
    var name: String
    var coord:Coordinate
    var country:String
    var population:Int
}

struct Forecast {
    var dateTime:Date
//    var weather: [ListWeather]
    var temperature:Float
    var tempMin:Float
    var tempMax:Float
    var pressure: Float
    var seaLevel:Float
    var groundLevel:Float
    var humidity:Float
    var windSpeed:Float
    var windDegree:Float
    
    enum CodingKeys:String, CodingKey {
        case dateTime = "dt_txt"
        case main
        case weather
        case wind
        
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
    
    enum WeatherKeys:String, CodingKey {
        case weather = "weather"
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
        /*
         * Main field decode
         */
        let mainBlock = try values.nestedContainer(keyedBy: MainKeys.self, forKey: Forecast.CodingKeys.main)
        temperature = try mainBlock.decode(Float.self, forKey: Forecast.MainKeys.temperature)
        tempMin = try mainBlock.decode(Float.self, forKey: Forecast.MainKeys.tempMin)
        tempMax = try mainBlock.decode(Float.self, forKey: Forecast.MainKeys.tempMax)
        pressure = try mainBlock.decode(Float.self, forKey: Forecast.MainKeys.pressure)
        seaLevel = try mainBlock.decode(Float.self, forKey: Forecast.MainKeys.seaLevel)
        groundLevel = try mainBlock.decode(Float.self, forKey: Forecast.MainKeys.groundLevel)
        humidity = try mainBlock.decode(Float.self, forKey: Forecast.MainKeys.humidity)
        
        
        /*
         * Weather block
         */
//        var weatherBlock = try values.nestedContainer(keyedBy: WeatherKeys.self, forKey: Forecast.CodingKeys.weather)
//        weather = try weatherBlock.decode([ListWeather].self, forKey: Forecast.WeatherKeys.weather)

        
        /*
         * Wind block
         */
        let wind = try values.nestedContainer(keyedBy: WindKeys.self, forKey: Forecast.CodingKeys.wind)
        windSpeed = try wind.decode(Float.self, forKey: Forecast.WindKeys.windSpeed)
        windDegree = try wind.decode(Float.self, forKey: Forecast.WindKeys.windDegree)
        
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

extension Forecast:Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(dateTime, forKey: .dateTime)
        
        var main = container.nestedContainer(keyedBy: MainKeys.self, forKey: Forecast.CodingKeys.main)
        try main.encode(temperature, forKey: Forecast.MainKeys.temperature)
    }
}


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


