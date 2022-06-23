import UIKit

//Convert Temperatured from Celsius to Fahrenheit.
//1. Creates a Constant holding any temperature in Celsius.
let celcius = 25.50

//2. Converts it to Fahrenheit by multiplying by 9, dividing by 5, then adding 32.
//Method 1
//let fahrenheit = celcius * 9 / 5 + 32

//Method 2
var fahrenheit = celcius * 9
fahrenheit /= 5
fahrenheit += 32


//3. Prints the result for the user, showing both the Celsius and Fahrenheit values.
print("The current temperature is \(celcius)°C or \(fahrenheit)°F")
