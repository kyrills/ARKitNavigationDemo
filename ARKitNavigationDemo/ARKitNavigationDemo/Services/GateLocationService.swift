//
//  GateLocationService.swift
//  ARKitNavigationDemo
//
//  Created by Kyrill van Seventer on 17/11/2017.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation
import Alamofire

class GateLocationService{
    
    public static let sharedInstance = GateLocationService()
    
    private init() {}
    
    
    func getToken() {
        let userDetailsHeader : Parameters = ["app_id" : "90b40430",
                                             "app_key":"c05b69b6017b6f169ca16e95dda0fee7",
                                             "Accept" : "application/json",
                                             "ResourceVersion" : "v1"]
        let url = "https://api-acc.schiphol.nl/swf/tokens/generateToken?f=json"
        print(url)
        
        Alamofire.request(url,
                          method: .get,
                          parameters: userDetailsHeader,
                          encoding: JSONEncoding.default).responseJSON { (response) in
                            switch response.result {
                            case .success(let jsonData):
                                if let dict = jsonData as? NSDictionary {
                                    if let token = dict["token"] as? String{
                                    print(token)
                                    self.getGateLocation(token: token)
                                    }
                                }
                                break
                                
                            case .failure(let error):
                                print("error \(error)")
                            }
                            
        }
    }
    func getGateLocation(token: String){
        let userDetailsParams: Parameters = ["app_id" : "90b40430",
                                             "app_key":"c05b69b6017b6f169ca16e95dda0fee7",
                                             "Accept" : "application/json",
                                             "ResourceVersion" : "v1"]
        let url = "https://api-acc.schiphol.nl/swf/rest/services/Schiphol/SWF_POI/MapServer/0/query?where=category%20%3D%2050%20and%20subcategory%20%3D%20%27Departing%20Gate%27&outFields=*&outSR=4326&token=\(token)&f=json"
        print(url)
        Alamofire.request(url,
                          method: .get,
                          parameters: userDetailsParams,
                          encoding: JSONEncoding.default).responseJSON { (response) in
                            switch response.result {
                            case .success(let jsonData):
                                if let dict = jsonData as? NSDictionary {
                                    print(dict)
                                }
                                break
                                
                            case .failure(let error):
                                print("error \(error)")
                            }
        
        }
    }
    
    func parseData (result: NSDictionary) {
        var gateObj: [SchipholGates] = []
        if let features = result["features"] as? NSArray {
            for feature in features {
                if let key = feature as? NSDictionary{
                    let properties = getDictionary(with: "attributes", from: key) ?? [:]
                    let geometry = getDictionary(with: "geometry", from: key) ?? [:]
                    let latitude = geometry["x"] as! Double
                    let longitude = geometry["y"] as! Double
                    if let gateObject = parseProperties(properties: properties,
                                                        id: key["objectid"] as? String ?? "",
                                                        latitude: latitude,
                                                        longitude: longitude) {
                        gateObj.append(gateObject)
                        
                    }
                }
            }
        }
    }
    
    func parseProperties(properties: NSDictionary, id: String, latitude: Double, longitude: Double) -> SchipholGates?{
        if let id = properties["objectid"] as? Int,
            let name = properties["name"] as? String {
            
            let schipholGateObject = SchipholGates.init(id: id, name: name, latitude: latitude, longitude: longitude)
            return schipholGateObject
        }
        return nil
    }
    
    func getDictionary(with key: String, from feature: NSDictionary) -> NSDictionary? {
        if let geo = feature[key] as? NSDictionary{
            return geo
        } else {
            return nil
        }
    }
    
}
