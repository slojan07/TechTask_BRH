//
//  PostListView.swift
//  TechTask_BRH
//
//  Created by wiljan S on 9/25/23.
//

import Foundation

import SwiftUI

struct PostListView: View {
    @ObservedObject var viewModel: PostsViewModel
    @State private var showErrorAlert = false
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
  //  NavigationView {
        List(viewModel.posts, id: \.id) { post in
            NavigationLink(destination: PostDetailsView(viewModel: PostDetailsViewModel(post: post, viewContext: viewContext))) {
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                        .frame(height: 30)
                  
                    Text(post.body)
                        .font(.body)
                        .frame(height: 50)
                }
            }
        }
        .navigationBarTitle("All posts")
   // }
    .onAppear {
        viewModel.fetchPosts()
    }
            .alert(isPresented: $showErrorAlert) {
                Alert(title: Text("Error"), message: Text(viewModel.error?.localizedDescription ?? "Unknown error"), dismissButton: .default(Text("OK")))
            }
            .onReceive(viewModel.$error) { error in
                if let _ = error {
                    showErrorAlert = true
                }
            }
    }
}

