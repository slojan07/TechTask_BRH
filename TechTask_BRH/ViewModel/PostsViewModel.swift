//
//  PostsViewModel.swift
//  TechTask_BRH
//
//  Created by wiljan S on 9/24/23.
//


import Foundation
import SwiftUI


class PostsViewModel: ObservableObject {
    
    @Published var posts: [Post] = []
    @Published var error: Error?
    
    func fetchPosts() {
        let postURL = URL(string: "https://jsonplaceholder.typicode.com/posts/")!
        
        URLSession.shared.dataTask(with: postURL) { data, _, error in
            if let error = error {
                self.error = error
                return
            }
            
            if let data = data {
                do {
                    let posts = try JSONDecoder().decode([Post].self, from: data)
                    DispatchQueue.main.async {
                        self.posts = posts
                    }
                } catch {
                    DispatchQueue.main.sync {
                        self.error = error
                    }
                }
            }
        }.resume()
    }

    
}
