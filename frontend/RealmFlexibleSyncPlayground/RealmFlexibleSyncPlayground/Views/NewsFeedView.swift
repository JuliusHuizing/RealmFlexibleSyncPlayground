//
//  NewsFeedView.swift
//  RealmFlexibleSyncPlayground
//
//  Created by Julius Huizing on 09/03/2022.
//

import SwiftUI
import RealmSwift

struct NewsFeedView: View {
    @ObservedRealmObject var user: User
    @ObservedResults(UserPost.self) var posts
    @Environment(\.realm) var realm

    var body: some View {
        VStack {
        List {
            ForEach(posts) { post in
                VStack {
                    Text(post.title)
                    Text(post.body)
                }
            }
        }
    
        Spacer()
        Button("New post") {
            let newPost = UserPost(ownerID: user._id)
            newPost.title = "Default title"
            newPost.body = "Default body"
            $posts.append(newPost)
            
        }
        }.onAppear(perform: {
            setSubscriptionUserPostAll(realm: realm)
        })
    }

}

struct NewsFeedView_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedView(user: User())
    }
}
