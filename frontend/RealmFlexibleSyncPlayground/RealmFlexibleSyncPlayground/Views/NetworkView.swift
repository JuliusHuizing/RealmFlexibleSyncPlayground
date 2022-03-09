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
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct NetworkView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkView(user: User())
    }
}
