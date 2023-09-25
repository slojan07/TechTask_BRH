//
//  OfflinePostDetailsView.swift
//  TechTask_BRH
//
//  Created by wiljan S on 9/25/23.
//

import Foundation
import SwiftUI
import CoreData

struct OfflinePostDetailsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    let post: PostEntity
    var body: some View {
        VStack(alignment: .center) {
            Text(post.title ?? "")
                .font(.title)
            
            Text(post.body ?? "")
                .font(.body)
            
            
            Divider()
                .padding()
            Button(action: {
                
                deletesavedItem()
               }) {
                Label("Remove from Offline", systemImage: "minus")
                   // .foregroundColor(.red)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
                    
            }
            
        } .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
           
            .navigationBarTitle("Post Details")
    }
    
    
    func deletesavedItem() {
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
       
}
