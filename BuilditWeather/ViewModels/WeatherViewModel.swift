//
//  WeatherViewModel.swift
//  BuilditWeather
//
//  Created by Emrah Usar on 6/4/18.
//  Copyright © 2018 Emrah Usar. All rights reserved.
//

import Foundation

class WeatherViewModel {
    let title = "Weather"
    let cellIdentifier = "Hourly Cell"
//    let collectionViewidentifier = "HourlyCell"
    
    var weather: Weather!
    
     func forecast(completion:@escaping()->()){
        let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=New+York,US&units=imperial&appid=c061e2384cb63a49e9fe98b958012246")
        
        let request = URLRequest(url: url!)
        APIClient.fetch(request: request) { (data) in
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
                
                let container = try decoder.singleValueContainer()
                let dateString = try container.decode(String.self)
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                formatter.locale = Locale(identifier: "en_US_POSIX")
                formatter.timeZone = TimeZone(secondsFromGMT: 0)
                if let date = formatter.date(from: dateString) {
                    return date
                }
                
                throw DateError.invalidDate
            })
            do {
                
                let weather = try decoder.decode(Weather.self, from: data)
                
                
                _ = weather.forecast.sorted(by: {
                    $0.dateTime.compare($1.dateTime) == .orderedDescending
                })
                
                
                self.weather = weather
                self.orderForecast()
                completion()
                
            } catch DecodingError.keyNotFound(let key, let context){
                print("Key not found")
            print(key, context)
            } catch DecodingError.typeMismatch(let type, let context){
                print("Type mismatch")
                print(type, context)
            } catch DecodingError.valueNotFound(let type, let context){
                print("Value not found")
                print(type, context)
            }
            catch (let error){
                print("Error: \(error.localizedDescription)")
                print(error)
            }
            
        }
    }
    func orderForecast(){
        for forecast in self.weather.forecast {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            //let forecastDate = dateFormatter.string(from: forecast.dateTime)
            
            let currentDate:Date = forecast.dateTime
            var tempDate:Date = Date()
            
            if currentDate == tempDate {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "ha"
//                let hourlyForcast = [currentDate: HourlyForecast]
                
//                var fc = FC(date: currentDate, hourlyForecast: [Date(): HourlyForecast(forecast: forecast)])
//                print(fc)
//                print("============")
                tempDate = currentDate
            }
            
//            if forecastDate == forecast.dateTime
            
        }
        
    }
    
    func fetchWeatherImage(imageString:String, completion:@escaping(_ data: Data)->()){
        let urlString = "http://openweathermap.org/img/w/\(imageString).png"
        print(urlString)
        let url = URL(string: urlString)
        let urlRequest = URLRequest(url: url!)
        APIClient.fetch(request: urlRequest) { (data) in
            completion(data)
        }
    }
}
