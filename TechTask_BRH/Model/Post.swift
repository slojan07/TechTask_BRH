//
//  Post.swift
//  TechTask_BRH
//
//  Created by wiljan S on 9/24/23.
//

import Foundation

public struct Post: Identifiable, Decodable {

    public var id: Int
    var title: String
    var body: String
   
}
