//
//  MapViewController.swift
//  Modig
//
//  Created by Nvard Martirosyan on 09.07.2018.
//  Copyright © 2018 iOS_Gyumri. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var lat = Double()
    var lng = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let latitude = lat
        let longitude = lng
        
        //Create annatation
        let annotation = MKPointAnnotation()
        //   annotation.title = searchBar.text
        annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        self.mapView.addAnnotation(annotation)
        
        //Zooming in on annotation
        let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(coordinate, span)
        self.mapView.setRegion(region, animated: true)
    }
    
}
