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
    
    // TODO: Discuss whether this is an antipattern: prob not safe to store other ID's like this? + Likely should be embedded objects since in practice it are bounded sets?
    @Persisted var friends: List<String> // List of string UUID's associated with friends.
    @Persisted var friendRequestsIncoming: List<String> // similar to above
    @Persisted var friendRequestsOutgoing: List<String> // similar to above


    convenience init(userName: String, id: String) {
        self.init()
        self.userName = userName
        _id = id
    }
}




