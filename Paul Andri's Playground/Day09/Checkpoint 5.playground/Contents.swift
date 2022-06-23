import UIKit
import Darwin


//CHECKPOINT 5
/* CHALLENGE DESCRIPTION
 You’ve already met `sorted()`, `filter()`, `map()`, so I’d like you to put them together in a chain – call one, then the other, then the other back to back without using temporary variables.

 Your input is this:
 let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

 Your job is to:
 1. Filter out any numbers that are even
 2. Sort the Array in ascending order
 3. Map them to strings in the format “7 is a lucky number”
 4. Print the resulting Array, one item per line

 So, your output should be as follows:

 7 is a lucky number
 15 is a lucky number
 21 is a lucky number
 31 is a lucky number
 33 is a lucky number
 49 is a lucky number
 */




/*SOLUTION 1
let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]
 
func printNumbers(_ numbers: ([Int])) -> Void {
    
    let filterNumber = numbers.filter { $0 % 2 != 0 }
    let sortNumber = filterNumber.sorted()
    
    for i in 0..<sortNumber.count {
        if i < sortNumber.count {
                print("\(sortNumber[i]) is a lucky number")
        }
    }
}

printNumbers(luckyNumbers)
*/



/*SOLUTION 2
let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

func filterNumbers(_ numbers: [Int]) -> [Int] {
    numbers.filter { $0 % 2 != 0 }
}

func sortNumbers(_ numbers: [Int]) -> [Int] {
    numbers.sorted()
}

func mapNumbers(_ numbers: [Int]) {
    for i in 0..<numbers.count {
        if i < numbers.count {
                print("\(numbers[i]) is a lucky number")
        }
    }
}


let filtered = filterNumbers(luckyNumbers)
let sorted = sortNumbers(filtered)
let result: () = mapNumbers(sorted)
*/


// SOLUTION 3






let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]


print(luckyNumbers.filter {$0.isMultiple(of: 2) == false}.sorted().map { print("\($0) is a lucky number")})
