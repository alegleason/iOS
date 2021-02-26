import UIKit

func calculateArea(length: Int, width: Int) -> Int {
    return length * width
}

let shape1 = calculateArea(length: 5, width: 4)
let shape2 = calculateArea(length: 6, width: 2)
let shape3 = calculateArea(length: 4, width: 4)

var bankAccountBalance = 500.00
var sigourneyWeaverAlientStomperShoes = 350.00

/*
func purchaseItem(currentBalance: Double, itemPrice: Double) -> Double {
    if itemPrice <= currentBalance {
        print("Purchased item for: $\(itemPrice)")
        return currentBalance - itemPrice
    } else {
        print("You are broke. You should learn how to save money.")
        return currentBalance
    }
}

let newBalance = purchaseItem(currentBalance: bankAccountBalance, itemPrice: sigourneyWeaverAlientStomperShoes)

*/

func purchaseItem(currentBalance: inout Double, itemPrice: Double){
    if itemPrice <= currentBalance {
        currentBalance = currentBalance - itemPrice
        print("Purchased item for: $\(itemPrice)")
    } else {
        print("You are broke. You should learn how to save money.")
    }
}
print("Prev balance \(bankAccountBalance)")
purchaseItem(currentBalance: &bankAccountBalance, itemPrice: sigourneyWeaverAlientStomperShoes)
print("After balance \(bankAccountBalance)")

var retroLunchBox = 40.00
purchaseItem(currentBalance: &bankAccountBalance, itemPrice: retroLunchBox)

func fizzBuzz() {
    for i in 1...100 {
        if (i % 3 == 0 && i % 5 == 0){
            print("FizzBuzz")
        } else if (i % 3 == 0) {
            print("Fizz")
        } else if (i % 5 == 0){
            print("Buzz")
        }else{
            print(i)
        }
    }
}

fizzBuzz()

