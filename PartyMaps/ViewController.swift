//
//  ViewController.swift
//  PartyMaps
//
//  Created by Berk Çohadar on 10/25/21.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController, CLLocationManagerDelegate {
    // https://developers.google.com/maps
    
    let locManager = CLLocationManager();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locManager.delegate = self // so we can receive event calls
        locManager.requestWhenInUseAuthorization() // Asks for permit
        locManager.startUpdatingLocation() // starts location updates
        
        let GOOGLE_TOKEN = "AIzaSyAIkYiBEIVgR1uifZCL1AAxAZp5AOX2BYY"
        GMSServices.provideAPIKey(GOOGLE_TOKEN)
        
        // party_list
        let floating_panel = FloatingPanelController() // The bottom scroll-up view = Floating Panel
        floating_panel.delegate = self // optional
        
        guard let party_list_tableView = storyboard?.instantiateViewController(identifier: "party_list") as? EventsViewController else {
            return
        }
        floating_panel.set(contentViewController: party_list_tableView)
        floating_panel.addPanel(toParent: self)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        let coord = location.coordinate
        let camera = GMSCameraPosition.camera(withLatitude: coord.latitude, longitude: coord.longitude, zoom: 1.0)
        let mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        view.addSubview(mapView)
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: coord.latitude, longitude: coord.longitude)
        marker.map = mapView
    }
}

