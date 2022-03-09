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
    @ObservedResults(User.self) var users
    @Environment(\.realm) var realm
    var body: some View {
        VStack {
            Text("All registered users:")
            // Note that if you comment the views below, the @ObservedResults users will not get populated with the new subscription results defined in the onAppear below, since the results are lazily loaded? This was very confusing at first, since using the onAppear to set a sub led me to believe this would automatically populate the user collection.
                List {
                    ForEach(users) { user in
                        Text(user._id)
                    }
                }
            
        }
            .onAppear(perform: {setSubscriptionUserAll(realm: realm)}) // Note that  this sub will add new
    }
}

struct NetworkView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkView(user: User())
    }
}
