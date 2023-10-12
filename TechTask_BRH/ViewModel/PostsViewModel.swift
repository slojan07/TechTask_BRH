//
//  PostsViewModel.swift
//  TechTask_BRH
//
//  Created by wiljan S on 9/24/23.
//


import Foundation
import SwiftUI


protocol URLSessionProtocol {
    func dataTask(
        with url: URL,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {
  
}

class PostsViewModel: ObservableObject {
    
    @Published var posts: [Post] = []
    @Published var error: Error?
    
    var session: URLSessionProtocol 
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    func fetchPosts() {
        let postURL = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        
        session.dataTask(
            with: postURL,
            completionHandler: { data, _, error in
                
                if let error = error {
                    DispatchQueue.main.async {
                        self.error = error
                    }
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
            }
        ).resume()
    }
}
