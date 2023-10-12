//
//  PostEntity+CoreDataProperties.swift
//  TechTask_BRH
//
//  Created by wiljan S on 9/25/23.
//
//

import Foundation
import CoreData


extension PostEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostEntity> {
        return NSFetchRequest<PostEntity>(entityName: "PostEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var body: String?

}

extension PostEntity : Identifiable {

}
