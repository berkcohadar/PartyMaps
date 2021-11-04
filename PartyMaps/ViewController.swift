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
        
        view.addSubview(showEventsButton)
        view.bringSubviewToFront(showEventsButton)
        view.addSubview(googleMaps)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EventsView" {
            let destination = segue.destination as! EventsViewController
            destination.mapView = googleMaps
            
        }
    }
}

