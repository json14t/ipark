//
//  Location.swift
//  iPark
//
//  Created by Jason Campoverde on 12/2/16.
//  Copyright © 2016 Jason Campoverde. All rights reserved.
//

import Foundation
import CoreLocation

class Location {
    
    
    
    private var _latitude: Double?
    private var _longitude: Double?
    private var _meterExpiration: String?
    private var _streetCleaningTime: String?
    private var _timeStamp: String?
    
    
    // Getter and setter methods
    var latitude: Double {
        get {
            let latitude = _latitude ?? 40.764357
            return latitude
        }
        set {
            _latitude = newValue
        }
    }
    
    
    var longitude: Double {
        get {
            let longitude = _longitude ?? -73.923462
            return longitude
        }
        set {
            _longitude = newValue
        }
    }
    
    
    var meterExpiration: String {
        get {
            let meterExpiration = _meterExpiration ?? "There was no meter."
            return meterExpiration
        }
        set {
            _meterExpiration = newValue
        }
    }
    
    
    var streetCleaningTime: String {
        get {
            let streetCleaning = _streetCleaningTime ?? "There was no street cleaning."
            return streetCleaning
        }
        set {
            _streetCleaningTime = newValue
        }
    }
    
    var timeStamp: String {
        get{
            let timeStamp = _timeStamp ?? "No timestamp"
            return timeStamp
        }
        set{
            _timeStamp = newValue
        }
    }
    
}
