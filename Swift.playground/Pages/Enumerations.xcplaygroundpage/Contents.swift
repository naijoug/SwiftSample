//: [Closures](@previous)

//: ## Enumerations : 枚举

//: Enumeration Syntax (枚举语法)

enum CompassPoint {
    case north
    case south
    case east
    case west
}

enum Planet { // 同一行声明，使用逗号 , 分割
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}

var directionToHead = CompassPoint.west
directionToHead = .east

//: Matching Enumeration Values with a Switch Statement (使用 Switch 匹配枚举值)

directionToHead = .south
switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}

let somePlanet = Planet.earth
switch somePlanet {
case .earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}

//: Iterating over Enumeration Cases (遍历枚举 case)

enum Beverage: CaseIterable {
    case coffee, tea, juice
}
let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverages available")

for beverage in Beverage.allCases {
    print(beverage)
}

//: Associated Values (关联值)

enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(8, 85909, 51226, 3)
productBarcode = .qrCode("ABCDEFGHIJKLMNOP")

switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}

switch productBarcode {
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC : \(numberSystem), \(manufacturer), \(product), \(check).")
case let .qrCode(productCode):
    print("QR code: \(productCode).")
}

//: Raw Values (原始值)
//  * 使用相同类型的默认值预先设置

enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

// Implicitly Assigned Raw Values - 隐式指定的原始值
enum Planet1: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}
enum CompassPoint1: String {
    case north, south, east, west
}
let earthsOrder = Planet1.earth.rawValue
let sunsetDirection = CompassPoint1.west.rawValue

// Initializing from a Raw Value - 通过原始值初始化
let possiblePlanet = Planet1(rawValue: 7)

let positionToFind = 11
if let somePlanet = Planet1(rawValue: positionToFind) {
    switch somePlanet {
    case .earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
} else {
    print("There isn't a planet at position \(positionToFind)")
}

//: Recursive Enumerations (递归枚举)
//  * 递归枚举 : 另一个枚举作为枚举成员关联值的枚举
//  * indirect 声明递归

// 写法一 : 指明递归项
enum ArithmeticExpression1 {
    case number(Int)
    indirect case addition(ArithmeticExpression1, ArithmeticExpression1)
    indirect case multiplication(ArithmeticExpression1, ArithmeticExpression1)
}
// 写法二 : 使得整个枚举成员在需要时可以递归
indirect enum ArithmeticExpression2 {
    case number(Int)
    case addition(ArithmeticExpression2, ArithmeticExpression2)
    case multiplication(ArithmeticExpression2, ArithmeticExpression2)
}

let five = ArithmeticExpression1.number(5)
let four = ArithmeticExpression1.number(4)
let sum = ArithmeticExpression1.addition(five, four)
let product = ArithmeticExpression1.multiplication(sum, ArithmeticExpression1.number(2))

func evaluate(_ expression: ArithmeticExpression1) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}
print(evaluate(product))


//: [Structures and Classes](@next)
