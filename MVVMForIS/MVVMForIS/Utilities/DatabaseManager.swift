//
//  DatabaseManager.swift
//  MVVMForIS
//
//  Created by Hamza on 3/14/22.
//

import Foundation
import CoreData

class DatabaseManager: NSObject {
    static let sharedInstance = DatabaseManager()
    private override init() {}
    
    var fetchedhResultController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Item.self))
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.sharedInstance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }()
    
    func getList() -> [Item]? {
        do {
            try self.fetchedhResultController.performFetch()
            return self.fetchedhResultController.fetchedObjects as? [Item]
        } catch let error {
            print(error)
        }
        return nil
    }
    
    func saveInCoreDataWith(array: [[String: AnyObject]]) {
        _ = array.map{self.createItemEntityFrom(dictionary: $0)}
        do {
            try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
            //try self.fetchedhResultController.performFetch()
            //return self.fetchedhResultController.fetchedObjects as? [Item]
        } catch let error {
            print(error)
        }
        //return nil
    }
    
    func createItemEntityFrom(dictionary: [String: AnyObject]) -> NSManagedObject? {
        
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        if let itemEntity = NSEntityDescription.insertNewObject(forEntityName: "Item", into: context) as? Item {
            itemEntity.name = dictionary["name"] as? String
            itemEntity.price = dictionary["price"] as? NSNumber
            itemEntity.itemDescription = dictionary["description"] as? String
            itemEntity.identifier = dictionary["id"] as? UUID
            itemEntity.itemRate = dictionary["itemRate"] as? NSNumber
            return itemEntity
        }
        return nil
    }
    
    func clearData() {
        do {
            
            let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Item.self))
            do {
                let objects  = try context.fetch(fetchRequest) as? [NSManagedObject]
                _ = objects.map{$0.map{context.delete($0)}}
                CoreDataStack.sharedInstance.saveContext()
            } catch let error {
                print("ERROR DELETING : \(error)")
            }
        }
    }
    
}
