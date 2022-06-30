// Created by Paul Andri on 30/06/2022

import UIKit


// Day 15 - SWIFT REVIEW

// ACCESS CONTROL
/* FOUR most common options for Access Control inside Structs:
 - `private' “DON’T let anything OUTSIDE the Struct use this.”
 - 'private(set)' “anything OUTSIDE the Struct CAN READ this, BUT DON’T let them CHANGE it.”
 - `fileprivate` “DON’T let anything OUTSIDE the CURRENT file USE this.”
 - `public` “LET anyone, anywhere USE this.”
 */

//Ex: A BankAccount Struct w/ Access Control to its Property
struct BankAccount {
    private(set) var funds = 0  // 'private(set)' Access Control
    
    mutating func deposit(amount: Int) {
        funds += amount
    }
    
    mutating func withdraw(amount: Int) -> Bool {
        if funds > amount {
            funds -= amount
            return true
        } else {
            return false
        }
    }
}
/* CODE COMMENT:
 'private(set)':  READING 'funds' from OUTSIDE the Struct is FINE BUT WRITING ISN’T POSSIBLE.
 */
