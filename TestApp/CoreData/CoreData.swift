//
//  CoreData.swift
//  TestApp
//
//  Created by Yulia Ignateva on 15.03.2023.
//

import UIKit
import CoreData

class CoreData {
    static let shared = CoreData()
    
    private init() {}
    
    lazy private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ModelCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var viewContext: NSManagedObjectContext { CoreData.shared.persistentContainer.viewContext }
}
