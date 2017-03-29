//
//  ViewController.swift
//  iPark
//
//  Created by Jason Campoverde on 12/2/16.
//  Copyright © 2016 Jason Campoverde. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UITextFieldDelegate {
    
    //IBOutlets
    @IBOutlet weak var setPinButton: UIButton!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var centerOnCurrentLocationBtn: UIButton!
    @IBOutlet weak var centerOnPinBtn: UIButton!
    
    
    
    @IBAction func centerMapBtn(_ sender: Any) {
        print("CENTER MAP BUTTON PRESSED")
        let initialLocation = CLLocation(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
        centerMapOnLocation(location: initialLocation)
    }
    
   
    @IBAction func centerOnPinbtn(_ sender: Any) {
        print("CENTER ON PIN PRESSED")
        
        let initialLocation = CLLocation(latitude: defaults.object(forKey: "latitude") as! CLLocationDegrees, longitude: defaults.object(forKey: "longitude") as! CLLocationDegrees)
        centerMapOnLocation(location: initialLocation)
    }
    
    var notes = [String]()
    
    @IBOutlet weak var theMap: MKMapView!
    var annotation = MKPointAnnotation()
    var annotations = [MKPointAnnotation]()
    var locations = [Location]()
    var location = Location()
    var defaults = UserDefaults.standard
    let regionRadius: CLLocationDistance = 1000
    var locationManager = CLLocationManager()
    var currentLocation : CLLocation!
    var wasPinSet = false
    var wasButtonPressed = false
    var theString: String!
    
    var coordinates = [CLLocationCoordinate2D]()
    
    var userHeading = MKUserTrackingMode(rawValue: 2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Checks if 3D touch is available on device being used
        //if( traitCollection.forceTouchCapability == .available){
          //  registerForPreviewing(with: self as! UIViewControllerPreviewingDelegate, sourceView: view)
        //}
        
        
        
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        print("VIEW DID LOAD")
        theMap.delegate = self
        theMap.userTrackingMode = userHeading!
        theMap.showsUserLocation = true
        //noteLabel.isHidden = true
        //noteTextField.delegate = self
        
        
        
        
        
        print("\nUser heading description:\n\\n")
        
        
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        let initialLocation = CLLocation(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
        centerMapOnLocation(location: initialLocation)
        
        let defaultPin = defaults.bool(forKey: "wasPinSet")
        if defaultPin == true {
            setPinWithDefaults()
            print("default pin")
        }else{
            print("NO PIN SET MY DEFAULT")
        }
        
        //setPinWithDefaults()
        
        print("\nDO SOMETHING HERE IN VIEW DID LOADDDDDDDDDDDDDD!!!!!!!!!!!!!\n")
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        //self.theMap.addAnnotation(annotation)
        
        print("VIEW WILL APPEAR")
        //print("Longitude: \(GpsLocation.sharedInstance.latitude) Latitude: \(GpsLocation.sharedInstance.longitude)")
        
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        locationAuthStatus()
    }
    
    
    //Centers the map on the users current GPS location
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 0.5, regionRadius * 0.5)
        theMap.setRegion(coordinateRegion, animated: true)
    }
    
    //Sets the pin on the map when the user presses on the pin button
    @IBAction func setPin(_ sender: Any) {
        //blurEffect.isHidden = false
        var defaultWasButtonPressed = defaults.bool(forKey: "wasButtonPressed")
        
        if defaultWasButtonPressed{
            setPinAlert()
            print("Button was pressed \(wasButtonPressed)")
            wasButtonPressed = false
            self.setPinButton.setTitle("Remove Pin", for: .normal)
            defaults.set(wasButtonPressed, forKey: "wasButtonPressed")
            //self.annotation.title = "Address: \(self.defaults.value(forKey: "placemark")!)"

        }else{
            removePin()
            print("Button was pressed \(wasButtonPressed)")
            //presentAlert()
            wasButtonPressed = true
            defaults.set(wasButtonPressed, forKey: "wasButtonPressed")
        }
        
    }
    
    
    //Used to set a pin on the map using the users gps coordinates
    func setPin(){
       
    }
    
    
    
    //Used to display the saved pin upon launching app
    func setPinWithDefaults(){
        print("\nSET PIN WITH DEFAULTS CALLED\n")
        let converted = CLLocationCoordinate2D(latitude: defaults.object(forKey: "latitude") as! CLLocationDegrees, longitude: defaults.object(forKey: "longitude") as! CLLocationDegrees)
        self.annotation.coordinate = converted
        self.theMap.addAnnotation(annotation)
        self.locations.append(location)
        if let address = self.defaults.value(forKey: "placemark") {
            self.annotation.title = "\(address)"
        }
        
        
    }
    
    //Used to remove the pin from the map
    func removePin(){
//        self.theMap.removeAnnotation(annotation)
//        wasPinSet = false
//        defaults.set(wasPinSet, forKey: "wasPinSet")
//        print("\nPIN REMOVED!!!\n")
        presentAlert()
        
        //addressLbl.isHidden  = true
    }
    
    //Asks user for permission to use location
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            GpsLocation.sharedInstance.latitude = currentLocation.coordinate.latitude
            GpsLocation.sharedInstance.longitude = currentLocation.coordinate.longitude
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    
    func enterDetailsSegue(){
        
    }
    
    
    func getAddressFromCoordinates( coordinates: CLLocation) -> String{
        
        var addressString: String?
        CLGeocoder().reverseGeocodeLocation(coordinates, completionHandler: {(placemarks, error)->Void in
            if (error != nil)
            {
                print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                return
            }
            
            if (placemarks?.count)! > 0
            {
                let placemark = (placemarks?[0])! as CLPlacemark
                print("THIS IS THE ADDRESS called from original func \(placemark)")
                //print(placemark.value(forKey: "FormattedAddressLines") ?? "Returned nil")
            }
            else
            {
                print("Problem with the data received from geocoder")
            }
        })
        
        return addressString!
    }
    
    //
    func captureClosure( string: String)-> String{
        return string
    }
    
    
    //Shows alert controller
    func presentAlert(){
        // Alert here
        let alert = UIAlertController(title: "Attention", message: "Are you sure you want to remove pin?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Remove Pin", style: .default, handler: {action in
            self.theMap.removeAnnotation(self.annotation)
            self.wasPinSet = false
            self.defaults.set(self.wasPinSet, forKey: "wasPinSet")
            self.setPinButton.setTitle("Set Pin", for: .normal)
            //self.addressLbl.isHidden = true
            print("\nPIN REMOVED!!!\n")
        }))
        self.present(alert, animated: true, completion: nil)
        addressLbl.isHidden = true
        //noteTextField.isHidden = false
        
    }
    
    
    func setPinAlert(){
        let alert = UIAlertController(title: "Attention", message: "Would you like to add a note?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Add Pin", style: .default, handler: {action in
            //self.saveNote(note: self.noteTextField.text)
            print("Add note pressed")
            let coordinate = CLLocationCoordinate2D(latitude: GpsLocation.sharedInstance.latitude, longitude: GpsLocation.sharedInstance.longitude)
            self.annotation.coordinate = coordinate
            self.locations.append(self.location)
            //self.theMap.addAnnotation(annotation)
            print("\(coordinate)")
            self.defaults.setValue(coordinate.longitude, forKey: "longitude")
            self.defaults.setValue(coordinate.latitude, forKeyPath: "latitude")
            
            
            self.defaults.synchronize()
            
            print("\nTHIS IS THE COORDINATE ARRAY BEING PRINTED FROM WITHIN THE SETPIN FUNCTION \(self.coordinates)\n")
            
            let converted = CLLocationCoordinate2D(latitude: self.defaults.object(forKey: "latitude") as! CLLocationDegrees, longitude: self.defaults.object(forKey: "longitude") as! CLLocationDegrees)
            
            print("User defaults \(converted)")
            print(converted.latitude)
            print(converted.longitude)
            
            self.wasPinSet = true
            self.defaults.set(self.wasPinSet, forKey: "wasPinSet")
            
            //latitudeArray.append(coordinate)
            self.defaults.set(self.defaults.object(forKey: "latitude"), forKey: "latitudeArray")
            
            //print("Latitude array \(latitudeArray[0])")
            
            let addressLocation = CLLocation(latitude: self.defaults.object(forKey: "latitude") as! CLLocationDegrees, longitude: self.defaults.object(forKey: "longitude") as! CLLocationDegrees)
            //print("This is the addressLocation: \(addressLocation)")
            
            
            
            //print("This is the address \(getAddressFromCoordinates(coordinates: addressLocation))")
            let coordinates = CLLocation(latitude: self.defaults.object(forKey: "latitude") as! CLLocationDegrees, longitude: self.defaults.object(forKey: "longitude") as! CLLocationDegrees)
            
            
            CLGeocoder().reverseGeocodeLocation(coordinates, completionHandler: {(placemarks, error)  in
                if (error != nil)
                {
                    print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                    return
                }
                //var placemark = CLPlacemark(placemark: (placemarks?[0])!)
                if (placemarks?.count)! > 0
                {
                    let placemark = (placemarks?[0])! as CLPlacemark
                    //print("This is the placemark \(placemark)")
                    self.theString = ("\(placemark)")
                    //self.addressLbl.text = ("\(placemark.name!)\n \(placemark.postalCode!)")
                    self.defaults.set(placemark.name, forKey: "placemark")
                    self.addressLbl.backgroundColor = UIColor.white
                    self.annotation.title = ("\(placemark.name!)\n \(placemark.postalCode!)")
                    
                    //remove this soon
                    //self.addressLbl.isHidden = true
                    
                    //print(placemark.value(forKey: "FormattedAddressLines") ?? "Returned nil")
                }
                else
                {
                    print("Problem with the data received from geocoder")
                }
                
                
            })
            
            print("This is the address: \(self.defaults.value(forKey: "placemark"))")
            print("This is the address string \(self.theString)")
            self.theMap.addAnnotation(self.annotation)
            
            
        }))
        self.present(alert, animated: true, completion: nil)
        //noteTextField.isHidden = true
        //addressLbl.text = noteTextField.text
        addressLbl.isHidden = false
        
    }
//    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
//        theMap.userTrackingMode = userHeading!
//        theMap.isRotateEnabled = false
//    }
    
    
    func saveNote(note: String?){
        if let note = note {
            notes.append(note)
            UserDefaults.standard.set(notes, forKey: Constants.Defaults.notes)
            defaults.synchronize()
            print("Note: \(note) saved!!")
            
        }
    }
    
    
    static func coordinatesToAdd(){
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}


