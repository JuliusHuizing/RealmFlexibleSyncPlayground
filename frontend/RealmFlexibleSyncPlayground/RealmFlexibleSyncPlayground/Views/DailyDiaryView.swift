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
    @State private var selectedDiaryEntry: DiaryEntry? = nil
    let date: Date
    var body: some View {
        VStack {
            List {
                ForEach(diaryEntries.filter({Calendar.current.isDate(date, equalTo: $0.date, toGranularity: .day)})) { entry in
                    VStack{
                        Text(entry.title)
                        Text(entry.body)
                        Button("Edit") {
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
            DiaryEntryDetailView(user: user, diaryEntry: selectedDiaryEntry!)
        }
    }
}

struct DailyDiaryView_Previews: PreviewProvider {
    static var previews: some View {
        DailyDiaryView(user: User(), date: Date.now)
    }
}
