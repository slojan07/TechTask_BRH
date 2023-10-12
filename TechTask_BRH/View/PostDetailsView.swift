//
//  PostDetailsView.swift
//  TechTask_BRH
//
//  Created by wiljan S on 9/25/23.
//

import Foundation
import SwiftUI
import CoreData


struct PostDetailsView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var viewModel: PostDetailsViewModel

    
  //  let post: Post
    @State private var showComments = false
    
    var body: some View {
        VStack {
            Text(viewModel.post.title)
                .font(.headline)
            
            Text(viewModel.post.body)
                .font(.body)
                .padding()
            
            Button(action: {
                viewModel.toggleOfflineSave()
            }) {
                Label(viewModel.isSavedOffline ? "Remove from Offline" : "Save To Offline", systemImage: viewModel.isSavedOffline ? "minus" : "plus")
                    .foregroundColor(.white)
                    .padding()
                    .background(viewModel.isSavedOffline ? Color.red : Color.green)
                    .cornerRadius(10)
            }
            
            Divider()
                .padding()
            
            Button(action: {
                showComments = true
            }) {
                Text("View Comments")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .sheet(isPresented: $showComments) {
                CommentListView(postId: viewModel.post.id)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding()
        .navigationBarTitle("Post Details")
    }
}


