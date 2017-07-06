//
//  Places.swift
//  Treinus
//
//  Created by Rodrigo Dias on 05/07/17.
//  Copyright © 2017 Rodrigo Dias. All rights reserved.
//

import UIKit

class Places {
    static let shared = Places()
    
    let googleMapsKey = "AIzaSyAL7Bsb05zrFp6VL4XGkdn_cPYMvbkQyao"
    
    func getPlacesByLocation(location: String, completion: @escaping ((_ places: [Place]?,_ error: Error?) -> Void)) {        
        PlacesAPI.searchByLocation(location: location, radius: "50000", types: "gym", name: nil, key: googleMapsKey) { (response, error) in
            completion(response?.results, error)
        }
    }
}
