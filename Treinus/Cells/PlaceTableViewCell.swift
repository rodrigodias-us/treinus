//
//  PlaceTableViewCell.swift
//  Treinus
//
//  Created by Rodrigo Dias on 05/07/17.
//  Copyright © 2017 Rodrigo Dias. All rights reserved.
//

import UIKit
import SDWebImage
import CoreLocation

class PlaceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    func setup(_ place: Place, coordinate: CLLocation) {
        nameLabel.text = place.name
        
        let distance = place.distanceOf(coordinate: coordinate)
        let distanceInKm = String(format: "%.01f km", arguments: [(distance / 1000.0)])
        
        distanceLabel.text = distanceInKm
        
        if let photo = place.photos?.first {
            let imageUrl = "https://maps.googleapis.com/maps/api/place/photo?photoreference=\(photo.photoReference!)&sensor=false&maxheight=\(photo.height!)&maxwidth=\(photo.width!)&key=AIzaSyAL7Bsb05zrFp6VL4XGkdn_cPYMvbkQyao"
            
            photoImageView.sd_setImage(with: URL(string:imageUrl))
        } else {
            photoImageView.sd_setImage(with: nil)
        }
    }
}
