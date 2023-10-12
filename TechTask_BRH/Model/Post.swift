//
//  Post.swift
//  TechTask_BRH
//
//  Created by wiljan S on 9/24/23.
//

import Foundation
import CoreData

struct Post: Identifiable, Decodable, CommonPost {
    public var id: Int
    var title: String
    var body: String
}



protocol CommonPost {
    var id: Int { get }
    var title: String { get }
    var body: String { get }
}



