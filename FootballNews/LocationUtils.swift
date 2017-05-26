//
//  LocationUtils.swift
//  FootballNews
//
//  Created by Kanti Krishnan on 12/20/16.
//  Copyright © 2016 Ram. All rights reserved.
//

import Foundation
import CoreLocation

class LocationUtils{
    func getLatAndLong(address: String)->String
    {
        var strCoordinates : String = ""
        CLGeocoder().geocodeAddressString(address, completionHandler: { (placemarks, error) in
            if error != nil {
                print(error!)
                return
            }
            if (placemarks?.count)! > 0 {
                let placemark = placemarks?[0]
                let location = placemark?.location
                let coordinate = location?.coordinate
                print("\nlat: \(coordinate!.latitude), long: \(coordinate!.longitude)")
                strCoordinates = "\(String(describing: coordinate?.latitude)),\(String(describing: coordinate?.longitude))"
            }
        })
        return strCoordinates
    }

}
