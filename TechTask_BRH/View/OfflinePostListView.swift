//
//  OfflinePostListView.swift
//  TechTask_BRH
//
//  Created by wiljan S on 9/25/23.
//


import SwiftUI
import CoreData
import SwiftUI
struct OfflinePostListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var viewModel = OfflinePostViewModel()

    var body: some View {
      //  NavigationView {
            List(viewModel.posts, id: \.self) { postitem in
                NavigationLink(destination: OfflinePostDetailsView(post: postitem, viewContext: viewContext)) {
                    VStack(alignment: .leading) {
                        Text(postitem.title ?? "")
                            .font(.headline)
                            .frame(height: 30)

                        Text(postitem.body ?? "")
                            .font(.body)
                            .frame(height: 50)
                    }
                }
            }
            .navigationBarTitle("Offline Posts")
            .onAppear {
                viewModel.fetchPosts(context: viewContext)
            }
      //  }
    }
}

