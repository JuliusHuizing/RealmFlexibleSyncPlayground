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
    @State private var selectedDiaryEntry: DiaryEntry?
    var todaysEntries: [DiaryEntry]? {
        diaryEntries.filter({Calendar.current.isDate(date, equalTo: $0.date, toGranularity: .day)})
       }
    let date: Date
    var body: some View {
        NavigationView {
        VStack {
            List {
                if let todaysEntries = todaysEntries {
                    ForEach(todaysEntries, id: \.self) { entry in
                        VStack{
                            Text(entry.title)
                            Text(entry.body)
                            Button("Edit") {
                                selectedDiaryEntry = entry
                                // TODO: Discuss: Selected diary entry is checked not to be nil, so I'd expect the sheet to present a detailView with the diaryEntry values of the just selected entry (title = "test title", body = 'test body'. Instead, the sheet still finds nill and will present the fallback value unexpected defined as '?? DiaryEntry(ownerID: user._id, title: "found nil", body: "why?"))'. Only after creating an additional entry by hitting the "add entry to diary' button, and then presenting the sheet again, are the expected values shown in the detail view.
                                if selectedDiaryEntry != nil {
                                    showingSheet = true
                                }

                            }
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
        }}.sheet(isPresented: $showingSheet, onDismiss: {}) {
            // TODO: Discuss: How can this be nill if we just checked above that it should not be? And why does it only get the intende value after creating multiple diary entries using the add button?
            DiaryEntryDetailView(user: user, diaryEntry: selectedDiaryEntry ?? DiaryEntry(ownerID: user._id, title: "found nil", body: "why?"))
//                .onAppear(perform: {
////                    todaysDiaryEntires = diaryEntries.filter{
////                        Calendar.current.isDate(date, equalTo: $0.date, toGranularity: .day)
//                    }
//                })
        }
    }
}

struct DailyDiaryView_Previews: PreviewProvider {
    static var previews: some View {
        DailyDiaryView(user: User(), date: Date.now)
    }
}
