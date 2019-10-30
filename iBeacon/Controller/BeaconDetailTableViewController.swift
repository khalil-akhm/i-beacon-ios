//
//  BeaconDetailTableViewController.swift
//  iBeacon
//
//  Created by Khalil on 28.10.2019.
//  Copyright © 2019 Khalil Akhmetsafin. All rights reserved.
//

import UIKit
import CoreLocation

class BeaconDetailTableViewController: UITableViewController {

    @IBOutlet weak var uuidLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var minorLabel: UILabel!
    @IBOutlet weak var rssiLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
     var beacon: CLBeacon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBeacon()
    }

    func setBeacon() {
        if let beacon = beacon{
            uuidLabel.text = beacon.proximityUUID.uuidString
            majorLabel.text = beacon.major.stringValue
            minorLabel.text = beacon.minor.stringValue
            rssiLabel.text = String(beacon.rssi)
            //            distanceLabel.text = String(beacon.rss)
        }
    }

}
