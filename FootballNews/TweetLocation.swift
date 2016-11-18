//
//  TweetLocation.swift
//  FootballNews
//
//  Created by Kanti Krishnan on 11/13/16.
//  Copyright © 2016 Ram. All rights reserved.
//

import Foundation

class TweetLocation
{
    let latitude:String?
    let longitude:String?
    let geoCode:String?
    let geoCodeEndPoint : String = "https://api.twitter.com/1.1/geo/search.json?"
    let queryParam : String?
    let cityName :String?
    let stateName : String?
    let countryName : String?
    
    init(lat:String,long:String,geoCode:String,query:String)
    {
        self.latitude = lat
        self.longitude = long
        self.geoCode = geoCode
        self.queryParam = query
        self.cityName = "city"
        self.countryName = "country"
        self.stateName = "state"
    }
    
}
