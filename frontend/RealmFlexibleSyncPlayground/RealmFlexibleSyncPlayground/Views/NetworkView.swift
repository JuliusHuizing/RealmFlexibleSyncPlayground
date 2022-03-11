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
    @State var usersWithUserNameBiggerThanOneCount = 0
    var body: some View {
        VStack {
            Text("All registered users:")
            // Note that if you comment the views below, the @ObservedResults users will not get populated with the new subscription results defined in the onAppear below, since the results are lazily loaded?
                List {
                    ForEach(users) { user in
                        Text(user._id)
                    }
                }
            
        }
            .onAppear(perform: {setSubscriptionUserAll(realm: realm)
                
                // TODO: Discuss how one could do something like this.
                let usersWithUsernamesBiggerThanOne = someFnOnObservedUserObjects(users: users)
                usersWithUserNameBiggerThanOneCount = usersWithUsernamesBiggerThanOne.count
                
                
                
            }) // Note that  this sub will add new
    }
    
}

struct NetworkView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkView(user: User())
    }
}
