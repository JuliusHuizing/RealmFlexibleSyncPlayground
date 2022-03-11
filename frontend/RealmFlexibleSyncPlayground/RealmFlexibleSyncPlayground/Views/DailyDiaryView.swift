//
//  DailyDiaryView.swift
//  RealmFlexibleSyncPlayground
//
//  Created by Julius Huizing on 09/03/2022.
//

import SwiftUI
import RealmSwift


struct DailyDiaryView: View {
    @ObservedRealmObject var user: User
    @ObservedResults(DiaryEntry.self) var diaryEntries
    @State private var showingSheet = false
    @State private var selectedDiaryEntry: DiaryEntry = DiaryEntry()
    let date: Date
    var body: some View {
        VStack {
            List {
                ForEach(diaryEntries.filter({Calendar.current.isDate(date, equalTo: $0.date, toGranularity: .day)})) { entry in
                    VStack{
                        Text(entry.title)
                        Text(entry.body)
                        Button("Edit") {
                            //  TODO: After pressing this button on a just created diary entry (see button below), I would expect the DetailDiaryView to immediately show a diary entry with title 'test title' ad body 'test body'. Instead, it often first shows empty strings, and only shows the expected strings after multiple attempts or after adding more diary entries with the button below.
                            selectedDiaryEntry = entry
                            showingSheet = true
                        }
                    }
                }
            }
            Button("Add Entry to Diary") {
                let initDiaryEntry = DiaryEntry(ownerID: user._id)
                initDiaryEntry.title = "test title"
                initDiaryEntry.date = date
                initDiaryEntry.body = "test body"
                $diaryEntries.append(initDiaryEntry)
            }
        }.sheet(isPresented: $showingSheet, onDismiss: {}) {
            DiaryEntryDetailView(user: user, diaryEntry: selectedDiaryEntry)
        }
    }
}

struct DailyDiaryView_Previews: PreviewProvider {
    static var previews: some View {
        DailyDiaryView(user: User(), date: Date.now)
    }
}
