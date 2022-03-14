//
//  Item+CoreDataProperties.swift
//  MVVMForIS
//
//  Created by Hamza on 3/14/22.
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item");
    }

    @NSManaged public var identifier: UUID?
    @NSManaged public var name: String?
    @NSManaged public var itemDescription: String?
    @NSManaged public var itemRate: NSNumber?
    @NSManaged public var price: NSNumber?

}
