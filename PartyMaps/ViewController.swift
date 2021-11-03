//
//  ViewController.swift
//  PartyMaps
//
//  Created by Berk Çohadar on 10/25/21.
//

import UIKit
import GoogleMaps
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    // https://developers.google.com/maps
    
    let locManager = CLLocationManager();
    @IBOutlet weak var showEventsButton: UIButton!
    @IBOutlet weak var googleMaps: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        locManager.delegate = self // so we can receive event calls
        locManager.requestWhenInUseAuthorization() // Asks for permit
        locManager.startUpdatingLocation() // starts location updates
        
        let GOOGLE_TOKEN = "AIzaSyAIkYiBEIVgR1uifZCL1AAxAZp5AOX2BYY"
        GMSServices.provideAPIKey(GOOGLE_TOKEN)
        
        // party_list
        guard let party_list_tableView = storyboard?.instantiateViewController(identifier: "party_list") as? EventsViewController else {
            return
        }
        


        view.addSubview(showEventsButton)
        view.bringSubviewToFront(showEventsButton)

    }
        
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }

        let coord = location.coordinate
        let camera = GMSCameraPosition.camera(withLatitude: coord.latitude, longitude: coord.longitude, zoom: 1.0)

        view.addSubview(googleMaps)
        /*
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: coord.latitude, longitude: coord.longitude)
        marker.map = mapView
         */
    }
}

