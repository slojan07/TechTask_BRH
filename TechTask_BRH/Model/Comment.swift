//
//  Comment.swift
//  TechTask_BRH
//
//  Created by wiljan S on 9/25/23.
//

import Foundation

struct Comment: Identifiable, Decodable, Equatable {
    var id: Int
    var postId: Int
    var name: String
    var email: String
    var body: String
    var notes: String
}



