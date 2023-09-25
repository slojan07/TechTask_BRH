//
//  ContentView.swift
//  TechTask_BRH
//
//  Created by wiljan S on 9/24/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @ObservedObject var viewModel: PostsViewModel
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \PostEntity.id, ascending: false)],
        animation: .default)
    var postitems: FetchedResults<PostEntity>

    var body: some View {
        TabView {
            NavigationView {
               PostListView(viewModel: viewModel)
            }
            .tabItem {
                Label("Posts", systemImage: "list.bullet")
            }

            NavigationView {
                OfflinePostListView()
            }
            .tabItem {
                Label("Offline", systemImage: "arrow.down.circle")
                    
                   
            }
            .badge(postitems.count)
        }
    }
}
