//
//  WebServiceManager.swift
//  2016-06-01-codelab-frontend
//
//  Created by Fatih Nayebi on 2016-06-01.
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
        
        
        var method = Method.GET
        
        switch httpRequestType {
        case "POST":
            method = .POST
        default:
            method = .GET
        }
        
        // Alamofire web service call:
        
        Alamofire.request(method, url, parameters: requestParameters)
            .responseArray(queue: queue, completionHandler: {
                (response: Response<[T], NSError>) in
                
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    dispatch_async(dispatch_get_main_queue(), {
                        // Save the data to DB:
                        
                        saveData(JSON)
                        print("JSON: \(JSON)")
                        // callback with the data
                        completion(responseData: JSON, error: nil)
                    })
                }
            })
    }
}
