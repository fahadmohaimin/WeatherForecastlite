//
//  WeatherForecastTests.swift
//  WeatherForecastTests
//
//  Created by Fahad on 18/4/19.
//  Copyright © 2019 Fahad. All rights reserved.
//

import XCTest
@testable import WeatherForecast

class WeatherForecastTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testWeatherDataModel(){
        
        var weatherDatas: WeatherData!
        
        do {
            if let file = Bundle.main.url(forResource: "Dummy", withExtension: "json") {
                
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String: Any] {
                    weatherDatas = WeatherData(jsonData: object)
                }
            }
        } catch {
            XCTFail("Failed")
            print(error.localizedDescription)
        }

        XCTAssertEqual(weatherDatas.summary, "__")
        XCTAssertEqual(weatherDatas.temperature, "53 ºF")
        XCTAssertEqual(weatherDatas.icon, "__")
  
    }
    
    func testWeatherService(){

        let promise = expectation(description: "Status code: 200")
        var longitude = "0"
        var latitude  = "0"
        
        var weatherService = WeatherService()
        
        var dummyData : WeatherData!
        
        
        
        
        weatherService.weatherForCoordinates(longitute: longitude, latitude: latitude) { (WeatherData, error) in
            
            if let weatherdata = WeatherData{
               dummyData = weatherdata
               print(weatherdata)
               XCTAssertEqual(dummyData.temperature, "84 ºF")
               promise.fulfill()
            }
            else if let error = error{
                print("Error")
                XCTAssertNil(WeatherData)
                promise.fulfill()
            
            }
        }
       waitForExpectations(timeout: 4, handler: nil)
       
 
        }
    
    func testWeatherServiceError(){
        
        
        let promise = expectation(description: "Status code: 200")
        var longitude = "_"
        var latitude  = "_"
        
        var weatherService = WeatherService()
        
        var dummyData : WeatherData!
        
        weatherService.weatherForCoordinates(longitute: longitude, latitude: latitude) { (WeatherData, error) in
            
            if let weatherdata = WeatherData{
                dummyData = weatherdata
                print(weatherdata)
                XCTAssertEqual(dummyData.temperature, "84 ºF")
                promise.fulfill()
            }
            else if let error = error{
                print("Error")
                XCTAssertNil(WeatherData)
                promise.fulfill()
                
            }
        }
        waitForExpectations(timeout: 4, handler: nil)  
        
    }

    
   }
        
        
        

    
    

