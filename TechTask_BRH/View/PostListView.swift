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
            List(viewModel.posts) { post in
              
                    VStack(alignment: .leading) {
                    
                        Text(post.title)
                            .font(.headline)
                            .frame(height: 30)
                        Text(post.body)
                            .font(.body)
                            .frame(height: 50)
                    
                    }
             
            }
            .navigationBarTitle("All posts")
            .onAppear {
                
                viewModel.fetchPosts()
        
                    
            }
    }
}
