import UIKit


//DEFAULT VALUES for PARAMTERES

//Print Time Table Function - w/o Default Values
func printTimesTables(for number: Int, end: Int) { //Parameters have no Default Values assigned
    for i in 1...end {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTables(for: 5, end: 20) //Arguments Values enter for both 'for' and 'end'



//Print Time Table Function - with Default Values
func printTimesTablesD(for number: Int, end: Int = 12) { // 'end: Int = 12' - the Default Va;ue
    for i in 1...end {
        print("\(i) x \(number) is \(i * number)")
    }
}
//Normal Function Calling method with both Argument values declared
printTimesTablesD(for: 5, end: 20)

//Function Calling with only 'for' value declared
//Swift will automatically used the Default Value of 'end: Int = 12'
printTimesTablesD(for: 8)





// .removeAll()
//Normal removeAll function
var characters = ["Lana", "Pam", "Ray", "Sterling"]
print(characters.count) //Returns: 4
characters.removeAll() //Clear off all items & free up all memory
print(characters.count) //Returns: 0

// removeAll(keepingCapacity: Bool) <-Default Value
// Remove all items in Array while keeping the previous Capacity (memory)
var charactersKeep = ["Lana", "Pam", "Ray", "Sterling"]
print(charactersKeep.count) //Returns: 4
charactersKeep.removeAll(keepingCapacity: true) //Clear off all items & DON'T free up memory
//(keepCapacity: Bool) is the Default Value for the .removeAll() function!!
print(charactersKeep.count) //Returns: 0





//OPTIONAL MATERIALS
//Ex: Route Finding Code w/ Default Values in all Parameters:
func findDirections(from: String, to: String, route: String = "fastest", avoidHighways: Bool = false) {
    // code here
}


//3 Different Ways to Call the Route Finding function & its used of Default Values
findDirections(from: "London", to: "Glasgow")
//Default Values used: 'route = "fastest", avoidHighways = false'

findDirections(from: "London", to: "Glasgow", route: "scenic")
//Default Values used: 'avoidHighways = false'

findDirections(from: "London", to: "Glasgow", route: "scenic", avoidHighways: true)
//Default Values used: NONE

