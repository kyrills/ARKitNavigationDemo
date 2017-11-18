//
//  Constants.swift
//  ARKitNavigationDemo
//
//  Created by Christopher Webb-Orenstein on 9/26/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation
import Alamofire

struct LocationConstants {
    static let metersPerRadianLat: Double = 6373000.0
    static let metersPerRadianLon: Double = 5602900.0
}

struct BaseURLs {
    static let tokenURL: String = "https://api-acc.schiphol.nl/swf/tokens/generateToken?f=json"
    static let gateURL: String = "https://api-acc.schiphol.nl/swf/rest/services/Schiphol/SWF_POI/MapServer/0/query?where=category%20%3D%2050%20and%20subcategory%20%3D%20%27Departing%20Gate%27&outFields=*&outSR=4326&token="
}

struct URLHeader {
    static let userDetailsHeader: HTTPHeaders = ["app_id" : "90b40430",
                                          "app_key":"c05b69b6017b6f169ca16e95dda0fee7",
                                          "Accept" : "application/json",
                                          "ResourceVersion" : "v1"]
}
