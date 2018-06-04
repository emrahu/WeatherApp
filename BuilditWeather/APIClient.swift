//
//  APIClient.swift
//  BuilditWeather
//
//  Created by Emrah Usar on 6/4/18.
//  Copyright © 2018 Emrah Usar. All rights reserved.
//

import Foundation
class APIClient {
    let baseUrl = "https://api.openweathermap.org"
    let weatherApi = "/data/2.5/forecast"
    let city = "Timbuktu"
    let isoCode = "MLI"
    let apiKey = "c061e2384cb63a49e9fe98b958012246"
    
    private static let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    
    class func fetch(request:URLRequest, completionHandler:@escaping ([String:AnyObject])->()){
        let dataTask = defaultSession.dataTask(with: request) { (data, response, error) in
            
            guard let _ = response else {
//                errorHandler("Please check your internet connection. Server may be down.")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
//                errorHandler("Invalid server response type.")
                return
            }
            
            let statusCode = httpResponse.statusCode
            guard statusCode == 200 else {
//                errorHandler("Invalid response code: \(statusCode)")
                return
            }
            guard let data = data else {
//                errorHandler("Invalid response Data (empty).")
                return
            }
            
            do{
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:AnyObject] else {
                    return
                }
                
                DispatchQueue.main.async {
                    completionHandler(dictionary)
                }
                
            } catch (let error){
                print("Erro: \(error.localizedDescription)")
            }
        }
        dataTask.resume()
    }
    
}
