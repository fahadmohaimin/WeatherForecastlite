//
//  WeatherData.swift
//  WeatherForecast
//
//  Created by Fahad on 19/4/19.
//  Copyright © 2019 Fahad. All rights reserved.
//

import Foundation
import SwiftyJSON

//data model for weather app
// data model with structure
//using swiftyJSON for to handle json data 

struct WeatherData {
    
    var summary: String
    var temperature: String
    var icon: String
   
    
    //weather data initializer
    init(jsonData: Any) {
        
        let data = JSON(jsonData)
        let currentData = data["currently"]
        
        self.temperature = "__"+" ºF"
        //structuring data according to json object
        if let temperatures = currentData["temperature"].float{
            self.temperature = String(format: "%.0f", temperatures)+" ºF"
        }
        
        self.summary = currentData["summary"].string ?? "__"
        self.icon = currentData["icon"].string ?? "__"
    }
 
    
}
