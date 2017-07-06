//
//  ViewController.swift
//  Treinus
//
//  Created by Rodrigo Dias on 05/07/17.
//  Copyright © 2017 Rodrigo Dias. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation:CLLocation?
    var places:[Place] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestLocation()
        }
    }
    
    func getPlaces() {
        Places.shared.getPlacesByLocation(location: "\(currentLocation!.coordinate.latitude), \(currentLocation!.coordinate.longitude)", completion: { (result, error) in
            if var result = result {
                result.sort(by: { (e1, e2) -> Bool in
                    return e1.distanceOf(coordinate: self.currentLocation!) < e2.distanceOf(coordinate: self.currentLocation!)
                })
                self.places = result
                self.tableView.reloadData()
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! MapViewController
        vc.place = places[(tableView.indexPathForSelectedRow?.row)!]
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.currentLocation = location
            getPlaces()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! PlaceTableViewCell
        
        cell.setup(places[indexPath.row], coordinate: currentLocation!)
        
        return cell
    }
}
