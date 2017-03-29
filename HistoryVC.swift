//
//  HistoryVC.swift
//  iPark
//
//  Created by Jason Campoverde on 12/2/16.
//  Copyright © 2016 Jason Campoverde. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

class HistoryVC: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    let mapvc = MapVC()
    var locations = [Location]()
    let num = [1,2,3,4,5]
    var coordinates : [CLLocationCoordinate2D]? = nil
    let notesArray = UserDefaults.standard.array(forKey: Constants.Defaults.notes)
    
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        locations = mapvc.locations
        
        //let theCoordinate = latitudeArray[0]
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return (notesArray?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? CustomCell
        //cell?.configureCell(_location: mapvc.locations[indexPath.row])
        //cell?.longitudeLbl.text = "\(mapvc.locations[indexPath.row].longitude)"
        //cell?.longitudeLbl.text = "\(UserDefaults.standard.object(forKey: "longitude"))"
        //cell?.longitudeLbl.text = "\(latitudeArray?[indexPath.row])"
        cell?.latitudeLbl.text = "\(notesArray)"
        return cell!
    }
}
