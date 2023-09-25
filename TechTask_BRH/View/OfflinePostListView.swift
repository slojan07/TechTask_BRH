//
//  OfflinePostListView.swift
//  TechTask_BRH
//
//  Created by wiljan S on 9/25/23.
//

import Foundation
import SwiftUI

struct OfflinePostListView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \PostEntity.id, ascending: true)],
        animation: .default)
    private var postitems: FetchedResults<PostEntity>

    var body: some View {
      
            List {
                ForEach(postitems) { postitem in
                    NavigationLink(
                        destination: OfflinePostDetailsView(post: postitem),
                        label: {
                            VStack(alignment: .leading) {
                                
                                Text(postitem.title ?? "")
                                    .font(.headline)
                                    .frame(height: 30)
                              
                                Text(postitem.body ?? "")
                                    .font(.body)
                                    .frame(height: 50)
                                

                            }
                        }
                           )
                }
            }
            .navigationBarTitle("Offline Posts")
    }

}

