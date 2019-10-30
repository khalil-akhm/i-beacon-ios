//
//  BeaconCollectionViewCell.swift
//  iBeacon
//
//  Created by Khalil on 26.10.2019.
//  Copyright © 2019 Khalil Akhmetsafin. All rights reserved.
//

import UIKit
import CoreLocation

class BeaconCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var uuidLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var minorLabel: UILabel!
    @IBOutlet weak var rssiLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setBeacon(beacon: CLBeacon) {
        uuidLabel.text = beacon.proximityUUID.uuidString
        majorLabel.text = beacon.major.stringValue
        minorLabel.text = beacon.minor.stringValue
        rssiLabel.text = String(beacon.rssi)
//        distanceLabel.text = String(beacon.rss)
    }

}
