//
//  HomeView.swift
//  RealmFlexibleSyncPlayground
//
//  Created by Julius Huizing on 09/03/2022.
//


import SwiftUI
import RealmSwift
// Dedicated struct to ensure changes will be published.


struct HomeView: View {
    @ObservedRealmObject var user: User
    @Environment(\.realm) var realm
    var body: some View {
        VStack {
            Text("Currently logged in as user with id \(user._id)")
        TabView {
            NewsFeedView(user: user)
                .tabItem() {
                    Image(systemName: "list.bullet")
                    Text("news feed")
                }
            NetworkView(user: user)
                .tabItem() {
                    Image(systemName: "list.bullet")
                    Text("network")
                }
            ProfileView(user: user)
                .tabItem() {
                    Image(systemName: "list.bullet")
                    Text("profile")
                }

        }
        }.onAppear(perform: {
//            setSubscriptionNotificationsReceived(realm: realm, user: user)
//            setSubscriptionTravelEventRecordsUser(realm: realm, user: user)
        })
            
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(user: User())
    }
}

