//
//  NetworkView.swift
//  RealmFlexibleSyncPlayground
//
//  Created by Julius Huizing on 09/03/2022.
//

import SwiftUI
import RealmSwift

struct NetworkView: View {
    @ObservedRealmObject var user: User
    // TODO: discuss why this still seems to show users that have been deleted?
    @ObservedResults(User.self) var users
    @Environment(\.realm) var realm
    var body: some View {
        VStack {
            
            // TODO: Discuss how would you go about searching for other registed users without retrieving ALL users first? I.e. how would we keep this view economical if there are thousands of users?
            
            Text("Friends")
                List {
                    ForEach(user.friends, id: \.self) { otherUserID in
                        HStack {
                            Text(otherUserID)
                        }
                    }
                
            }
            
            Text("Incoming Friend Requests:")
                List {
                    ForEach(users.filter({$0.friendRequestsOutgoing.contains(user._id)})) { otherUser in
                        HStack {
                            Text(otherUser.userName)
                            Spacer()
                            Button(action: {acceptFriend(userID: otherUser._id)}) {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                
            }
            Text("All registered users:")
            // Note that if you comment the views below, the @ObservedResults users will not get populated with the new subscription results defined in the onAppear below, since the results are lazily loaded?
                List {
                    ForEach(users) { otherUser in
                        HStack {
                            Text(otherUser.userName)
                            Spacer()
                            Button(action: {addFriend(userID: otherUser._id)}) {
                                Image(systemName: "plus")
                            }
                        }
                    }
                }
            
        }
            .onAppear(perform: {setSubscriptionUserAll(realm: realm)}) // Note that  this sub will add new
    }
    
    private func addFriend(userID: String) -> Void {
        $user.friendRequestsOutgoing.append(userID)
    }
    private func acceptFriend(userID: String) -> Void {
        $user.friends.append(userID)
    }
}

struct NetworkView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkView(user: User())
    }
}
