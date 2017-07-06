//
//  MapViewController.swift
//  Treinus
//
//  Created by Rodrigo Dias on 05/07/17.
//  Copyright © 2017 Rodrigo Dias. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var navigationBarItem: UINavigationItem!
    
    var place:Place? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let destinationCoordinate = CLLocationCoordinate2D(latitude: (place?.geometry?.location?.lat)!, longitude: (place?.geometry?.location?.lng)!)
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.coordinate = destinationCoordinate
        destinationAnnotation.title = place?.name
        
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = MKMapItem.forCurrentLocation()
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        
        navigationBarItem.title = "Carregando rota..."
        
        directions.calculate { (response, error) in
            guard let response = response else {
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
                
                return
            }
            
            let route = response.routes[0]
            self.mapView.addOverlays([route.polyline], level: .aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.mapView.setVisibleMapRect(rect, edgePadding: UIEdgeInsetsMake(50, 50, 50, 50), animated: true)
            
            self.navigationBarItem.title = "Mapa"
        }
        
        mapView.addAnnotation(destinationAnnotation)
    }
    
    @IBAction func close(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 4.0
        
        return renderer
    }
}
