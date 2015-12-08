//
//  ViewController.swift
//  always-sunny-app
//
//  Created by Wei lun Lai on 11/30/15.
//  Copyright © 2015 DigitalCrafts. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBOutlet weak var tableView: UITableView!

    @IBOutlet var currentIcon: UIImageView!
    @IBOutlet var currentLow: UILabel!
    @IBOutlet var currentHigh: UILabel!
    @IBOutlet var currentDate: UILabel!
    @IBOutlet var currentCondition: UILabel!
}

