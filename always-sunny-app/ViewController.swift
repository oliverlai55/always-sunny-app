//
//  ViewController.swift
//  always-sunny-app
//
//  Created by Wei lun Lai on 11/30/15.
//  Copyright © 2015 DigitalCrafts. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var forecast: [Weather]?
    var currentForecast:Weather?
    
//****  OUTLETS  ****//
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currentIcon: UIImageView!
    @IBOutlet weak var currentLow: UILabel!
    @IBOutlet weak var currentHigh: UILabel!
    @IBOutlet weak var currentDate: UILabel!
    @IBOutlet weak var currentCondition: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Populate the main view with the current weather from the WebService
        let webService = WebServiceManager()
        webService.fetchWeatherCurrent{ (newCurrWeather) -> Void in
            self.currentForecast = newCurrWeather
            print(newCurrWeather)
            self.currentIcon.image = UIImage(named: (self.currentForecast?.icon)!)
            self.currentCondition.text = self.currentForecast?.main
            self.currentHigh.text = "\((self.currentForecast?.max)!)"
            self.currentLow.text = "\((self.currentForecast?.min)!)"
            
        }
        webService.fetchWeatherForecast{ (newForecastWeather) -> Void in
            self.forecast = newForecastWeather
            print("reload!")
            self.tableView.reloadData()
        }
        // Get the current date
        // Format date by string
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMM dd"
        let dateString = formatter.stringFromDate(NSDate())
        self.currentDate.text = "Today, \(dateString)"
        
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let thisForecast: Weather = forecast?[indexPath.row] {
            print("i hve a weather cell")
            if let cell = tableView.dequeueReusableCellWithIdentifier("ForecastCellReuseID") as? ForecastTableViewCell {
                // Get the current date
                // Format date by string
                let formatter = NSDateFormatter()
                formatter.dateFormat = "EEEE"
                print("index path : \(indexPath.row).. double path: \(Double(indexPath.row))..\(NSDate())")
                let theDay = NSDate().dateByAddingTimeInterval((60*60*24*(Double(indexPath.row) + 1)) as NSTimeInterval)
                let dateString = formatter.stringFromDate(theDay)
                cell.weeklyDateLabel.text = "\(dateString)"
                cell.weeklyTempLowLabel.text = "\((thisForecast.min)!)"
                cell.weeklyTempHighLabel.text = "\((thisForecast.max)!)"
                cell.weeklyConditionLabel.text = thisForecast.main
                cell.weeklyIconLabel.image = UIImage(named: "\(thisForecast.icon!)-icon")
                return cell
            }
        }
        print("weather!!")
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if forecast != nil {
            print("im alive")
            return forecast!.count
        }
        return 5
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

