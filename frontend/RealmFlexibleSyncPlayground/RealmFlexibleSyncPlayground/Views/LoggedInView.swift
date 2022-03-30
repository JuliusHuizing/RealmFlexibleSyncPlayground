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
            else {
                 // TODO: Discuss why this sometimes take very long (+ 15 minutes) after cleaning up atlas collection and realm users and client side device.
                Text("waiting for user to be found")
                
            }
        }
        .onAppear(perform:
                    {
            setSubscriptionUserCurrent(userID: userID, realm: realm)}
        )
    }
}

struct LoggedInView_Previews: PreviewProvider {
    static var previews: some View {
        LoggedInView(userID: .constant("Andrew"))
            .environmentObject(AppState())
    }
}

