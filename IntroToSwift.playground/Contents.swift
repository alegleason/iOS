// Swift in 100 days
// Alejandro Gleason - CS Student
// http://gleason-portafolio.herokuapp.com


let str = "5"
let num = Int(str)!

let birthYear: Int? = 10
let year = birthYear ?? 1
print(year)

let legoBricksSold: Int? = 400_000_000_000
let numberSold = legoBricksSold!

func title(for page: Int) -> String? {
    guard page >= 1 else {
        return nil
    }
    let pageCount = 132
    if page < pageCount {
        return "Page \(page)"
    } else {
        return nil
    }
}
let pageTitle = title(for: 16)!


let age: Int! = nil

let jeansNumber: Int? = nil
let jeans = jeansNumber ?? nil

struct Person {
    var id: String

    init?(id: String) {
        if id.count == 9 {
            self.id = id
        } else {
            return nil
        }
    }
}

let person: Person? = Person(id: "abc")


