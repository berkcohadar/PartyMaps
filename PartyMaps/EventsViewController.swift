//
//  EventsViewController.swift
//  PartyMaps
//
//  Created by Berk Çohadar on 10/26/21.
//

import UIKit
import GoogleMaps
import MapKit

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var mapView: MKMapView!
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mapView.setCenter(partyList[indexPath.row].coordinate, animated: true)
        
        let camera = MKMapCamera()
        camera.centerCoordinate = partyList[indexPath.row].coordinate
        camera.altitude = 2000000.0
        camera.heading = 60.0
    
        mapView.setCamera(camera, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if partyList.count == 0 {
            tableView.emptyScreen("No items yet! Press button to start.")
        } else {
            tableView.restore()
        }
        return partyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for:indexPath)
        cell.textLabel?.text = partyList[indexPath.row].title
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            partyList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }
    }
 
    var partyList:[MKPointAnnotation] = [];
    @IBOutlet var TableList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableList.delegate = self
        TableList.dataSource = self
        

        let annotation = MKPointAnnotation()
        let centerCoordinate = CLLocationCoordinate2D(latitude: 40.5, longitude: -74)
        annotation.coordinate = centerCoordinate
        annotation.title = "New York"
        mapView.addAnnotation(annotation)
        
        let annotation2 = MKPointAnnotation()
        let centerCoordinate2 = CLLocationCoordinate2D(latitude: 26, longitude: -81)
        annotation2.coordinate = centerCoordinate2
        annotation2.title = "Florida"
        mapView.addAnnotation(annotation2)
        
        let annotation3 = MKPointAnnotation()
        let centerCoordinate3 = CLLocationCoordinate2D(latitude: 34, longitude: -118)
        annotation3.coordinate = centerCoordinate3
        annotation3.title = "California"
        mapView.addAnnotation(annotation3)
        
        partyList.append(annotation);
        partyList.append(annotation2);
        partyList.append(annotation3);
        
    }
}

extension UITableView {
    
    func emptyScreen(_ text: String) { // Will be called when there is no item in the "partyList" array.
        let emptyMessage = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        emptyMessage.text = text
        emptyMessage.textColor = .black
        emptyMessage.numberOfLines = 0
        emptyMessage.textAlignment = .center
        emptyMessage.font = UIFont(name: "System", size: 16)
        //emptyMessage.sizeToFit()

        // background change down
        self.backgroundView = emptyMessage
        self.separatorStyle = .none
    }

    func restore() { // Will be called when item is added.
        // background change down. reset to default (nil)
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
