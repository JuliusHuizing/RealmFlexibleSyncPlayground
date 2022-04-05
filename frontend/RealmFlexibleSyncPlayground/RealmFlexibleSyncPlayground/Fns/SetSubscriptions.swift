//
//  SetSubscriptions.swift
//  RealmFlexibleSyncPlayground
//
//  Created by Julius Huizing on 09/03/2022.
//

import Foundation
import RealmSwift

func setSubscriptionUserCurrent(userID: String?, realm: Realm) {
    if let userID = userID {
        let subscriptions = realm.subscriptions
        subscriptions.write {
            if let currentSubscription = subscriptions.first(named: "user_id") {
                print("Replacing subscription for user_id")
                currentSubscription.update(toType: User.self) { user in
                    user._id == userID
                }
            } else {
                print("Appending subscription for user_id")
                subscriptions.append(QuerySubscription<User>(name: "user_id") { user in
                    user._id == userID
                })
            }
        }
    }
    else {
        print("Cannot set sub for user since user id is nill.")
    }
}

func setSubscriptionUserAll(realm: Realm) {
        let subscriptions = realm.subscriptions
        subscriptions.write {
            if let currentSubscription = subscriptions.first(named: "all users") {
                print("Replacing subscription for all users")
                currentSubscription.update(toType: User.self) { user in
                    user._id != ""
                }
            } else {
                print("Appending subscription for all users")
                subscriptions.append(QuerySubscription<User>(name: "all users") { user in
                    user._id != ""
                })
            }
        }
}

func setSubscriptionUserPostAll(realm: Realm) {
        let subscriptions = realm.subscriptions
        subscriptions.write {
            if let currentSubscription = subscriptions.first(named: "all user posts") {
                print("Replacing subscription for all user posts")
                currentSubscription.update(toType: UserPost.self) { post in
                    post.ownerID != ""
                }
            } else {
                print("Appending subscription for all users")
                subscriptions.append(QuerySubscription<UserPost>(name: "all user posts") { post in
                    post.ownerID != ""
                })
            }
        }
}

func setSubscriptionUserPostUser(user: User, realm: Realm) {
        let subscriptions = realm.subscriptions
        subscriptions.write {
            if let currentSubscription = subscriptions.first(named: "specific user posts") {
                print("Replacing subscription for specific user posts")
                currentSubscription.update(toType: UserPost.self) { post in
                    post.ownerID == user._id
                }
            } else {
                print("Appending subscription for specific users")
                subscriptions.append(QuerySubscription<UserPost>(name: "specific user posts") { post in
                    post.ownerID == user._id
                })
            }
        }
}


func setSubscriptionDiaryEntryUser(user: User, realm: Realm) {
        let subscriptions = realm.subscriptions
        subscriptions.write {
            if let currentSubscription = subscriptions.first(named: "specific user diary entries") {
                print("Replacing subscription for specific user diary entries")
                currentSubscription.update(toType: DiaryEntry.self) { entry in
                    entry.ownerID == user._id
                }
            } else {
                print("Appending subscription for specific user diary entries")
                subscriptions.append(QuerySubscription<DiaryEntry>(name: "specific user diary entries") { entry in
                    entry.ownerID == user._id
                })
            }
        }
}


func setSubscriptionDiaryEntriesBeforeToday(realm: Realm) {
        let subscriptions = realm.subscriptions
        subscriptions.write {
            if let currentSubscription = subscriptions.first(named: "diary entry before date") {
                currentSubscription.update(toType: DiaryEntry.self) { entry in
                    entry.date <= Date.now                }
            } else {
                subscriptions.append(QuerySubscription<DiaryEntry>(name: "diary entry before date") { entry in
                    entry.date <= Date.now
                })
            }
        }
}
