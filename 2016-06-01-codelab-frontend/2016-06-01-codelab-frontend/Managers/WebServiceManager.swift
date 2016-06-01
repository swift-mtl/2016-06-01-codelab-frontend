//
//  WebServiceManager.swift
//  WTM-CodeLab
//
//  Created by Fatih Nayebi on 2016-03-11.
//  Copyright © 2016 Swift-Mtl. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

class WebServiceManger {
    
    class func sendRequest<T:Mappable>(requestParameters: [String:AnyObject]? = nil, url: String, httpRequestType: String,responseType: T.Type, completion: (responseData:[T]?, error:Bool?) -> Void) {
        
        // To execute in a different thread than main thread:
        let queue = dispatch_queue_create("manager-response-queue", DISPATCH_QUEUE_CONCURRENT)
        
        // Alamofire web service call:
        var method = Method.GET
        
        switch httpRequestType {
        case "POST":
            method = .POST
        default:
            method = .GET
        }
        
        Alamofire.request(method, url, parameters: requestParameters)
            .responseArray(queue: queue, completionHandler: {
                (response: Response<[T], NSError>) in
                
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    // Save the data to DB:
                    saveData(JSON)
                    print("JSON: \(JSON)")
                    // callback with the data
                    completion(responseData: JSON, error: nil)
                }
            })
    }
}
