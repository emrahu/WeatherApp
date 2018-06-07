//
//  APIClient.swift
//  BuilditWeather
//
//  Created by Emrah Usar on 6/4/18.
//  Copyright © 2018 Emrah Usar. All rights reserved.
//

import Foundation
class APIClient {
    
    enum Result<Payload, Success, Failure>{
        case success(payload:Payload, result:Success)
        case failure(Failure?)
    }
    
    typealias GetWeather = Result<Weather?, Bool, String?>
    typealias GetWeatherCompletion = (_ result:GetWeather)->Void
    
    struct Constants {
        static let baseUrl = "api.openweathermap.org"
        static let weatherApi = "/data/2.5/forecast"
        static let city = "New York"
        static let isoCode = "US"
        static let units:Units = .imperial
        static let apiKey = "c061e2384cb63a49e9fe98b958012246"
        static let type = "accurate"
        
        enum Units:String {
            case metric = "metric"
            case imperial = "imperial"
        }
    }
    
    private static let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    
    
    class func apiURL() -> URLRequest?{
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = APIClient.Constants.baseUrl
        urlComponents.path = APIClient.Constants.weatherApi
        let cityQuery = URLQueryItem(name: "q", value: "\(APIClient.Constants.city),\(APIClient.Constants.isoCode)")
        let unitsQuery = URLQueryItem(name: "units", value: APIClient.Constants.units.rawValue)
        let apiKeyQuery = URLQueryItem(name: "appid", value: APIClient.Constants.apiKey)
        let typeQuery = URLQueryItem(name: "type", value: APIClient.Constants.type)
        urlComponents.queryItems = [cityQuery, unitsQuery, apiKeyQuery, typeQuery]
        
        guard let url = urlComponents.url else { return nil }
        
        let request = URLRequest(url: url)
        return request
    }
    
    class func fetch(request:URLRequest, completion:@escaping GetWeatherCompletion){
        let dataTask = defaultSession.dataTask(with: request) { (data, response, error) in
            guard let _ = response else {
                completion(.failure("Please check your internet connection. Server may be down."))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure("Invalid server response type."))
                return
            }
            
            let statusCode = httpResponse.statusCode
            guard statusCode == 200 else {
                completion(.failure("Invalid response code: \(statusCode)"))
                return
            }
            guard let data = data else {
                completion(.failure("Invalid response Data (empty)."))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
                let container = try decoder.singleValueContainer()
                let dateString = try container.decode(String.self)
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                formatter.locale = Locale(identifier: "en_US_POSIX")
                formatter.calendar = Calendar(identifier: .iso8601)
                formatter.timeZone = TimeZone(secondsFromGMT: 0)
                if let date = formatter.date(from: dateString) {
                    return date
                }
                
                throw DateError.invalidDate
            })
            do {
                let weather = try decoder.decode(Weather.self, from: data)
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                DispatchQueue.main.async {
                    completion(.success(payload:weather, result:true))
                }
                
                
            } catch DecodingError.keyNotFound(let key, let context){
                completion(.failure("Error: Key not found"))
                print(key, context)
            } catch DecodingError.typeMismatch(let type, let context){
                completion(.failure("Error: Type mismatch"))
                print(type, context)
            } catch DecodingError.valueNotFound(let type, let context){
                completion(.failure("Error: Value not found"))
                print(type, context)
            }
            catch (let error){
                completion(.failure("Error: \(error.localizedDescription)"))
            }
        }
        dataTask.resume()
    }
    
    class func fetchIcon(request:URLRequest, completion:@escaping (_ data:Data)->()){
        let dataTask = defaultSession.dataTask(with: request) { (data, response, error) in
            guard let _ = response else {
                print("Please check your internet connection. Server may be down.")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid server response type.")
                return
            }
            
            let statusCode = httpResponse.statusCode
            guard statusCode == 200 else {
                print("Invalid response code: \(statusCode)")
                return
            }
            guard let data = data else {
                print("Invalid response Data (empty).")
                return
            }
            completion(data)
            
        }
        dataTask.resume()
    }
}
