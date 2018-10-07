//: [Collection Types](@previous)

//: ## Control Flow : 控制流

//: For-In Loops (for-in 循环)

let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names {
    print("Hello, \(name)!")
}

let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in numberOfLegs {
    print("\(animalName)s have \(legCount) legs")
}

for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}

let base = 3
let power = 10
var answer = 1
for _ in 1...power {
    answer *= base
}
print("\(base) to the power of \(power) is \(answer)")

let minutes = 60
for tickMark in 0..<minutes {
    print(tickMark)
}

// stride 计数步幅
let minuteInterval = 5
for tickMark in stride(from: 0, to: minutes, by: minuteInterval) {
    print(tickMark)
}

let hours = 12
let hourInterval = 3
for tickMark in stride(from: 3, through: hours, by: hourInterval) {
    print(tickMark)
}

//: While Loops (while 循环)

// While
let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
var square = 0
var diceRoll = 0
while square < finalSquare {
    // 掷骰子
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    square += diceRoll // 根据掷出数字移动
    if square < board.count { // 仍然在棋盘上，移动蛇🐍或者梯子
        square += board[square]
    }
}
print("Game over!")

// Repeat-While
//  * 循环判断之前，至少执行一次循环代码块

let finalSquare1 = 25
var board1 = [Int](repeating: 0, count: finalSquare + 1)
board1[03] = +08; board1[06] = +11; board1[09] = +09; board1[10] = +02
board1[14] = -10; board1[19] = -11; board1[22] = -02; board1[24] = -08
var square1 = 0
var diceRoll1 = 0
repeat {
    square1 += board1[square1]
    diceRoll1 += 1
    if diceRoll1 == 7 { diceRoll1 = 1 }
    square1 += diceRoll1
} while square1 < finalSquare1
print("Game over!")

//: Conditional Statements (条件语句)

// If
var temperatureInFahrenheit = 30
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
}

temperatureInFahrenheit = 40
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else {
    print("It's not that cold. Wear a t-shirt.")
}

temperatureInFahrenheit = 90
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
    print("It's really warm. Don't forget to wear sunscreen.")
} else {
    print("It's not that cold. Wear a t-shirt.")
}

temperatureInFahrenheit = 72
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
    print("It's really warm. Don't forget to wear sunscreen.")
}

// Switch
let someCharacter: Character = "z"
switch someCharacter {
case "a":
    print("The first letter of the alphabet")
case "z":
    print("The last letter of the alphabet")
default:
    print("Some other character")
}

// No Implicit Fallthrough - 没有隐私贯穿
let anotherCharacter: Character = "a"
switch anotherCharacter {
//case "a": // 报错，没有执行语句
case "A":
    print("The letter A")
default:
    print("Not the letter A")
}

let anotherCharacter1: Character = "a"
switch anotherCharacter1 {
case "a", "A":  // 匹配多值使用逗号 , 分割
    print("The letter A")
default:
    print("Not the letter A")
}

// Interval Matching - 区间匹配
let approximateCount = 62
let countedThings = "moons orbiting Saturn"
var naturalCount: String = ""
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}
print("There are \(naturalCount) \(countedThings).")

// Tuples - 元组
let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("\(somePoint) is at the origin")
case (_, 0):
    print("\(somePoint) is on the x-axis")
case (0, _):
    print("\(somePoint) is on the y-axis")
case (-2...2, -2...2):
    print("\(somePoint) is inside the box")
default:
    print("\(somePoint) is outside of the box")
}

// Value Bindings - 值绑定
//  * 可以将匹配的值临时绑定为一个常量或者变量
let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}

// Where
//  * 用来检查额外的条件
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}

// Compound Cases - 符合情况
let someCharacter1: Character = "e"
switch someCharacter1 {
case "a", "e", "i", "o", "u":
    print("\(someCharacter1) is a vowel")
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
     "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
    print("\(someCharacter1) is a consonant")
default:
    print("\(someCharacter1) is not a vowel or a consonant")
}

let stillAnotherPoint = (9, 0)
switch stillAnotherPoint {
case (let distance, 0), (0, let distance):
    print("On an axis, \(distance) from the origin")
default:
    print("Not on an axis")
}

//: Control Transfer Statements (控制转移语句)

// Continue
//  * 继续下一次遍历
let puzzleInput = "great minds think alike"
var puzzleOutput = ""
let charactersToRemove: [Character] = ["a", "e", "i", "o", "u", " "]
for character in puzzleInput {
    if charactersToRemove.contains(character) {
        continue
    }
    puzzleOutput.append(character)
}
print(puzzleOutput)

// Break
// * 跳出控制流语句

// Break in a Loop Statement - 循环语句中的 Break
//  * 立即结束执行，跳出循环语句

// Break in a Switch Statement - Switch 语句中的 Break
let numberSymbol: Character = "三"  // Chinese symbol for the number 3
var possibleIntegerValue: Int?
switch numberSymbol {
case "1", "١", "一", "๑":
    possibleIntegerValue = 1
case "2", "٢", "二", "๒":
    possibleIntegerValue = 2
case "3", "٣", "三", "๓":
    possibleIntegerValue = 3
case "4", "٤", "四", "๔":
    possibleIntegerValue = 4
default:
    break
}
if let integerValue = possibleIntegerValue {
    print("The integer value of \(numberSymbol) is \(integerValue).")
} else {
    print("An integer value could not be found for \(numberSymbol).")
}

// Fallthrough - 贯穿
//  * 贯穿到下一种情况
let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough
default:
    description += " an integer."
}
print(description)

// Labeled Statements - 语句标签
let finalSquare2 = 25
var board2 = [Int](repeating: 0, count: finalSquare2 + 1)
board2[03] = +08; board2[06] = +11; board2[09] = +09; board2[10] = +02
board2[14] = -10; board2[19] = -11; board2[22] = -02; board2[24] = -08
var square2 = 0
var diceRoll2 = 0

gameLoop: while square2 != finalSquare2 {
    diceRoll2 += 1
    if diceRoll2 == 7 { diceRoll2 = 1 }
    switch square2 + diceRoll2 {
    case finalSquare2:
        break gameLoop
    case let newSquare where newSquare > finalSquare2:
        continue gameLoop
    default:
        square2 += diceRoll2
        square2 += board2[square2]
    }
}
print("Game over!")

//: Early Exit (提前退出)

func greet(person: [String: String]) {
    guard let name = person["name"] else {
        return
    }
    
    print("Hello \(name)!")
    
    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }
    
    print("I hope the weather is nice in \(location).")
}

greet(person: ["name": "John"])
greet(person: ["name": "Jane", "location": "Cupertino"])

//: Checking API Availability (检查 API 可用性)

if #available(iOS 10, macOS 10.12, *) {
    
} else {
    
}


//: [Functions](@next)
