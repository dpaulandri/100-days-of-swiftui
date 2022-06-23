import UIKit


//ACCESS CONTROL

//STRUCT w/ NO ACCESS CONTROL
//Ex: Struct with Methods to deposit & withdraw money from a Bank Account
struct BankAccount {
    var funds = 0 //a 'var' Property w/ default Value 0
    //'funds' Property is very IMPORTANT in a banking system and should be PROTECTED from illegal access
    //This Property is exposed to external access
    //NOTHING IS STOPPING OTHER FROM TOUCHING IT
    
    mutating func deposit(amount: Int) { //Mutating Method
        funds += amount //Modify 'fund' Property value
    }
    
    mutating func withdraw(amount: Int) -> Bool { //Mutating Method, returns 'Bool' value
        if funds >= amount { //If 'funds' Property value is MORE or EQUAL the value of 'amount'
            funds -= amount //Modify 'fund' Property value
            return true //Returns 'true' Bool to Method
        } else { //else
            return false //Returns 'false' Bool to Method
        }
    }
}

//an Empty 'var' Instance created from 'BankAccount' Struct
var account = BankAccount()

//Initializer for 'deposit' mutating Method for 'account' Instance
account.deposit(amount: 100)

//a 'let Instance
let success = account.withdraw(amount: 200) //Initializer for 'withdraw' mutating Method

if success { //If 'success' value if 'true'
    print("Withdrew money successfully")
} else { //else <- This will RUN
    print("Failed to get the money")
}
//Result: "Failed to get the money"

//Accessing & "Tampering" the 'funds' Property externally OUTSIDE the Struct
account.funds -= 1000
print(account.funds) //Result: -900

account.funds += 1_000_000
print(account.funds) //Result: 999100

account.funds += 1_000_000_000
print(account.funds) //Result: 1000999100


//
private var funds = 0




//SECURED BANK STRUCT w/ ACCESS CONTROL

//Using 'private' Access Control
struct SecuredBankAccount {
    private var funds = 0 //a 'var' Property w/ default Value 0
    //'private' Access Control meant: “don’t let anything OUTSIDE the STRUCT use this.”
    //By having 'private' on the Property's loc, we protect it from any attempt of accesing OUTSIDE the Struct
   
    
    mutating func deposit(amount: Int) { //Mutating Method
        funds += amount //Modify 'fund' Property value
    }
    
    mutating func withdraw(amount: Int) -> Bool { //Mutating Method, returns 'Bool' value
        if funds >= amount { //If 'funds' Property value is MORE or EQUAL the value of 'amount'
            funds -= amount //Modify 'fund' Property value
            return true //Returns 'true' Bool to Method
        } else { //else
            return false //Returns 'false' Bool to Method
        }
    }
}

//ATTEMPT TO HACK 'funds' Property inside 'SecuredBankAccount' Struct
//Create an Empty 'var' Instance created from 'BankAccount' Struct
var attemptHacking = SecuredBankAccount()

//Attempting to TAMPER the 'funds' Property Value by accessing OUTSIDE the Struct
//attemptHacking.funds += 1_000_000
//Swift Error: 'funds' is inaccessible due to 'private' protection level


//Using 'private(set) Access Control
struct PrivateSetdBankAccount {
    private(set) var funds = 0 //a 'var' Property w/ default Value 0
    //'private(set)' Access Control meant: “let ANYONE READ this Property, but ONLY let my Methods WRITE it.”
    //By having 'private(set)' on the Property's loc, we could PRINT 'funds' OUTSIDE of the Struct, BUT ONLY 'deposit()' and 'withdraw()' Methods could actually CHANGE its VALUE.
   
    
    mutating func deposit(amount: Int) { //Mutating Method
        funds += amount //Modify 'fund' Property value
    }
    
    mutating func withdraw(amount: Int) -> Bool { //Mutating Method, returns 'Bool' value
        if funds >= amount { //If 'funds' Property value is MORE or EQUAL the value of 'amount'
            funds -= amount //Modify 'fund' Property value
            return true //Returns 'true' Bool to Method
        } else { //else
            return false //Returns 'false' Bool to Method
        }
    }
}

//ATTEMPT TO HACK 'funds' Property inside 'SecuredBankAccount' Struct
//Create an Empty 'var' Instance created from 'BankAccount' Struct
var attemptHacking2 = PrivateSetdBankAccount()

//We could READ & PRINT 'funds' Property from outside the Struct just fine
print(attemptHacking2.funds) //Result: 0

//Attempting to TAMPER the 'funds' Property Value by accessing OUTSIDE the Struct
//attemptHacking2.funds += 1_000_000
//Swift Error: 'Left side of mutating operator isn't mutable: 'funds' setter is inaccessible


/*Other Available Acces Controls:
 - `fileprivate`: “don’t let anything OUTSIDE the CURRENT FILE use this.”
 - `public`: “let ANYONE, ANYWHERE use this.”
*/
