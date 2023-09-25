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

    var body: some View {
      //  NavigationView {
            List(viewModel.posts) { post in
                NavigationLink(destination: PostDetailsView(post: post)) {
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
            .onAppear {
                viewModel.fetchPosts()
        
                    
            }
    }
}

