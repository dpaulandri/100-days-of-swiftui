//
//  Movie+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Paul Andri on 08/13/2022.
//
//
// 'NSManagedObject' "Movie" PUBLIC SUBCLASS EXTENSIONS

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    // '@NSManaged' IS NOT A PROPERTY WRAPPER & "PROPERTIES" BELOW IS NOT REAL PROPERTIES
    // '@NSManaged' IS A DICTIONARY TO READ/WRITE THE "Movie" SUBCLASS VALUES FROM
    // HOW COREDATA WORKS INTERNALLY:
    /*
     Rather than those Values actually existing as Properties in the Class,
     they are really just there to read and write from a Dictionary that CoreData uses to store its information.
     When we read or write the Value of a Property that is '@NSManaged',
     CoreData catches that and handles it internally – it’s far from a simple Swift String.
    */
    @NSManaged public var title: String?
    @NSManaged public var director: String?
    @NSManaged public var year: Int16

    
    
    // WORKAROUND TO ELIMINATE THE NEED TO USE '??' IN PLACES WHERE 'CoreData's MANAGED OBJECT IS USED:
    // PUBLIC COMPUTED PROPERTIES TO USE IN PLACE OF THE '@NSManaged' OBJECTS ABOVE
    // GREAT FOR CODE MAINTAINABILITY (UPDATE DEFAULT VALUES IN ONE PLACE)
    public var wrappedTitle: String {
        title ?? "Unknown Title"
    }
    
    public var wrappedDirector: String {
        director ?? "Unknown Director"
    }
    
}

extension Movie : Identifiable {

}
