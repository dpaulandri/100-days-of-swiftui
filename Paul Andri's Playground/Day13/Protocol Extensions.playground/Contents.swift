import UIKit


//PROTOCOL EXTENSIONS

//A String Array Constant
let guests = ["Mario", "Luigi", "Peach"]

//'if' Statement checking whether an Array has any values in it
if guests.isEmpty == false { //if 'guests' Array is NOT empty
    print("Guest count: \(guests.count)")
}
//Printt: "Guest count: 3"


//'if' Statement w/ Boolean NOT '!' Operator
if !guests.isEmpty { //if 'guests' Array is empty is NOT true
    print("Guest count: \(guests.count)")
}
//Printt: "Guest count: 3"


//Using the Extension to add a Property for Array Data Type
extension Array {
    //Add a new Variable 'isNotEmpty' Property w/ Bool Type Annotation
    var isNotEmpty: Bool {
        isEmpty == false //Default Implementation
        //set Swift's String Type 'isExmpty' Method Value equals 'false'
    }
}

//'if' Statement using Array's Extension
if guests.isNotEmpty { //'if' 'guests' Array 'isNotEmpty' is 'true'
    print("Guest count: \(guests.count)")
}
//Printt: "Guest count: 3"





//Create an Extension for Swift's built-in 'Collection' Protocol
//Array, Set, and Dictionary all conform to 'Collection' Protocol
extension Collection {
    //Add a new Variable 'isNotEmpty' Property w/ Bool Type Annotation
    var isNotEmpty: Bool {
        isEmpty == false //Default Implementation
        //set Swift's String Type 'isExmpty' Method Value equals 'false'
    }
}






//A simple Protocol w/ a Property & a Method
protocol Person {
    var name: String { get }
    func sayHello()
}


//Add Default Implementation (Value) for the Method of the Protocol above
extension Person {
    func sayHello() { //Add Default Implementation with { }
        print("Hi, I'm \(name)")
    }
}


//Create a new Struct Type that coonforms to 'Person' Protocol
//WITHOUT implementing its own custom 'sayHello()' Method
//Uses the Default Implementation of 'sayHello()' Method from the Protocol
struct Employee: Person {
    let name: String
}

let taylor = Employee(name: "Taylor Swift")
taylor.sayHello() //Print: "Hi, I'm Taylor Swift"








//OPTIONAL MATERIALS

//Create a Int Array
let numbers = [4, 8, 15, 16]
//Use Swift's Array 'allSatisfy' to test all items in the Array if they're EVEN numbers
let allEven = numbers.allSatisfy { $0.isMultiple(of: 2) }
print(allEven) //Print: "false"


//Create a Int Set
let numbers2 = Set([4, 8, 15, 16])
//Use Swift's Array 'allSatisfy' to test all items in the Array if they're EVEN numbers
let allEven2 = numbers2.allSatisfy { $0.isMultiple(of: 2) }
print(allEven2) //Print: "false"



//Create a Dictionary with String Key: Int Value
let numbers3 = ["four": 4, "eight": 8, "fifteen": 15, "sixteen": 16]
let allEven3 = numbers3.allSatisfy { $0.value.isMultiple(of: 2) }
print(allEven3) //Print: "false"
