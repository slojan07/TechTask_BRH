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
    
    func fetchPosts() {
   
        
    }

    
}
