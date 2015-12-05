//
//  WebServiceManager.swift
//  always-sunny-app
//
//  Created by Wei lun Lai on 12/2/15.
//  Copyright © 2015 DigitalCrafts. All rights reserved.
//

import Foundation

struct WebServiceManager {
    func fetchContacts(callback : ([Weather]) -> Void){
        
        let url = NSURL(string:
            "http://api.openweathermap.org/data/2.5/forecast/daily?q=Atlanta,ga&mode=json&cnt=5&units=imperial")
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
    
    
//    self.dt = newDt
//    self.min = newMin
//    self.max = newMax
//    self.pressure = newPressure
//    self.humidity = newHumidity
//    self.main = newMain
//    self.icon = newIcon
//    self.speed = newSpeed
    
    private func parseWeather(jsonDict : [String:AnyObject]) -> Weather {
            var newWeather = Weather()
            //Use newWeather here
        
        
        
        if let array = jsonDict["list"] as? [[String:AnyObject]] {
            for dict in array{
                newWeather.dt = dict["dt"] as? Int
                newWeather.humidity = dict["humidity"] as? Int
                
                if let temp = dict["temp"] as? [String:AnyObject]{
                    newWeather.min = temp["min"] as? Float
                }
                
            }
        }
        
//            newWeather.dt = jsonDict["phone"] as? String
//            if let addressDict = jsonDict["address"] as? [String : AnyObject]
//            {
//                //Use the properties of addressDict here
//                newWeather.streetAddress = addressDict["street"] as? String
//                newWeather.city = addressDict["city"] as? String
//                newWeather.zipCode = addressDict["zipcode"] as? String
//            }
//            if let fullName = jsonDict["name"] as? String {
//                //Use fullName here
//                let fullNameArray = fullName.componentsSeparatedByString(" ")
//                if fullNameArray.count > 1 {
//                    //Use fullNameArray here
//                    newContact.firstName = fullNameArray[0]
//                    newContact.lastName = fullNameArray[1]
//                }
//            }
//            
//            
//            
//            return newContact
//         
        return newWeather
    }
    
}
