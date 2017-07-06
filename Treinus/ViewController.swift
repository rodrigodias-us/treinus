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
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageText: UILabel!
    @IBOutlet weak var messageTryButton: Button!
    @IBOutlet weak var messageImage: UIImageView!
    @IBOutlet weak var messageActivityIndicator: UIActivityIndicatorView!
    
    let locationManager = CLLocationManager()
    var currentLocation:CLLocation?
    var places:[Place] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageImage.image = #imageLiteral(resourceName: "MapIcon")
        messageText.text = "Solicitando autorização"
        messageTryButton.isHidden = true
        messageActivityIndicator.startAnimating()
        
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            messageText.text = "Obtendo sua localização"
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestLocation()
        } else {
            messageImage.image = #imageLiteral(resourceName: "MapIcon")
            messageText.text = "Não foi possível obter sua localização"
            messageTryButton.isHidden = false
            messageActivityIndicator.stopAnimating()
        }
        
    }
    
    func getPlaces() {
        Places.shared.getPlacesByLocation(location: "\(currentLocation!.coordinate.latitude), \(currentLocation!.coordinate.longitude)", completion: { (result, error) in
            if var result = result {
                result.sort(by: { (e1, e2) -> Bool in
                    return e1.distanceOf(coordinate: self.currentLocation!) < e2.distanceOf(coordinate: self.currentLocation!)
                })
                self.places = result
                self.messageView.isHidden = true
                self.messageView.isUserInteractionEnabled = false
                self.tableView.reloadData()
            } else {
                self.messageImage.image = #imageLiteral(resourceName: "GymIcon")
                self.messageText.text = "Não encontramos academias próximo a sua localização."
                self.messageTryButton.isHidden = false
                self.messageActivityIndicator.stopAnimating()
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
            messageImage.image = #imageLiteral(resourceName: "GymIcon")
            messageText.text = "Encontrando academias próximo a você"
            messageTryButton.isHidden = true
            messageActivityIndicator.startAnimating()
            
            self.currentLocation = location
            getPlaces()
        } else {
            messageImage.image = #imageLiteral(resourceName: "MapIcon")
            messageText.text = "Não foi possível obter sua localização"
            messageTryButton.isHidden = false
            messageActivityIndicator.stopAnimating()
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
