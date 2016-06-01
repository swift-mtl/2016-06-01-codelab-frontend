//
//  UserManager.swift
//  WTM-CodeLab
//
//  Created by Fatih Nayebi on 2016-03-11.
//  Copyright © 2016 Swift-Mtl. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class TodoManager {
    
    class func getTodos(completion:(responseData:[TodoModel]?, error: Bool?) -> ()) {
        WebServiceManger.sendRequest(url: "http://localhost:8090", httpRequestType: "GET", responseType: TodoModel.self) {
            (responseData:[TodoModel]?, error: Bool?) -> Void in
            print(responseData)
            completion(responseData: responseData, error: false)
        }
    }
    
    class func addTodo(completion:(responseData:[TodoModel]?, error: Bool?) -> ()) {
        WebServiceManger.sendRequest(url: "http://localhost:8090", httpRequestType: "POST",responseType: TodoModel.self) {
            (responseData:[TodoModel]?, error: Bool?) -> Void in
            print(responseData)
            completion(responseData: responseData, error: false)
        }
    }
    
    class func getTodosFromDB(completion:(responseData:[TodoModel]?, error: Bool?) -> ()) {
        readData(TodoModel.self, predicate: nil) {
            (response: Results<TodoModel>) in
            if response.count > 0 {
                completion(responseData: response.map { $0 }, error: false)
            } else {
                completion(responseData: nil, error: true)
            }
        }
    }
}