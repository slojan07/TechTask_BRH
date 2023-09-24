//
//  CommentsViewModel.swift
//  TechTask_BRH
//
//  Created by wiljan S on 9/25/23.
//

import Foundation
import SwiftUI
import Combine



class CommentsViewModel: ObservableObject {
    
    
    @Published var comments: [Comment] = []
    @Published var error: Error?
    
    func fetchComments(for postId: Int) {
        let commentsURL = URL(string: "https://jsonplaceholder.typicode.com/posts/\(postId)/comments/")!
        
        URLSession.shared.dataTask(with: commentsURL) { data, _, error in
            if let error = error {
                DispatchQueue.main.sync {
                    self.error = error
                }
                return
            }
            
            if let data = data {
                do {
                    let comments = try JSONDecoder().decode([Comment].self, from: data)
                    DispatchQueue.main.async {
                        self.comments = comments
                    }
                } catch {
                    self.error = error
                }
            }
        }.resume()
    }
    
}
