//
//  HomeView.swift
//  RealmFlexibleSyncPlayground
//
//  Created by Julius Huizing on 09/03/2022.
//


import SwiftUI
import RealmSwift

struct HomeView: View {
    // Required for proper view functionality
    @ObservedRealmObject var user: User
    @ObservedResults(User.self) var users
    @Environment(\.realm) var realm
    
    // Not required, but to show how Realm works.
    
    
    var body: some View {
        // Not required, but to show how Realm works
        VStack {
            
            Color.green.opacity(0.5)
                .ignoresSafeArea()

                    .overlay(
                        
            VStack {
                Text("Currently logged in as user with id \(user._id)")
                Text("'@ObservedResults(User.self) var users' count: \(users.count)")
            }

                    ).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)

                
            Spacer()
            
        // Required for intended view functionality
        TabView {
            NewsFeedView(user: user)
                .tabItem() {
                    Image(systemName: "newspaper")
                    Text("news feed")
                }
            DiaryView(user: user)
                .tabItem() {
                    Image(systemName: "note.text.badge.plus")
                    Text("weekly diary")
                }
            NetworkView(user: user)
                .tabItem() {
                    Image(systemName: "network")
                    Text("network")
                }
            ProfileView(user: user)
                .tabItem() {
                    Image(systemName: "person")
                    Text("profile")
                }

        }
        }.onAppear(perform: {
            // Note we do not need to do a sub to the users again, as a parent of this view, LoggedinView, has already done that sub for us and now we still have access to its results through the @ObservedResults(User.self) var users collection at the top of the view.
            
        })
            
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(user: User())
    }
}

