//
//  UserPost.swift
//  RealmFlexibleSyncPlayground
//
//  Created by Julius Huizing on 09/03/2022.
//

import Foundation
import RealmSwift

class UserPost: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id = UUID().uuidString
    @Persisted var ownerID: String
    @Persisted var title  = ""
    @Persisted var body = ""

    convenience init(ownerID: String) {
        self.init()
        self.ownerID = ownerID
    }
}
