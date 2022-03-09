//
//  LoggedInView.swift
//  RChat
//
//  Created by Andrew Morgan on 05/01/2022.
//

// Changed to:
//  LoggedInView.swift
//  RealmFlexibleSyncPlayground
//
//  Created/Changed by Julius Huizing on 08/03/2022.
//



import SwiftUI
import RealmSwift

struct LoggedInView: View {
    @EnvironmentObject var state: AppState
    @Environment(\.realm) var realm
    @ObservedResults(User.self) var users
    @Binding var userID: String?
    
    var body: some View {
        ZStack {
            if let user = users.first {
                HomeView(user: user)
            }
        }
        .onAppear(perform: setSubscription)
    }
    
    private func setSubscription() {
        let subscriptions = realm.subscriptions
        subscriptions.write {
            if let currentSubscription = subscriptions.first(named: "user_id") {
                print("Replacing subscription for user_id")
                currentSubscription.update(toType: User.self) { user in
                    user._id == userID!
                }
            } else {
                print("Appending subscription for user_id")
                subscriptions.append(QuerySubscription<User>(name: "user_id") { user in
                    user._id == userID!
                })
            }
        }
    }
}

struct LoggedInView_Previews: PreviewProvider {
    static var previews: some View {
        LoggedInView(userID: .constant("Andrew"))
            .environmentObject(AppState())
    }
}

