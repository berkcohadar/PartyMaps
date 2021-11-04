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
 
    var partyList:[GMSMarker] = [];
    @IBOutlet var TableList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableList.delegate = self
        TableList.dataSource = self
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        
        
        partyList.append(marker);
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
