import UIKit

/*:
 ### Code Example
 */

var age = 15 //Integer
var price = 10.99 // Double

var personAge: Int = 15
var thePrice: Double = 10.99


var length = 10
var width = 5

let area = length * width // Multiplication

var health = 100
var poisonDamage = 15
health = health - poisonDamage // Subtraction

health -= poisonDamage // Compound assignment operator

var potion = 20
health += potion // Addition (Compound assignment operator)
health = health + potion // Addition


var students = 30
var treats = 500
let treatsPerStudent = treats / students // Division

let remainder = treats % students // Modulo (remainder) operator


var tLength: Double = 10
var tWidth: Double = 5

//a^2 + b^2 = c^2
let areaTriangle = sqrt(pow(tLength, 2) + pow(tWidth, 2))

/*:
 ### Exercise
 
 Consider this scenario: You have a shopping cart with 6 items in it.  The total price of all the items combined is $78.50
 You have a coupon that gets you 25% off of the total price.
 After the coupon is applied, taxes will be applied at a rate of 7.75% of the total cost (cost after coupon).
 
 1. Create 6 different constants that represent the price of each item
 2. Perform addition operations to get the total price of all 6 items and store it in a constant ($78.50)
 3. Create a constant for the 25% coupon
 4. Create a constant called `priceAfterDiscount` and store the total price after the 25% discount has been applied (should equal around $58.87)
 5. Create a constant called `taxes` that stores the total taxes to be charged using the tax rate (should equal around $4.56)
 5. Create a constant called `finalPrice` that applies the 7.75% tax rate to priceAfterDicscount.  (should equal around $63.43)
 */
var pPears = 10.00
var pApples = 12.50
var pHoney = 15.00
var pHoodie = 26.00
var pCereal = 5.00
var pJam = 10.00

let totalCount = pPears+pApples+pHoney+pHoodie+pCereal+pJam
print(totalCount)

let pCoupon = 0.25
let priceAfterDiscount = totalCount * (1-pCoupon)
let taxes = priceAfterDiscount * 0.0775
let finalPrice = Double(round(100*(priceAfterDiscount + taxes))/100) // Swift way of rounding
