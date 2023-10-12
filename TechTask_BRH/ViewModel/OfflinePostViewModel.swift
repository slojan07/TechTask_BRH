//
//  OfflinePostViewModel.swift
//  TechTask_BRH
//
//  Created by wiljan S on 10/12/23.
//

import Foundation
import CoreData

class OfflinePostViewModel: ObservableObject {
    @Published var posts: [PostEntity] = []

    func fetchPosts(context: NSManagedObjectContext) {
        do {
            posts = try context.fetch(PostEntity.fetchRequest())
        } catch {
            print("Error fetching posts: \(error)")
        }
    }
}
