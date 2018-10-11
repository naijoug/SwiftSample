//: [Extensions](@previous)

//: ## Protocols (协议)
//  * 类、结构体和枚举都可以遵循协议
//  * 扩展也可以遵循协议

//: Protocol Syntax (协议语法)

/**
protocol SomeProtocol {
    // 协议定义
}
struct SomeStructure: FirstProtocol, AnotherProtocol {
    // 结构体定义
}
class SomeClass: SomeSuperclass, FirstProtocol, AnotherProtocol {
    // 类定义
}
 */

//: Property Requirements (属性要求)
//  * 协议可以要求遵循的协议的类型提供特定名称的实例属性或类型属性
//  * 协议只指定属性名称，不指定属性类型(计算属性或存储属性)
//  * 协议可以指定属性可读性(可读或者可读可写)

protocol SomeProtocol {
    var mustBeSettable: Int { get set } // 可读可写实例属性
    var doesNotNeedToBeSettable: Int { get } // 只读实例属性
}
protocol AnotherProtocol {
    static var someTypeProperty: Int { get set } // 类型属性
}

protocol FullyNamed {
    var fullName: String { get }
}
struct Person: FullyNamed { // 结构体实现协议
    var fullName: String
}
let john = Person(fullName: "John Appleseed")

class Starship: FullyNamed { // 类实现协议
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}
var ncc1701 = Starship(name: "Enterprise", prefix: "USS")

//: Method Requirements (方法要求)
//  * 协议可以要求遵循协议的类型来实现特定的实例方法和类型方法
//  * 协议只定义方法，不提供方法实现
//  * 无法为协议方法提供默认值

/**
protocol SomeProtocol {
    static func someTypeMethod() // 定义类型方法，始终使用 static 关键字
}
 */

protocol RandomNumberGenerator {
    func random() -> Double
}
class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}
let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
print("And another one: \(generator.random())")

//: Mutating Method Requirements (可变方法要求)
//  * 注：
//      mutating 仅有结构体和枚举使用，类类型实现可变协议时不需要使用

protocol Togglable {
    mutating func toggle()
}
enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}
var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()

//: Initializer Requirements (构造器要求)

protocol SomeProtocol1 {
    init(someParameter: Int)
}

// Class Implementations of Protocol Initializer Requirements - 类实现构造器协议要求
//  * 需要使用 required 关键字的两种情况
//      - 实现指定构造器实现构造器协议
//      - 实现便利构造器实现构造器协议
//  * 注：
//      - 使用 final 标记的类上不需要使用 required 标记构造器协议的实现，因为 final 类不能进行子类化

class SomeClass1: SomeProtocol1 {
    required init(someParameter: Int) {
        // 初始化
    }
}

protocol SomeProtocol2 {
    init()
}
class SomeSuperClass2 {
    init() {
    }
}
class SomeSubClass2: SomeSuperClass2, SomeProtocol2 {
    // required : 来自于 SomeProtocol 协议;
    // override : 来自于 SomeSuperClass 父类
    required override init() {
        // 初始化
    }
}

// Failable Initializer Requirements - 可失败构造器要求
//  * 遵循协议的类型可以使用可失败或非可失败构造器来实现可失败构造器协议
//  * 非可失败构造器实现可失败构造器协议，必须使用非可失败构造器或者隐式展开可失败构造器来实现


//: Protocols as Types (协议作为类型)
//  * 协议使用
//      - 作为函数、方法或者构造器的参数或返回值
//      - 作为常量、变量或者属性的类型
//      - 作为数组、字典或者其它容器的元素类型
//  * 注：
//      - 协议是类型，首字母需要大写

class Dice { // 骰子🎲
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int { // 掷骰子🎲
        return Int(generator.random() * Double(sides)) + 1
    }
}
var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}

//: Delegation (委托)
//  * 委托设计模式 : 将类或结构体的职责委托给另一个类型实例

protocol DiceGame { // 骰子🎲游戏
    var dice: Dice { get }
    func play()
}
protocol DiceGameDelegate: AnyObject { // 定义骰子🎲游戏委托
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}
class SnakesAndLadders: DiceGame { // 蛇🐍和梯子游戏
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    weak var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}

class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}
let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()

//: Adding Protocol Conformance with an Extension (通过扩展添加协议遵循)
//  * 可以通过扩展为已存在的类型让它遵循实现一个新的协议

protocol TextRepresentable {
    var textualDescription: String { get }
}

extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}
let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
print(d12.textualDescription)

extension SnakesAndLadders: TextRepresentable {
    var textualDescription: String {
        return "A game of Snakes and Ladders with \(finalSquare) squares"
    }
}
print(game.textualDescription)

// Conditionally Conforming to a Protocol - 有条件地遵循协议
//  * 泛型类型可能只在特定条件下满足协议的要求
//  * where 关键子限制泛型元素类型有条件地遵循一个协议

