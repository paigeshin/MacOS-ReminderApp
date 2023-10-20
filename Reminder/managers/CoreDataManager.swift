//
//  CoreDataManager.swift
//  Reminder
//
//  Created by paige shin on 10/20/23.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    
    private init() {
        
        ValueTransformer.setValueTransformer(NSColorTransformer(), forName: NSValueTransformerName("NSColorTransformer"))
        
        self.persistentContainer = NSPersistentContainer(name: "RemindersModel")
        self.persistentContainer.loadPersistentStores { desc, error in
            if let error {
                fatalError("Unable to initialize Core Data \(error)")
            }
        }
    }
    
}
