//
//  BuilditWeatherTests.swift
//  BuilditWeatherTests
//
//  Created by Emrah Usar on 6/4/18.
//  Copyright © 2018 Emrah Usar. All rights reserved.
//

import XCTest
@testable import BuilditWeather

class BuilditWeatherTests: XCTestCase {
    
    let apiClient = APIClient()
    
    func testApiURL(){
        let request = APIClient.apiURL()
        XCTAssertNotNil(request)
    }
}
