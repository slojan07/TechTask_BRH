//
//  PostDetailsViewModel.swift
//  TechTask_BRH
//
//  Created by wiljan S on 10/12/23.
//

import Foundation
import SwiftUI
import CoreData

class PostDetailsViewModel: ObservableObject {
    
    @Published var post: Post
    @Published var isSavedOffline: Bool = false
    private let viewContext: NSManagedObjectContext
    
    init(post: Post, viewContext: NSManagedObjectContext) {
        self.post = post
        self.viewContext = viewContext
        isSavedOffline = isPostSavedOffline()
    }
    
    func toggleOfflineSave() {
        if isSavedOffline {
            deleteItem()
        } else {
            addItem()
        }
        isSavedOffline.toggle()
    }
    
  
    
    public func addItem() {
        
        let item = PostEntity(context: viewContext)
        item.id = Int64(post.id)
        item.title = post.title
        item.body = post.body
        
        do {
            try viewContext.save()
        } catch {
            print("Error saving item: \(error.localizedDescription)")
        }
    }
    
    public func deleteItem() {
        let fetchRequest: NSFetchRequest<PostEntity> = PostEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %ld", post.id)
        
        do {
            let items = try viewContext.fetch(fetchRequest)
            for item in items {
                viewContext.delete(item)
            }
            
            try viewContext.save()
        } catch {
            print("Error deleting item: \(error.localizedDescription)")
        }
    }
    
    private func isPostSavedOffline() -> Bool {
        
     
        let fetchRequest: NSFetchRequest<PostEntity> = PostEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %ld", post.id)

        do {
            let items = try viewContext.fetch(fetchRequest)
            return !items.isEmpty
        } catch {
            print("Error checking if item exists: \(error.localizedDescription)")
            return false
        }
    }
}
