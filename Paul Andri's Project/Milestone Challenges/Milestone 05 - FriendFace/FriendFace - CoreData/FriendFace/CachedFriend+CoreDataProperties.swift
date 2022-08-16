//
//  CachedFriend+CoreDataProperties.swift
//  FriendFace
//
//  Created by Paul Andri on 08/16/2022.
//
//
// "CachedFriend" 'NSManagedObject' PUBLIC SUBCLASS EXTENSIONS

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var user: CachedUser?

    
    // WORKAROUND TO ELIMINATE THE NEED TO USE '??' IN PLACES WHERE 'CoreData's MANAGED OBJECT IS USED:
    // PUBLIC COMPUTED PROPERTIES TO USE IN PLACE OF THE '@NSManaged' OBJECTS ABOVE
    // GREAT FOR CODE MAINTAINABILITY (UPDATE DEFAULT VALUES IN ONE PLACE)
    public var wrappedID: String {
        id ?? "Unknown ID"
    }
    
    public var wrappedName: String {
        name ?? "Unknown"
    }
    
    public var firstName: String {
        let components = wrappedName.components(separatedBy: " ")
        let first = components[0]
        return first
    }
}

extension CachedFriend : Identifiable {

}
