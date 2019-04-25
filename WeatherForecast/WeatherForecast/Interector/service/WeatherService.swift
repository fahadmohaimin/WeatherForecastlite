//
//  WeatherService.swift
//  WeatherForecast
//
//  Created by Fahad on 19/4/19.
//  Copyright © 2019 Fahad. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
//using Alamofire HTTP networking library build based on URLSession

public class WeatherService{
    
    //praimary url and key
    private  var topUrl = "https://api.darksky.net/forecast/"
    private  var key = "29948fbd2a89fb25babc62cbd1aba7d0"
    
    //fetching response from api call
    func weatherForCoordinates(longitute: String, latitude: String, completion: @escaping ( WeatherData?, DarkskyError?) -> () ){
        
        let url = topUrl + key + "/\(latitude),\(longitute)"
        
        Alamofire.request(url).responseJSON { (response) in
            
            if(response.response?.statusCode == 400){
                completion(nil, .invalidURL)
            }
            if(response.response?.statusCode != 400){
                switch response.result {
                case .success(let result):
                    completion(WeatherData(jsonData: result),nil)
                case .failure( _):
                    completion(nil, .responseUnsuccessful )
                }
            }
        }
    }
}
