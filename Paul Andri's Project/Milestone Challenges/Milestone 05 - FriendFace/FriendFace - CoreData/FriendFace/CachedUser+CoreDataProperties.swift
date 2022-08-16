//
//  CachedUser+CoreDataProperties.swift
//  FriendFace
//
//  Created by Paul Andri on 08/16/2022.
//
//
// "CachedUser" 'NSManagedObject' PUBLIC SUBCLASS EXTENSIONS


import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var about: String?
    @NSManaged public var address: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: String?
    @NSManaged public var friends: NSSet?
    
    
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
    
    public var wrappedCompany: String {
        company ?? "Unknown Company"
    }
    
    public var wrappedEmail: String {
        email ?? "-"
    }
    
    public var wrappedAddress: String {
        address ?? "-"
    }
    
    public var wrappedAbout: String {
        about ?? "-"
    }
    
    public var wrappedDate: Date {
        registered ?? Date()
    }
    
    var registeredDate: String {
        wrappedDate.formatted(date: .long, time: .omitted)
    }
    
    public var wrappedTags: String {
        tags ?? ""
    }
    
    var friendsArray: [CachedFriend] {
        let friendList = friends as? Set<CachedFriend> ?? []
        // SORT 'friendList' SET ITEMS BY 'wrappedName' STRING VALUE
        return friendList.sorted {
            // ASCENDING ORDER
            $0.wrappedName < $1.wrappedName
        }
    }

}

// MARK: Generated accessors for friends
extension CachedUser {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: CachedFriend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: CachedFriend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension CachedUser : Identifiable {

}
