//: [Automatic Reference Counting](@previous)

//: ## Memory Safety : 内存安全性

//: Understanding Conflicting Access to Memory

var one = 1
print("We're number \(one)!")

// Characteristics of Memory Access
func oneMore(than number: Int) -> Int {
    return number + 1
}
var myNumber = 1
myNumber = oneMore(than: myNumber)
print(myNumber)

// Conflicting Access to In-Out Parameters
var stepSize = 1
func increment(_ number: inout Int) {
    number += stepSize
}
increment(&stepSize)

var copyOfStepSize = stepSize
increment(&copyOfStepSize)

stepSize = copyOfStepSize

func balance(_ x: inout Int, _ y: inout Int) {
    let sum = x + y
    x = sum / 2
    y = sum - x
}
var playerOneScore = 42
var playerTwoScore = 30
balance(&playerOneScore, &playerTwoScore)
//balance(&playerOneScore, &playerOneScore)

//: Conflicting Access to self in Methods ()

struct Player {
    var name: String
    var health: Int
    var energy: Int
    
    static let maxHealth = 10
    mutating func restoreHealth() {
        health = Player.maxHealth
    }
}
extension Player {
    mutating func shareHealth(with teammate: inout Player) {
        balance(&teammate.health, &health)
    }
}
var oscar = Player(name: "Oscar", health: 10, energy: 10)
var maria = Player(name: "Maria", health: 5, energy: 10)
oscar.shareHealth(with: &maria)
//oscar.shareHealth(with: &oscar)

//: Conflicting Access to Properties ()

var playerInformation = (health: 10, energy: 20)
balance(&playerInformation.health, &playerInformation.energy)

var holly = Player(name: "Holly", health: 10, energy: 10)
balance(&holly.health, &holly.energy)

func someFunction() {
    var oscar = Player(name: "Oscar", health: 10, energy: 10)
    balance(&oscar.health, &oscar.energy)
}

//: [Access Control](@next)
