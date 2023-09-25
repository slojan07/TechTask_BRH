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
        VStack(alignment: .leading) {
            Text(post.title ?? "")
                .font(.title)
            
            Text(post.body ?? "")
                .font(.body)
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding()
            .navigationBarTitle("Post Details")
    }
       
}
