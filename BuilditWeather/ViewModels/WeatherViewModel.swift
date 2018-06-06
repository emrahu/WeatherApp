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
    let apiClient = APIClient()
    
    var weather: Weather!
    var days: [Day] = [Day]()
    
    func forecast(completion:@escaping(_ success:Bool,_ error:String?)->()){
        
        guard let request = APIClient.apiURL() else { return }
        
        APIClient.fetch(request: request) { [unowned self] (result) in
            
            switch result {
            case .success(let payload, let result):
                
                guard let payload = payload else{ return }
                self.weather = payload
                
                var tempDay = ""
                var currentDay = ""
                var nextDay = ""
                for forecast in self.weather.forecast {
                    
                    currentDay = forecast.date
                    nextDay = tempDay
                    
                    if currentDay != nextDay {
                        if self.days.count < 5 {
                            self.days.append(Day(forecast: forecast))
                        }
                        tempDay = currentDay
                    }
                }

                completion(result, nil)
                
            case .failure(let failure):
                completion(false,failure!)
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
        let url = URL(string: urlString)
        let urlRequest = URLRequest(url: url!)
        APIClient.fetchIcon(request: urlRequest) { (data) in
            completion(data)
        }
    }
}
