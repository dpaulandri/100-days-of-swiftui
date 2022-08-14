//
//  Country+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Paul Andri on 08/14/2022.
//
//
// PART OF DAY 58 MATERIALS: "ONE-TO-MANY" DATA RELATIONSHIP IN COREDATA
// 'NSManagedObject' "Country" PUBLIC SUBCLASS EXTENSIONS

import Foundation
import CoreData


extension Country {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }

    @NSManaged public var fullName: String?
    @NSManaged public var shortName: String?
    @NSManaged public var candy: NSSet?
    // 'NSSet' - An Objective-C Data Type equivalent to Swift’s 'Set' Data Type. Can't be use w/ 'ForEach'.

    
    // WORKAROUND TO ELIMINATE THE NEED TO USE '??' IN PLACES WHERE 'CoreData's MANAGED OBJECT IS USED:
    // PUBLIC COMPUTED PROPERTIES TO USE IN PLACE OF THE '@NSManaged' OBJECTS ABOVE
    // GREAT FOR CODE MAINTAINABILITY (UPDATE DEFAULT VALUES IN ONE PLACE)
    public var wrappedFullName: String {
        fullName ?? "Unknown Country"
    }
    
    public var wrappedShortName: String {
        shortName ?? "Unknown Country"
    }
    
    // DEFINE 'candyArray' CONTAINS AN ARRAY OF 'Candy' DATA TYPE
    public var candyArray: [Candy] {
        // CREATE A 'Set' DATA COMPUTED PROPERTY:
        // 'as?' - CONDITIONAL TYPE-CAST
        // TRY TO CONVERT 'candy' 'NSSet' OBJECT AS A 'Set' OF 'Candy' DATA TYPE
        let candySet = candy as? Set<Candy> ?? [] // RETURN AN EMPTY ARRAY IF FAILED
        
        // RETURN SORTED 'candySet' VALUE AS 'candyArray' COMPUTED VALUE
        return candySet.sorted {
            // SORT THE 'wrappedCandyName' ALPHABETICALLY
            $0.wrappedCandyName < $1.wrappedCandyName
        }
    }
}

// MARK: Generated accessors for candy
extension Country {

    @objc(addCandyObject:)
    @NSManaged public func addToCandy(_ value: Candy)

    @objc(removeCandyObject:)
    @NSManaged public func removeFromCandy(_ value: Candy)

    @objc(addCandy:)
    @NSManaged public func addToCandy(_ values: NSSet)

    @objc(removeCandy:)
    @NSManaged public func removeFromCandy(_ values: NSSet)

}

extension Country : Identifiable {

}
