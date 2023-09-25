//
//  CommentListView.swift
//  TechTask_BRH
//
//  Created by wiljan S on 9/25/23.
//

import Foundation
import SwiftUI

struct CommentListView: View {
    let postId: Int
    @ObservedObject var commentsViewModel = CommentsViewModel()

    var body: some View {
        NavigationView {
            List(commentsViewModel.comments) { comment in
                CommentRowView(comment: comment)
            }
            .onAppear {
                commentsViewModel.fetchComments(for: postId)
            }
            .navigationTitle("Comments")
        }
    }
}



struct CommentRowView: View {
    let comment: Comment

    var body: some View {
        VStack(alignment: .leading) {
            Text(comment.name)
                .font(.headline)
            Text(comment.body)
                .font(.body)
        }
    }
}
