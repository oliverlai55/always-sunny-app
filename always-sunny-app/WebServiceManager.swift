//
//  WebServiceManager.swift
//  always-sunny-app
//
//  Created by Wei lun Lai on 12/2/15.
//  Copyright © 2015 DigitalCrafts. All rights reserved.
//

import Foundation

struct WebServiceManager {
    func fetchWeatherForecast(callback : ([Weather]) -> Void){
        
        let url = NSURL(string:
            "http://api.openweathermap.org/data/2.5/forecast/daily?q=Atlanta,ga&mode=json&cnt=5&units=imperial=0b66f0f8e1b5e15a5b59581c421348aa")
        let request = NSURLRequest(URL: url!)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response,
            err in
            //Code goes here
            if err == nil {
                //Processing code goes here
                var weatherList = [Weather]()
                
                do {
                    if let jsonArray : [ [String : AnyObject] ] =
                        try NSJSONSerialization.JSONObjectWithData(data!, options:
                            NSJSONReadingOptions.AllowFragments) as? [ [String:AnyObject] ] {
                                for jsonDict in jsonArray {
                                    //Use jsonDict here
                                    let newWeather = self.parseWeather(jsonDict)
                                    weatherList.append(newWeather)
                                }
                                callback(weatherList)
                    }
                }
                catch {
                    //We got an error
                    callback([])
                }
            }
            else {
                //Got an error, so print it out
                print("Got an error: \(err)")
            }
        }
        task.resume()
    }
    
    
    private func parseWeather(jsonDict : [String:AnyObject]) -> Weather {
        var newWeather = Weather()
        //Use newWeather here
        
        if let array = jsonDict["list"] as? [AnyObject] {
            for dict in array{
                newWeather.dt = dict["dt"] as? Int
                newWeather.humidity = dict["humidity"] as? Int
                newWeather.pressure = dict["pressure"] as? Float
                newWeather.speed = dict["speed"] as? Float
                
                if let temp = dict["temp"] as? [String:AnyObject]{
                    newWeather.min = temp["min"] as? Float
                    newWeather.max = temp["max"] as? Float
                }
                if let temp = dict["weather"] as? [AnyObject]{
                    for weatherElement in temp{
                        
                        newWeather.main = weatherElement["main"] as? String
                        newWeather.icon = weatherElement["icon"] as? String
                    }
                }
            }
        }
        return newWeather
    }
    
    func fetchWeatherCurrent(callback : (Weather?) -> Void) {
        let url = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=Atlanta&units=imperial&APPID=0b66f0f8e1b5e15a5b59581c421348aa")
        
        let request = NSURLRequest(URL: url!)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, err in
            // (data, response, error) -> Void in
            if err == nil {
                //do something
                var weatherCurrent = Weather()
                
                do{
                    if let jsonObject : [String:AnyObject] =
                        try  NSJSONSerialization.JSONObjectWithData(data!, options:
                            NSJSONReadingOptions.AllowFragments) as? [String:AnyObject]{
                                
                                weatherCurrent = self.parseCurrentWeather(jsonObject)
                    }
                    callback(weatherCurrent)
                    
                }catch{
                    callback(Weather())
                    
                }
            }
            else{
                //if there is an error from the request
                print("error: \(err)")
            }
        }
        task.resume()
    }
    
    private func parseCurrentWeather(jsonObject : [String:AnyObject]) -> Weather{
        var newWeather = Weather()
        newWeather.dt = jsonObject["dt"] as? Int
        if let main = jsonObject["main"] as? [String:AnyObject]{
            newWeather.humidity = main["humidity"] as? Int
            newWeather.pressure = main["pressure"] as? Float
            newWeather.min = main["temp_min"] as? Float
            newWeather.max = main["temp_max"] as? Float
        }
        if let weather = jsonObject["weather"] as? [AnyObject] {
            for element in weather {
                newWeather.main = element["main"] as? String
                newWeather.icon = element["icon"] as? String
            }
            
        }
         return newWeather
    }
}
