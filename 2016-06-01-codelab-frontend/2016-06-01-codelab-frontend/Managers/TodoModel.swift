//
//  UserModel.swift
//  WTM-CodeLab
//
//  Created by Fatih Nayebi on 2016-03-11.
//  Copyright © 2016 Swift-Mtl. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class TodoModel: Object, Mappable {
    
    dynamic var id: String = ""
    dynamic var name: String = ""
    dynamic var detail: String = ""
    dynamic var completed: Bool = false
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    override class func primaryKey() -> String {
        return "id"
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        detail <- map["detail"]
        completed <- map["completed"]
    }
}