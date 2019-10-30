//
//  ViewController.swift
//  iBeacon
//
//  Created by Khalil on 26.10.2019.
//  Copyright © 2019 Khalil Akhmetsafin. All rights reserved.
//

import UIKit
import CoreLocation

class BeaconListViewController: UIViewController {

    @IBOutlet weak var collection: UICollectionView!
    
    let locationManager = CLLocationManager()
    let cellId = "cell"
    var beacons: [CLBeacon]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        
        collection.delegate = self
        collection.dataSource = self
        collection.register(
            UINib(nibName: "BeaconCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellId
        )
        
        BeaconApiService.getBeacons { (result) in
            if let beacons = result?.beacons {
                beacons.forEach({ (beacon) in
                    self.startMonitoringBeacon(uuid: beacon.uuid)
//                    if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
//                        if CLLocationManager.isRangingAvailable() {
//
//                        }
//                    }
                })
            }
        }
    }

    func startMonitoringBeacon(uuid: String) {
        print("startMonitoringBeacon")
        if let uuid = UUID(uuidString: uuid) {
            let beaconRegion = CLBeaconRegion(proximityUUID: uuid, identifier: "myBeacon")
            locationManager.startMonitoring(for: beaconRegion)
            locationManager.startRangingBeacons(in: beaconRegion)
        }
    }
    
    func updateUI() {
        collection.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToTableDetail" {
            let vc = segue.destination as! BeaconDetailTableViewController
            let indexPath = sender as! IndexPath
            vc.beacon = beacons?[indexPath.row]
        }
    }
}

extension BeaconListViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        print(beacons)
        print("didRangeBeacons")
        self.beacons = beacons.sorted(by: { (b1, b2) -> Bool in
            b1.rssi > b2.rssi
        })
        updateUI()
    }
    
    func locationManager(_ manager: CLLocationManager, rangingBeaconsDidFailFor region: CLBeaconRegion, withError error: Error) {
        print("Fail")
    }
}

extension BeaconListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return beacons?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BeaconCollectionViewCell
        if let beacon = beacons?[indexPath.item]{
            cell.setBeacon(beacon: beacon)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frameVC = collectionView.frame
        let widthCell = frameVC.width - 20
        let heightCell = CGFloat(110)
        
        return CGSize(width: widthCell , height: heightCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "goToTableDetail", sender: indexPath)
    }
    
}
