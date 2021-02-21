// Swift in 100 days
// Alejandro Gleason - CS Student
// http://gleason-portafolio.herokuapp.com

var name: String

name = "Tim"


func yearAlbumReleased(name: String) -> Int? {
    if name == "Taylor Swift" { return 2006 }
    if name == "Fearless" { return 2008 }
    if name == "Speak Now" { return 2010 }
    if name == "Red" { return 2012 }
    if name == "1989" { return 2014 }

    return nil
}

var year = yearAlbumReleased(name: "RedD")

if let unwrapped = year {
    print("It was released in \(unwrapped)")
} else {
    print("There was an error")
}

struct Person {
    var clothes: String {
        willSet {
            updateUI(msg: "I'm changing from \(clothes) to \(newValue)")
        }

        didSet {
            updateUI(msg: "I just changed from \(oldValue) to \(clothes)")
        }
    }
}

func updateUI(msg: String) {
    print(msg)
}

var taylor = Person(clothes: "T-shirts")
taylor.clothes = "short skirts"


func travel(action: (String) -> Void) {
    print("I'm getting ready to go.")
    action("London")
    print("I arrived!")
}

travel { (place: String) -> Void in
    print("I'm going to \(place) in my car")
}

// Declare an empty dict
var myDict = [String:String]()
myDict["saludo"] = "whatever_object"
print(myDict["saludo"]!)


