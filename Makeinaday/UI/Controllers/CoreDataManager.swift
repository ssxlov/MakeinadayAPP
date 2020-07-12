//
//  CoreDataManager.swift
//  Makeinaday
//
//  Created by Hazret Blyagoz on 06.07.2020.
//  Copyright © 2020 Hazret Blyagoz. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    // MARK: - StaticProperties
    static let entityName: String = "Model"
    static let shared = CoreDataManager()
    
    // MARK: - CoreData
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: CoreDataManager.entityName)
        container.loadPersistentStores(completionHandler: { (description, error) in
            print("store: \(description)")
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        self.persistentContainer.viewContext
    }
    // MARK: - Init
    init() { }
    
    // MARK: - Methods
    func deleteAll(entityName: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try persistentContainer.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            debugPrint(error)
        }
    }
}



