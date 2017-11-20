//
//  SchipholWhenToBe.swift
//  ARKitNavigationDemo
//
//  Created by Ben Smith on 17/11/2017.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation
import Alamofire


class SchipholWhenToBeService {
    
    typealias getTimeToSchipholCompletion = (Bool, String?) -> Void
    
    public static func checkWhentoBeAtSChiphol(flightNumber: String, onCompletion: @escaping getTimeToSchipholCompletion) {
        let userDetailsParams: HTTPHeaders = ["app_id" : "7f76802a",
                                              "app_key":"07440013e362c9b76cf05a5d1f12dd4b",
                                              "Accept" : "application/json",
                                              "ResourceVersion" : "v1"]
        let url = "https://api-acc.schiphol.nl/when-to-be-at-schiphol/private/"+flightNumber+"?checkinRequired=true&debug=false"
        print(url)
        
        Alamofire.request(url,  headers: userDetailsParams).responseJSON { (response) in
            switch response.result {
            case .success(let jsonData):
                print(jsonData)
                if let dict = jsonData as? NSDictionary,
                    let recTime = dict["recommendedTimes"] as? NSDictionary {
                    if let securityTime = recTime["recommendedArrivalAtSecurity"] as? String {
                        onCompletion(true, securityTime)
                    }
                }
                break
                
            case .failure(let error):
                onCompletion(false, nil)
                print("error \(error)")
            }
        }
    }
}

