//
//  GpsLocation.swift
//  iPark
//
//  Created by Jason Campoverde on 12/2/16.
//  Copyright © 2016 Jason Campoverde. All rights reserved.
//

import Foundation
import CoreLocation

class GpsLocation {
    static var sharedInstance = GpsLocation()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
}
