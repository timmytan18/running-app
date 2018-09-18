//
//  LocationViewController.swift
//  RunGenie
//
//  Created by Tim Tan on 8/9/17.
//  Copyright © 2017 Tim Tan. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import GoogleMaps
import GooglePlaces

class LocationViewController: UIViewController, CLLocationManagerDelegate {
    
    var location: CLLocation?
    let manager = CLLocationManager()
    
    var mapView: GMSMapView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        GMSServices.provideAPIKey("AIzaSyBi3kdvjC4VJ1gMejnNwEomde5YOHBPM1A")

        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.distanceFilter = 20
        manager.startUpdatingLocation()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        
        let currentLocation:CLLocationCoordinate2D = manager.location!.coordinate
        
        let camera = GMSCameraPosition.camera(withLatitude: (currentLocation.latitude), longitude: (currentLocation.longitude), zoom: 15)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        view = mapView
        
        let marker = GMSMarker(position: currentLocation)
        marker.title = "Me"
        marker.map = mapView
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
