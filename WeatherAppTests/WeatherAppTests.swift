//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Emrah Usar on 6/6/18.
//  Copyright © 2018 Emrah Usar. All rights reserved.
//

import XCTest
@testable import WeatherApp
class WeatherAppTests: XCTestCase {
    
    let apiClient = APIClient()
    
    func testApiURL(){
        let request = APIClient.apiURL()
        XCTAssertNotNil(request)
    }
    
}
