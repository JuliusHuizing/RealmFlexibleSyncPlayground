//
//  DiaryEntryDetailView.swift
//  RealmFlexibleSyncPlayground
//
//  Created by Julius Huizing on 09/03/2022.
//

import SwiftUI
import RealmSwift

struct DiaryEntryDetailView: View {
    @ObservedRealmObject var user: User
    @ObservedRealmObject var diaryEntry: DiaryEntry
    @Environment(\.realm) var realm
    @Environment(\.presentationMode) var presentationMode
    @State private var title = ""
    @State private var entryBody = ""
    var body: some View {
        VStack {
            Text("Title: \(diaryEntry.title)")
            Text("Body: \(diaryEntry.body)")
            Spacer()
            TextField("Title", text: $title)
            TextField("Body", text: $entryBody)
            
            Button("confirm") {
                let thawedObject = diaryEntry.thaw()
                    try! realm.write {
                        thawedObject?.title = title
                        thawedObject?.body = entryBody
                        realm.add(thawedObject!, update: .modified)
                    
                    }
                presentationMode.wrappedValue.dismiss()

            }
        }
    }
}

struct DiaryEntryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryEntryDetailView(user: User(), diaryEntry: DiaryEntry())
    }
}
