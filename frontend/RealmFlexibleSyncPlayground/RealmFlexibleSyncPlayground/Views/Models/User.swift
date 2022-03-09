//
//  User.swift
//  RealmFlexibleSyncPlayground
//
//  Created by Julius Huizing on 08/03/2022.
//

//
//  User.swift
//  RChat
//
//  Created by Andrew Morgan on 23/11/2020.
//

import Foundation
import RealmSwift

class User: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id = UUID().uuidString
    @Persisted var userName = ""
    @Persisted var posts: List<UserPost>

    convenience init(userName: String, id: String) {
        self.init()
        self.userName = userName
        _id = id
    }
}




