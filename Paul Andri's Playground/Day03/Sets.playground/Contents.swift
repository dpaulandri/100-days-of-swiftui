import UIKit


//Sets are similar to Array, but:
//DOES NOT remember nor care about the exact order of the Array
//DOES NOT allow Duplicates, it automatically remove it

let actors = Set([ //Array is created within a Set "people"
    "Denzel Washington",
    "Tom Cruise",
    "Nicolas Cage",
    "Samuel L Jackson"
])

print(actors) //returns: random orders of the "people" values


//Inserting items into an empty var Set using ".insert"
var people = Set<String>()
people.insert("Denzel Washington")
people.insert("Tom Cruise")
people.insert("Nicolas Cage")
people.insert("Samuel L Jackson")

print(people) //returns: random orders of the "people" values


var bearFam = Set<String>()
bearFam.insert("Bear Bear")
bearFam.insert("Yab Yab")
bearFam.insert("Chut Chut")

print(bearFam)
