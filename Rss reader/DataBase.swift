//
//  DataBase.swift
//  Rss reader
//
//  Created by Даша Волошина on 3.02.23.
//


import Foundation
import CoreData

class NewsCoreData {
    
    static let shared  = NewsCoreData()
    var context: NSManagedObjectContext {return persistentContainer.viewContext}
    init(){}
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Rss reader")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    func saveContext () {
        let context = persistentContainer.viewContext
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

extension NSManagedObject {
    convenience init(context: NSManagedObjectContext) {
        let name = String(describing: type(of: self))
        let entity = NSEntityDescription.entity(forEntityName: name, in: context)!
        self.init(entity: entity, insertInto: context)
    }
    
}
