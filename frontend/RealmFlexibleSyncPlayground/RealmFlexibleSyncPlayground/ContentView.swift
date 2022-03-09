// Taken from https://github.com/realm/RChat/tree/flex-sync

//  ContentView.swift
//  RChat
//
//  Created by Andrew Morgan on 23/11/2020.
//

// Adapted by:
//  ContentView.swift
//  RealmFlexibleSyncPlayground
//
//  Created by Julius Huizing on 08/03/2022.
//


import SwiftUI
import UserNotifications
import RealmSwift

struct ContentView: View {
    @EnvironmentObject var state: AppState
    @State private var userID: String?

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    if state.loggedIn && userID != nil {
                        LoggedInView(userID: $userID)
                            .environment(\.realmConfiguration,
                                          app.currentUser!.flexibleSyncConfiguration())
                    } else {
                        LoginView(userID: $userID)
                    }
                    Spacer()
                    if let error = state.error {
                        Text("Error: \(error)")
                            .foregroundColor(Color.red)
                    }
                }
                if state.busyCount > 0 {
                    Text("Waiting for Realm")
                }
            }
        }
//        .currentDeviceNavigationViewStyle(alwaysStacked: !state.loggedIn)
    }
    
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
                ContentView()
                    .environmentObject(AppState())
        
    }
}
