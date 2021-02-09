// Swift in 100 days
// Alejandro Gleason - CS Student
// http://gleason-portafolio.herokuapp.com

import Cocoa

var str1 =  """
This goes
over multiple
lines
"""

// Now we can do the same, but without line breaks

var str2 = """
This goes \
over multiple \
lines
"""

var pi = 3.141 // Double type
var awesome = true // Boolean type (both automatically assigned)

var str = "Pi is equal to \(pi)"

// Explicit type declaration
let album: String = "Reputation"
let height: Double = 1.78

let john = "John Lennon"
let paul = "Paul McCartney"
let george = "George Harrison"
let ringo = "Ringo Starr"

let beatles: [String] = [john, paul, george, ringo]

beatles[1]

let colors = Set(["red", "blue", "green"])

var name = (first: "Taylor", last: "Swift")
name.0
name.first

let heights = [
    "Taylor Swift": 1.78,
    "Justib Bieber": 1.90
]

print(beatles[1...])

heights["Taylor Swidft", default: -1 ]

var teams = [String: String]()
teams["Paul"] = "Red"

var results = [Int]()

var words = Set<String>()

enum Result {
    case success
    case failure
}

let result1 = Result.success

enum Activity {
    case runnning(destination: String)
    case talking(topic: String)
    case talking(volume: Int)
}

let talking = Activity.talking(volume: 10)

enum Planet: Int {
    case mercury = 1
    case venus
    case mars
}

let earth = Planet(rawValue: 2)

var fibonacci = (1, 1, 2, 3, 5, 8)

fibonacci.4

var lotteryNumbers = Set([11, 23, 44])

let a = 5 + 5.0

let b: Int = 5
let c: Double = 5.0

// let d = a + b This would fail bc they are diff data types

let meaningOfLife = 42

enum Sizes: Comparable {
    case small
    case medium
    case large
}

let first = Sizes.small
let second = Sizes.large
print(first < second)

let firstCard = 11
let secondCard = 11

if (firstCard + secondCard == 21) {
    print("Blackjack!")
} else {
    print("You loose")
}

print(firstCard == secondCard ? "Cards are the same" : "Cards are different")

let weather = "rain"

switch weather {
case "rain":
    print("Bring an umbrella")
case "sunny":
    print("Wear sunscreen")
    fallthrough
default:
    print("Enjoy your day!")
}

let score = 100

switch score {
case 0...59:
    print("You failed")
case 60..<100:
    print("You passed")
default:
    print("What a joy! You got 100")
    break
}

var vals = [10,2]

vals.sort{ (s1, s2) -> Bool in
    s1 > s2
}

let names = ["Larry", "Sven", "Bear"]

let count = 1...10

for number in count {
    print("Number is \(number)")
}

for name in names {
    print(name)
}

let range = 1...3

for num in range {
    print(num)
}

var number = 1

repeat {
    print(number)
    number += 1
} while number <= 20

outerLoop: for i in 1...10{
    for j in 1...10 {
        let product = i * j
        print("\(i) * (j) is \(product) ")
        if product == 50 {
            print("It's a bullseye!")
            break outerLoop
        }
    }
}
