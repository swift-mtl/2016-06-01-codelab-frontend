//
//  DatabaseManager.swift
//  2016-06-01-codelab-frontend
//
//  Created by Fatih Nayebi on 2016-06-01.
//  Copyright © 2016 Fatih Nayebi. All rights reserved.
//

import Foundation
import RealmSwift


/// #### Save a data model to Realm DB
/// This method is used when we have a single object model that we want to persist it in Realm DB
/// - Parameter response: Model Object - parsed from JSON and is a subclass of Object
/// - Returns: Void
public func saveData<T>(response: T, isUpdate: Bool = true) {
    
    let realm = try! Realm()
    try! realm.write {
        let realmObject = response as! Object
        realm.add(realmObject, update: isUpdate)
    }
}

// MARK: - Read Data

/// #### Read Data from Realm DB
/// This method reads data from Realm DB and returns with completion block
/// - Parameter: model - Type of model to be read from Realm DB
/// - Parameter: predicate - predicate string such as "color = 'tan' AND name BEGINSWITH 'B'"
/// - Parameter: completion: completion handler closure to return data
/// - Returns: It is Void since it uses completion for call backs
public func readData<T:Object>(model: T.Type, predicate: String?, completion: (responseData:Results<T>) -> Void) {
    
    let realm = try! Realm()
    let result: Results<T>
    if let predicateString = predicate {
        result = realm.objects(model).filter(predicateString)
    } else {
        result = realm.objects(model)
    }
    completion(responseData: result)
    
}

// MARK: - Delete

/// #### Delete a model from Realm DB
/// This method deletes a specific model from Realm DB
/// - Parameter: model - type of the model that is subclass of a Object and will be deleted
public func delete<T:Object>(model: T) {
    let realm = try! Realm()
    try! realm.write {
        realm.delete(model)
    }
}

/// #### Delete All
/// This method deletes all objects from Realm DB
/// - Important: Be cautious when using it, data will not be recoverable!
public func deleteAll() {
    let realm = try! Realm()
    try! realm.write {
        realm.deleteAll()
    }
    
}