//
//  EventsViewController.swift
//  PartyMaps
//
//  Created by Berk Çohadar on 10/26/21.
//

import UIKit

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shoppingList.count == 0 {
            tableView.emptyScreen("No items yet! Press button to start.")
        } else {
            tableView.restore()
        }
        return shoppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for:indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            shoppingList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }
    }
 
    var shoppingList:[String] = ["NEW YORK","NEW JERSEY","CALIFORNIA"];
    @IBOutlet var TableList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableList.delegate = self
        TableList.dataSource = self
    }
}

extension UITableView {
    
    func emptyScreen(_ text: String) { // Will be called when there is no item in the "shoppingList" array.
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
