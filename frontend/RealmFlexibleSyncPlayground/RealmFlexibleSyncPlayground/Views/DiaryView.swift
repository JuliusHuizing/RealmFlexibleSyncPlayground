//
//  DiaryView.swift
//  RealmFlexibleSyncPlayground
//
//  Created by Julius Huizing on 09/03/2022.
//

import SwiftUI
import RealmSwift

let datesThisWeek = getThisWeeksDays()

struct DiaryView: View {
    @ObservedRealmObject var user: User
    @ObservedResults(DiaryEntry.self) var diaryEntries
    @Environment(\.realm) var realm
    var body: some View {
        NavigationView {
            List {
                ForEach(datesThisWeek, id: \.self) { date in
                    NavigationLink(destination: DailyDiaryView(user: user, date: date)) {
                        Text(date.description)
                    }
                }
            }
        }.onAppear(perform: {
            setSubscriptionDiaryEntryUser(user: user, realm: realm)
        })
    }
}

struct DiaryView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryView(user: User())
    }
}
