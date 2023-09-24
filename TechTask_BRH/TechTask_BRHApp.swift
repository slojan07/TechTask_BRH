//
//  TechTask_BRHApp.swift
//  TechTask_BRH
//
//  Created by wiljan S on 9/24/23.
//

import SwiftUI

@main
struct TechTask_BRHApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var postsViewModel = PostsViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: postsViewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
