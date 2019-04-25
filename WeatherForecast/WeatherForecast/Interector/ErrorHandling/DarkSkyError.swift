//
//  DarkSkyError.swift
//  WeatherForecast
//
//  Created by Fahad on 25/4/19.
//  Copyright © 2019 Fahad. All rights reserved.
//

import Foundation

enum DarkskyError: Error{
    
    case requestFailed
    case responseUnsuccessful
    case invalidData
    case jsonConversionFailure
    case invalidURL
    case jsonParsingFailure
    
}
