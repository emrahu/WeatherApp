//
//  ModelsTests.swift
//  ModelsTests
//
//  Created by Emrah Usar on 6/6/18.
//  Copyright © 2018 Emrah Usar. All rights reserved.
//

import XCTest
@testable import WeatherApp

class ModelsTests: XCTestCase {
    
    var viewModel = WeatherViewModel()
    var forecast:Forecast!
    var wind:Wind!
    var coordinate:Coordinate!
    var city:City!
    var list:ListWeather!
    
    func testWind(){
        let speed:Float = 1.1
        let degree:Float = 5.5
        let wind = Wind(speed: speed, degree: degree)
        
        XCTAssertEqual(wind.speed, speed)
        XCTAssertEqual(wind.degree, degree)
        XCTAssertNotNil(wind.degree)
        XCTAssertNotNil(wind.speed)
    }
    
    func testCity(){
        coordinate = Coordinate(latitude: 54546.54, longitude: -45.6566)
        city = City(id: 5, name: "new york", coord: coordinate, country: "us")
        
        XCTAssertEqual(city.name, "new york")
        XCTAssertEqual(city.coord, coordinate)
        
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        coordinate = nil
        city = nil
        wind = nil
    }
    
    
    
    func testForecast(){
        let waitExpectation = expectation(description: "Waited for forecast")
        
        viewModel.forecast { (result, error) in
            XCTAssertTrue(result)
            waitExpectation.fulfill()
        }
        waitForExpectations(timeout: 60, handler: nil)
    }
    
}
