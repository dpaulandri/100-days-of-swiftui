//
//  Candy+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Paul Andri on 08/14/2022.
//
//
// PART OF DAY 58 MATERIALS: "ONE-TO-MANY" DATA RELATIONSHIP IN COREDATA
// 'NSManagedObject' "Candy" PUBLIC SUBCLASS EXTENSIONS

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Country?

    
    // WORKAROUND TO ELIMINATE THE NEED TO USE '??' IN PLACES WHERE 'CoreData's MANAGED OBJECT IS USED:
    // PUBLIC COMPUTED PROPERTIES TO USE IN PLACE OF THE '@NSManaged' OBJECTS ABOVE
    // GREAT FOR CODE MAINTAINABILITY (UPDATE DEFAULT VALUES IN ONE PLACE)
    public var wrappedCandyName: String {
        name ?? "Unknown Camdy"
    }
}

extension Candy : Identifiable {

}
