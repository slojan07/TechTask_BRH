//
//  OfflinePostDetailsView.swift
//  TechTask_BRH
//
//  Created by wiljan S on 9/25/23.
//

import SwiftUI
import CoreData
import SwiftUI

struct OfflinePostDetailsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject private var viewModel: OfflinePostDetailsViewModel
    @Environment(\.presentationMode) var presentationMode // Add this line

    init(post: PostEntity, viewContext: NSManagedObjectContext) {
        self.viewModel = OfflinePostDetailsViewModel(viewContext: viewContext, post: post)
    }

    var body: some View {
        VStack(alignment: .center) {
            Text(viewModel.post.title ?? "")
                .font(.title)
            
            Text(viewModel.post.body ?? "")
                .font(.body)
            
            Divider()
                .padding()
            
            Button(action: {
                viewModel.deletePost()
                presentationMode.wrappedValue.dismiss()
            }) {
                Label("Remove from Offline", systemImage: "minus")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .navigationBarTitle("Post Details")
    }
}

