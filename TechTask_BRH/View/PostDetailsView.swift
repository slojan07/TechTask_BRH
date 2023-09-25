//
//  PostDetailsView.swift
//  TechTask_BRH
//
//  Created by wiljan S on 9/25/23.
//

import Foundation
import SwiftUI
import CoreData


struct PostDetailsView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    let post: Post
    @StateObject var viewModel = PostsViewModel()
    @State private var showComments = false
    @State private var isSavedOffline: Bool = false
    var body: some View {
        VStack {
            Text(post.title)
                .font(.headline)
            
            Text(post.body)
                .font(.body)
                .padding()
            
            Button(action: {
                if isSavedOffline {
                    deleteItems()
                } else {
                    addItem()
                }
                isSavedOffline = !isSavedOffline
            }) {
                Label(isSavedOffline ? "Remove from Offline" : "Save To Offline", systemImage: isSavedOffline ? "minus" : "plus")
                    .foregroundColor(.white)
                    .padding()
                    .background(isSavedOffline ? .red : .green)
                    .cornerRadius(10)
            }
            
            Divider()
                .padding()
            
            Button(action: {
                showComments = true
                
            }) {
                Text("View Comments")
                
                    .foregroundColor(.white)
                    .padding()
                    .background(.blue)
                    .cornerRadius(10)
                    
            }
            .sheet(isPresented: $showComments) {
                
                CommentListView(postId: post.id)
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding()
        .navigationBarTitle("Post Details")
        .onAppear {
            isSavedOffline = isPostSavedOffline()
        }
    }
    
    func addItem() {
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
    
    func deleteItems() {
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
    
    func isPostSavedOffline() -> Bool {
        
        
        let fetchRequest: NSFetchRequest<PostEntity> = PostEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %ld", post.id)
        
        do {
            let items = try viewContext.fetch(fetchRequest)
            return !items.isEmpty 
        } catch {
            print("Error checking if item exists: \(error.localizedDescription)")
            return true
        }
    }
    
}


