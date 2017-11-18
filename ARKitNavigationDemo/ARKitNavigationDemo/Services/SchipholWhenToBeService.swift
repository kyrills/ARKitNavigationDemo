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
    
    typealias getTimeToSchipholCompletion = (Bool, Any?) -> Void
    
    public static func checkWhentoBeAtSChiphol(flightNumber: String, onCompletion: @escaping getTimeToSchipholCompletion) {
        let userDetailsParams: Parameters = ["app_id" : "357a3ef1",
                                             "app_key":"38b338a9405d784b4cc051bb7d3372d9",
                                             "Accept" : "application/json",
                                             "ResourceVersion" : "v1"]
        let url = "https://api-acc.schiphol.nl/when-to-be-at-schiphol/private/BA2765?checkinRequired=false&debug=false"
        print(url)
        Alamofire.request(url,
              method: .get,
              parameters: userDetailsParams,
              encoding: JSONEncoding.default).responseJSON { (response) in
                switch response.result {
                case .success(let jsonData):
                    print(jsonData)
                    
                    onCompletion(true, jsonData)
                    break

                case .failure(let error):
                    onCompletion(false, nil)
                    print("error \(error)")
                }
        }
    }
}
