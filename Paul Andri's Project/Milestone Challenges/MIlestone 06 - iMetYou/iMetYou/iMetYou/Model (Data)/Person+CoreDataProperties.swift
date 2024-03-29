//
//  Person+CoreDataProperties.swift
//  iMetYou
//
//  Created by Paul Andri on 09/14/2022.
//
//

import Foundation
import CoreData
import CoreLocation
import MapKit


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var date: Date?
    @NSManaged public var email: String?
    @NSManaged public var firstName: String?
    @NSManaged public var gender: String?
    @NSManaged public var id: UUID?
    @NSManaged public var lastName: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var phoneNumber: String?

	
	// COMPUTED PROPERTIES W/ DEFAULT VALUES
	var wrappedID: String {
		id?.uuidString ?? "Unknown ID"
	}
	
	var wrappedfirstName: String {
		firstName ?? "Unknown"
	}
	
	var wrappedLastName: String {
		lastName ?? "Unknown"
	}
	
	var fullName: String {
		"\(wrappedfirstName) \(wrappedLastName)"
	}
	
	var wrappedPhoneNumber: String {
		phoneNumber ?? "N/A"
	}
	
	var wrappedGender: String {
		gender ?? "Not Specified"
	}
	
	var wrappedDate: String {
		String(date?.formatted(date: .long, time: .omitted) ?? "Not Specified")
	}
	
	var wrappedEmail: String {
		email ?? "N/A"
	}
}

extension Person : Identifiable {

}
