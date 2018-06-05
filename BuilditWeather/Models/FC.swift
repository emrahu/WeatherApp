//
//  FC.swift
//  BuilditWeather
//
//  Created by Emrah Usar on 6/5/18.
//  Copyright © 2018 Emrah Usar. All rights reserved.
//

import Foundation
struct FC {
    var date:Date
    var hourlyForecast:[Date: HourlyForecast]
}

struct HourlyForecast {
    var forecast: Forecast
}



