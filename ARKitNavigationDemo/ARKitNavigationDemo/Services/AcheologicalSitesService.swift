//
//  AcheologicalSitesService.swift
//  ARKitNavigationDemo
//
//  Created by Ben Smith on 19/11/2017.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation
import Alamofire

class AcheologicalSitesService {
    public static func parseArcheogicalSites(completion: @escaping ([LineSegment]) -> Void) {
        let routeSchipolLocal = Bundle.main.url(forResource: "archelogicalsites", withExtension: "json")
        
        Alamofire.request(routeSchipolLocal!,
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default).responseJSON { (response) in
                            switch response.result {
                            case .success(let jsonData):
                                if let dict = jsonData as? NSDictionary,
                                    let features = dict["features"] as? NSArray{
                                    for feature in features {
                                        if let feature = feature as? NSDictionary {
                                            if let id = feature["id"] as? Int,
                                                let geometry = feature["geometry"] as? NSDictionary,
                                                let coordinates = geometry["coordinates"] as? NSArray,
                                                let pathsInner = coordinates[0] as? NSArray {
                                                NavigationService.getDirections(pointsArrays: pathsInner as! Array<Array<Any>>, completion: { (lineSegments) in
                                                    print(lineSegments)
                                                    completion(lineSegments)
                                                })
                                            }
                                        }

                                    }

                                }

                                
                                
                            case .failure(let error):
                                print("error \(error)")
                            }
        }
        
    }
}

