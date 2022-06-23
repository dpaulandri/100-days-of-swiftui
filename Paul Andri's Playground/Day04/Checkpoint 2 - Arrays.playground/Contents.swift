import UIKit


//THE CHALLENGE
//1. Create an array of strings,
//2. Write some code that prints the number of items in the array and also the number of unique items in the array.

let array = Set([
    "Mommy", "Daddy", "Noah", "Yab Chut", "Bear Chur", "Chut Chut", "Yab Chut"
])

print(array) //Set DON'T allow duplicates! "Yab Chut" will only be 1 entry
print(array.count) //result: 6
//counted 6 instead of 7, because Set DON'T allow duplicates
