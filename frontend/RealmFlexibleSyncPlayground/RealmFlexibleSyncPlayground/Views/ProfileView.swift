//
//  ProfileView.swift
//  RealmFlexibleSyncPlayground
//
//  Created by Julius Huizing on 09/03/2022.
//

import SwiftUI
import RealmSwift

struct ProfileView: View {
    @ObservedRealmObject var user: User
    @State private var newUserName = ""
    var body: some View {
        VStack {
            TextField("Username", text: $newUserName)
            Button("confirm"){
                // TODO: discuss, why do we need the wrappedValue here for this to work?
                $user.userName.wrappedValue = newUserName
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User())
    }
}
