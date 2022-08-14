//
//  Singer+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Paul Andri on 08/14/2022.
//
//
// PART OF DAY 58 MATERIALS: DYNAMIC '@FetchRequest' FILTERING W/ SWIFTUI
// 'NSManagedObject' "Singer" PUBLIC SUBCLASS EXTENSIONS

import Foundation
import CoreData


extension Singer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Singer> {
        return NSFetchRequest<Singer>(entityName: "Singer")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?

    
    // WORKAROUND TO ELIMINATE THE NEED TO USE '??' IN PLACES WHERE 'CoreData's MANAGED OBJECT IS USED:
    // PUBLIC COMPUTED PROPERTIES TO USE IN PLACE OF THE '@NSManaged' OBJECTS ABOVE
    // GREAT FOR CODE MAINTAINABILITY (UPDATE DEFAULT VALUES IN ONE PLACE)
    public var wrappedFirstName: String {
        firstName ?? "Unknown"
    }
    
    public var wrappedLastName: String {
        lastName ?? "Unknown"
    }
}

extension Singer : Identifiable {

}
