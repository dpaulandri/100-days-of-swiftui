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
    @NSManaged public var id: UUID?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: String?
    @NSManaged public var friends: NSSet?
    
    
    // WORKAROUND TO ELIMINATE THE NEED TO USE '??' IN PLACES WHERE 'CoreData's MANAGED OBJECT IS USED:
    // PUBLIC COMPUTED PROPERTIES TO USE IN PLACE OF THE '@NSManaged' OBJECTS ABOVE
    // GREAT FOR CODE MAINTAINABILITY (UPDATE DEFAULT VALUES IN ONE PLACE)
    public var idUUID: UUID {
        id ?? UUID()
    }
    
    public var wrappedName: String {
        name ?? "Unknown"
    }
    
    private var nameComponents: [String] {
        wrappedName.components(separatedBy: " ")
    }
    
    public var firstName: String {
        nameComponents[0]
    }
    
    public var lastName: String {
        nameComponents[nameComponents.count - 1]
    }
    
    public var userInitials: String {
        let firstInit = firstName.trimmingCharacters(in: .lowercaseLetters)
        let lastInit = lastName.trimmingCharacters(in: .lowercaseLetters)
        let initials = firstInit + lastInit
        return initials

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
        
        // RETURN A SORTED ARRAY BASED ON 'wrappedName' STRING VALUE
        return Array(friendList.sorted {$0.wrappedName < $1.wrappedName})
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
