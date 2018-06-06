//
//  Constants.swift
//  BuilditWeather
//
//  Created by Emrah Usar on 6/6/18.
//  Copyright © 2018 Emrah Usar. All rights reserved.
//

import Foundation


class Constants {
    static let shared = Constants()
    struct API {
        static let baseUrl = "https://api.openweathermap.org"
        static let weatherApi = "/data/2.5/forecast"
        static let city = "New+York"
        static let isoCode = "US"
        static let apiKey = "c061e2384cb63a49e9fe98b958012246"
    }
}
