//
//  WayFIndingSchipholService.swift
//  ARKitNavigationDemo
//
//  Created by Ben Smith on 17/11/2017.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation
import Alamofire
class WayFindingSchipholService{
    
    public static func parseRout(completion: @escaping ([LineSegment]) -> Void) {
        let routeSchipolLocal = Bundle.main.url(forResource: "routeSchiphol", withExtension: "json")

        let startCoordLng = 4.7636383
        let startCoordLat = 52.3093557
        
        let endCoordLng = 4.7606074
        let endCoordLat = 52.3100116
        
        let outSR = 4326
        
        let url2 = "http://etest2.esri.nl:8080/arcgis/rest/services/Schiphol/IFW_Network_RD/NAServer/Route/solve?stops=\(startCoordLng)%2C\(startCoordLat)%3B%0D%0A\(endCoordLng)%2C\(endCoordLat)%3B&barriers=&polylineBarriers=&polygonBarriers=&outSR=\(outSR)&ignoreInvalidLocations=true&accumulateAttributeNames=&impedanceAttributeName=Pedestriantime&restrictionAttributeNames=Oneway%2C+Roadclass1%2C+Roadclass2%2C+Roadclass3&attributeParameterValues=&restrictUTurns=esriNFSBAllowBacktrack&useHierarchy=false&returnDirections=false&returnRoutes=true&returnStops=false&returnBarriers=false&returnPolylineBarriers=false&returnPolygonBarriers=false&directionsLanguage=en&directionsStyleName=&outputLines=esriNAOutputLineTrueShapeWithMeasure&findBestSequence=false&preserveFirstStop=true&preserveLastStop=true&useTimeWindows=false&startTime=0&startTimeIsUTC=false&outputGeometryPrecision=&outputGeometryPrecisionUnits=esriDecimalDegrees&directionsOutputType=esriDOTInstructionsOnly&directionsTimeAttributeName=Pedestriantime&directionsLengthUnits=esriNAUMeters&returnZ=false&travelMode=&f=pjson"
        print(url)
        Alamofire.request(url2,
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default).responseJSON { (response) in
                            switch response.result {
                            case .success(let jsonData):
                                if let dict = jsonData as? NSDictionary,
                                let routes = dict["routes"] as? NSDictionary,
                                let features = routes["features"] as? NSArray,
                                let feature = features[0] as? NSDictionary,
                                let geometry = feature["geometry"] as? NSDictionary,
                                let paths = geometry["paths"] as? NSArray,
                                let pathsInner = paths[0] as? NSArray {
                                    NavigationService.getDirections(pointsArrays: pathsInner as! Array<Array<Any>>, completion: { (lineSegments) in
                                        print(lineSegments)
                                        completion(lineSegments)
                                    })
                                }

                            case .failure(let error):
                                print("error \(error)")
                            }
        }
        
    }
}
