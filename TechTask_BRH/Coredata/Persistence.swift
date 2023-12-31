//
//  Persistence.swift
//  TechTask_BRH
//
//  Created by wiljan S on 9/24/23.
//

import CoreData

struct PersistenceController {

    static let shared = PersistenceController()
    var container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        
        container = NSPersistentContainer(name: "TechTask_BRH")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
               
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        
    }
}
