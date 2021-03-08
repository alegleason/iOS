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

class Shape {
    func calculateArea() -> Double {
        // Swift way to 'implement' abstract classes
        fatalError("Subclasses need to implement the `calculateArea()` method.")
    }
}

// Decided to implement the no parameter version (rather inits)
class Triangle: Shape {
    private(set) var base: Double
    private(set) var height: Double
    
    init(base: Double, height: Double) {
        self.base = base
        self.height = height
    }
    
    override func calculateArea() -> Double {
        return (base*height)/2
    }
    
    // Parameter version
    func calculatePerimeter(a: Double, b: Double, c: Double) -> Double {
        return a + b + c
    }
}

class Circle: Shape {
    private(set) var radius: Double
    let PI: Double = 3.1416
        
    init(radius: Double) {
        self.radius = radius
    }
    
    override func calculateArea() -> Double {
        return PI*radius*radius
    }
    
    func calculatePerimeter() -> Double {
        return 2 * PI * radius
    }
}

class Square: Shape {
    private(set) var side: Double
    
    init(side: Double) {
        self.side = side
    }
    
    override func calculateArea() -> Double {
        return side*side
    }
    
    func calculatePerimeter() -> Double {
        return 4*side
    }
}


var triangle = Triangle(base: 10, height: 20)
print(triangle.calculateArea())

class Singer {
    func playSong() {
        print("Shake it off!")
    }
}

func sing() -> () -> Void {
    let taylor = Singer()
    let singing = { [weak taylor] in
        taylor?.playSong()
        return
    }
    return singing
}

