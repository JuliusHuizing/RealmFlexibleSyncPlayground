//
//  OperationsOnObservedResults.swift
//  RealmFlexibleSyncPlayground
//
//  Created by Julius Huizing on 11/03/2022.
//

import Foundation
import RealmSwift


func someFnOnObservedUserObjects(users: [User]) -> [User] {
    return users.filter({$0.userName.count > 1})
                
}