extension Array: TextRepresentable where Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}
let myDice = [d6, d12]
print(myDice.textualDescription)

// Declaring Protocol Adoption with an Extension - 通过扩展声明采纳协议
//  * 一个类型已经遵循了某个协议所有要求，但是没有声明遵循协议，可以通过一个空扩展遵循该协议

struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}
extension Hamster: TextRepresentable {} // 空扩展遵循协议
let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textualDescription)

//: Collections of Protocol Types (协议类型的集合)

let things: [TextRepresentable] = [game, d12, simonTheHamster]
for thing in things {
    print(thing.textualDescription)
}

//: Protocol Inheritance (协议的继承)
//  * 协议可以继承一个或多个协议
//  * 在继承基础上可以扩展更多协议要求

protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
    // 协议定义
}

protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String { get }
}
extension SnakesAndLadders: PrettyTextRepresentable {
    var prettyTextualDescription: String {
        var output = textualDescription + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "▲ "
            case let snake where snake < 0:
                output += "▼ "
            default:
                output += "○ "
            }
        }
        return output
    }
}
print(game.prettyTextualDescription)

//: Class-Only Protocols (类专属协议)
//  * 协议通过继承 AnyObject 协议，来限定仅为类类型可用(结构体和枚举不能使用)

protocol SomeInheritedProtocol {}
protocol SomeClassOnlyProtocol: AnyObject, SomeInheritedProtocol {
    // 协议定义
}

//: Protocol Composition (协议组合)
//  * 要求类型同时遵循多个协议
//  * & 符号来连接要符合的多个协议

protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct Person1: Named, Aged {
    var name: String
    var age: Int
}
func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}
let birthdayPerson = Person1(name: "Malcolm", age: 21)
wishHappyBirthday(to: birthdayPerson)

class Location {
    var latitude: Double
    var longitude: Double
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
class City: Location, Named {
    var name: String
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        super.init(latitude: latitude, longitude: longitude)
    }
}
func beginConcert(in location: Location & Named) { // 联合遵循类和协议
    print("Hello, \(location.name)!")
}
let seattle = City(name: "Seattle", latitude: 47.6, longitude: -122.3)
beginConcert(in: seattle)

//: Checking for Protocol Conformance (检查协议一致性)
//  * is 检查协议遵循
//  * as 转换成特定协议
//  * as? 返回协议类的可选值
//  * as! 强制转换为协议类型

protocol HasArea {
    var area: Double { get }
}
class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) { self.radius = radius }
}
class Country: HasArea {
    var area: Double
    init(area: Double) { self.area = area }
}
class Animal {
    var legs: Int
    init(legs: Int) { self.legs = legs }
}

let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]
for object in objects {
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)")
    } else {
        print("Something that doesn't have an area")
    }
}

//: Optional Protocol Requirements (可选协议要求)
//  * optional 关键字标记可选要求
//  * 可选协议和可选要求必须使用 @objc 标记
//  * @objc 协议只能由继承 Objective-C 类或者其它 @objc 类的类遵循
//  * 需要使用可选链来调用可选协议要求

import Foundation

@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}
class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.increment?(forCount: count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

class ThreeSource: NSObject, CounterDataSource {
    let fixedIncrement = 3
}
var counter = Counter()
counter.dataSource = ThreeSource()
for _ in 1...4 {
    counter.increment()
    print(counter.count)
}

class TowardsZeroSource: NSObject, CounterDataSource {
    func increment(forCount count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}
counter.count = -4
counter.dataSource = TowardsZeroSource()
for _ in 1...5 {
    counter.increment()
    print(counter.count)
}

//: Protocol Extensions (协议扩展)
//  * 协议扩展 : 可以向符合协议的类型提供方法、构造器、下标和计算属性

extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}
let generator1 = LinearCongruentialGenerator()
print("Here's a random number: \(generator1.random())")
print("And here's a random Boolean: \(generator1.randomBool())")

// Providing Default Implementations - 提供默认实现
//  * 使用协议扩展来为任何方法或计算属性提供默认实现
//  * 如何一个类型本省提供了协议的要求，会覆盖扩展提供的默认实现

extension PrettyTextRepresentable  {
    var prettyTextualDescription: String {
        return textualDescription
    }
}

// Adding Constraints to Protocol Extensions - 为洗衣扩展添加约束条件
//  * where 关键字添加约束条件
// * 注：
//      - 一类类型遵循多个具有同名方法或属性的扩展协议，优先调用约束较多的

extension Collection where Element: Equatable {
    func allEqual() -> Bool {
        for element in self {
            if element != self.first {
                return false
            }
        }
        return true
    }
}
let equalNumbers = [100, 100, 100, 100, 100]
let differentNumbers = [100, 100, 200, 100, 200]
print(equalNumbers.allEqual())
print(differentNumbers.allEqual())


//: [Generics](@next)
