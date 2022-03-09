//
//  RealmFlexibleSyncPlaygroundApp.swift
//  RealmFlexibleSyncPlayground
//
//  Created by Julius Huizing on 08/03/2022.


let app = RealmSwift.App(id: "realmflexiblesyncplayground-bovhb") // TODO: Set the Realm application ID

import SwiftUI
import RealmSwift

@main
struct RealmFlexibleSyncPlaygroundApp: SwiftUI.App {
    @StateObject var state = AppState()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(state)

        }
    }
}
