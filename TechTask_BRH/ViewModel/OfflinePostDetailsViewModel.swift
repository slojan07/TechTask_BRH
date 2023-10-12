//
//  OfflinePostDetailsViewModel.swift
//  TechTask_BRH
//
//  Created by wiljan S on 10/12/23.
//


import Foundation
import CoreData
import SwiftUI

class OfflinePostDetailsViewModel: ObservableObject {
    private var viewContext: NSManagedObjectContext
    @Published var post: PostEntity

    init(viewContext: NSManagedObjectContext, post: PostEntity) {
        self.viewContext = viewContext
        self.post = post
    }

    func deletePost() {
        viewContext.delete(post)
        do {
            try viewContext.save()
        } catch {
            print("Error deleting post: \(error.localizedDescription)")
        }
    }
}


