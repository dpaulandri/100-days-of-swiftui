import UIKit


//CHECKPOINT 8

/*
 Your challenge is this:
 1. Make a Protocol that describes a building, adding various Properties and Methods,
 2. Create two Structs, `House` and `Office`, that conform to it.
 
 Your Protocol should require the following:
 
 1. A Property storing how many rooms it has.
 2. A Property storing the cost as an Integer (e.g. 500,000 for a building costing $500,000.)
 3. A Property storing the name of the estate agent responsible for selling the building.
 4. A Method for printing the sales summary of the building, describing what it is along with its other properties.
 */


//Paul Andri's Solution for Checkpoint 8
protocol Building {
    var room: Int { get set } //# of 'room' could change
    var cost: Int { get set } //'cost' value might rise or fall
    var agentName: String { get set } //Multiple Agent could be hold the same Property
    
    func printSales ()
}

struct House: Building {
    var room: Int
    var cost: Int
    var agentName: String
    
    func printSales() {
        print("This \(room)-room House was sold by Agent \(agentName) for $\(cost)")
    }
}

struct Office: Building {
    var room: Int
    var cost: Int
    var agentName: String
    
    func printSales() {
        print("This \(room)-room Office was sold by Agent \(agentName) for $\(cost)")
    }
}

let houseSale1 = House(room: 2, cost: 250_000, agentName: "Mr. Tumbler")
houseSale1.printSales()
//Prints: "This 2-room House was sold by Agent Mr. Tumbler for $250000"

let officeSale1 = Office(room: 20, cost: 5_500_000, agentName: "Mrs. Hubble")
officeSale1.printSales()
//Prints: "This 20-room Office was sold by Agent Mrs. Hubble for $5500000"
