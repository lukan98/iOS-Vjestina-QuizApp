//
//  CoreDataStack.swift
//  QuizApp
//
//  Created by Luka Namačinski on 29.05.2021..
//

import CoreData

class CoreDataStack {
    
    static var sharedStacks: [String:CoreDataStack] = [:]

    private let modelName: String

    lazy var managedContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()

    private init(modelName: String) {
        self.modelName = modelName
    }

    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores() { storeDescription, error in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    static func getStackFor(modelName: String) -> CoreDataStack {
        if let sharedStack = sharedStacks[modelName] {
            return sharedStack
        } else {
            let newStack = CoreDataStack(modelName: modelName)
            sharedStacks[modelName] = newStack
            return newStack
        }
    }

    func saveContext () {
        guard managedContext.hasChanges else { return }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }

}
