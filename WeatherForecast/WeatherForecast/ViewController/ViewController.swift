//
//  ViewController.swift
//  WeatherForecast
//
//  Created by Fahad on 18/4/19.
//  Copyright © 2019 Fahad. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var coreLocationManager = CLLocationManager()
    
    @IBOutlet weak var weatherLocation: UILabel!
    @IBOutlet weak var descriptionSummery: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var icon: UILabel!
    
    var service = WeatherService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegating MainView Controller class as CLLocation class
        coreLocationManager.delegate = self
        coreLocationManager.requestWhenInUseAuthorization()
        coreLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        //coreLocationManager.startUpdatingLocation()
        coreLocationManager.requestLocation()
        
        //setting background color
        let backgroundLayer = CAGradientLayer()
        backgroundLayer.frame = view.bounds
        backgroundLayer.colors = [UIColor.red.cgColor,UIColor.purple.cgColor]
        self.view.layer.insertSublayer(backgroundLayer, at: 0)
        
        //making the fonts responsive
        let relativeFontConstant:CGFloat = 0.046
        weatherLocation.font = weatherLocation.font.withSize(self.view.frame.height * relativeFontConstant)
        descriptionSummery.font = descriptionSummery.font.withSize(self.view.frame.height * relativeFontConstant)
        icon.font = icon.font.withSize(self.view.frame.height * relativeFontConstant)

    }

    //notify the user about errors
    func handleError(message: String) {
        let alert = UIAlertController(title: "Error Loading Forecast", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //invoking method from the CLLocation manager every time the location is updated
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            let longitude = String(location.coordinate.longitude)
            let latitude  = String(location.coordinate.latitude)
            
            //get the weather data from service
            service.weatherForCoordinates(longitute: longitude, latitude: latitude) { (WeatherData, Error) in
                
                if let weatherdata = WeatherData{
                    self.descriptionSummery.text = weatherdata.summary
                    self.temperature.text = weatherdata.temperature
                    self.icon.text = weatherdata.icon
                }
                else if let _ = Error{
                    self.handleError(message: "Unable to load the forecast for your location.")
                }
            }
            //method for location name
            weatherLocationNameMethod(location: location)
        }
    }
    
    func weatherLocationNameMethod(location: CLLocation){
        
        //fetching location name by reversing Geocode
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            let locationName = placemarks?.first?.locality ?? "Unknown Location"
            self.weatherLocation.text = locationName
            
        }
    }

    //location manager failing method
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        handleError(message: "Unable to load location")
        
    }

    //event handler for refresing weather data
    @IBAction func refreshView(_ sender: Any) {
        
        coreLocationManager.requestLocation()
        
    }


}

