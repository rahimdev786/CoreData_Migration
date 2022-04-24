//
//  CoreData Stack.swift
//  CoreData_Migration
//
//  Created by arshad on 4/24/22.
//

import Foundation
import CoreData


final class PersistanceStore {
    
    static let shared:PersistanceStore = PersistanceStore()
    private init(){}
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "CoreData_Migration")
        
        let dec = NSPersistentStoreDescription()
        dec.shouldMigrateStoreAutomatically = true
        dec.shouldInferMappingModelAutomatically = true
        container.persistentStoreDescriptions = [dec]
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    
lazy var context = persistentContainer.viewContext
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    
}
