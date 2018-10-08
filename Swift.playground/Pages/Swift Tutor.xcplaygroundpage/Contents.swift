// Swift Tutor : Swift 概览

// MARK:  Hello world!

// 全局范围的代码被用来作为程序的入口，不再需要 main 函数
print("Hello, world!")  // 每句代码后面不需要分号";"

// MARK: Simple Values (简单值)

// 变量 & 常量
var myVariable = 42     // var 声明变量
myVariable = 50
let myConstant = 42     // let 声明常量

// 隐式 & 显式
let implicitInteger = 70        // 隐式 Int
let implicitDouble = 70.0       // 隐式 Double
let explicitDouble: Double = 70 // 显示 Double

// 类型转换
let lable = "The width is "
let width = 94
let widthLabel = lable + String(width) // 不会隐式转换类型，需要显式转换

// 字符串插入值
let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples."
let fruitSummary = "I have \(apples + oranges) pieces of fruit"

// 三个双引号(""") : 用于输入多行内容
let quotation = """
Even though there's whitespace to the left,
the actual lines aren't indented.
Except for this line.
Double quotes (") can appear without being escaped.

I still have \(apples + oranges) pieces of fruit.
"""

// 数组 & 字典
var shoppingList = ["catfish", "water", "tulips"] // 数组创建
shoppingList[1] = "bottle of water"

var occupations = [ // 字典创建
    "Malcolm": "Captain",
    "Kaylee": "Mechanic"
]
occupations["Jayne"] = "Public Relations"

shoppingList.append("blue paint")
print(shoppingList)

let emptyArray = [String]()
let emptyDictionary = [String: Float]()

shoppingList = []   // 空数组
occupations = [:]   // 空字典

// MARK: Control Flow (控制流)

// if 逻辑判断
let individualScores = [75, 43, 103, 87, 12]
var teamSocre = 0
for score in individualScores {
    if score > 50 { // 控制条件不再强制需要括号, 控制条件必须为 Bool 类型，不再隐式与 0 做计算
        teamSocre += 3
    } else {
        teamSocre += 1
    }
}
print(teamSocre)

var optionalString: String? = "Hello"
print(optionalString == nil)

// if 可选值处理
var optionalName: String? = "John Appleseed"
var greeting = "Hello!"
if let name = optionalName { // 可选值为 nil, 则条件为 false 跳过执行代码
    greeting = "Hello, \(name)"
}

// ?? 可选值处理
let nickName: String? = nil
let fullName: String = "John Appleseed"
let informalGreeting = "Hi \(nickName ?? fullName)"

// switch 支持任意类型数据和各种类型比较操作
let vegetable = "red pepper"
switch vegetable {
case "celeray":
    print("Add some raisins and make ants on a log.")
case "cucumber", "watercress":
    print("That would make a good tea sandwich.")
case let x where x.hasSuffix("pepper"):
    print("Is it a spicy \(x)?")
default:
    print("Everything tastes good in soup.")
}

// for-in 遍历字典
let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Square": [1, 4, 9, 16, 25]
]
var largest = 0
for (kind, numbers) in interestingNumbers {
    print(kind)
    for number in numbers {
        if number > largest {
            largest = number
        }
    }
}
print(largest)

// while 循环
var n = 2
while n < 100 {
    n = n * 2
}
print(n)

// repeat-while 循环 : 至少运行一次
var m = 2
repeat {
    m *= 2
} while m < 100
print(m)

// ..< : 创建序列区间
var total = 0
for i in 0..<4 {
    total += i
}
print(total)

// MARK: Functions and Closures (函数和闭包)

// func : 声明一个函数
// -> : 分割函数参数和返回值
func greet(person: String, day: String) -> String {
    return "Hello \(person), today is \(day)."
}
greet(person: "Bob", day: "Tuesday")

// _ : 避免使用实际参数标签
func greet(_ person: String, on day: String) -> String {
    return "Hello \(person), today is \(day)."
}
greet("John", on: "Wednesday")

// 使用元组创建复合值
func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
    var min = scores[0]
    var max = scores[0]
    var sum = 0
    
    for score in scores {
        if score > max {
            max = score
        } else if score < min {
            min = score
        }
        sum += score
    }
    return (min, max, sum)
}
let statistics = calculateStatistics(scores: [5, 3, 100, 3, 9])
print(statistics.sum)   // 通过名字调用
print(statistics.2)     // 通知下标调用

// 接收多个参数
func sumOf(numbers: Int...) -> Int {
    var sum = 0
    for number in numbers {
        sum += number
    }
    return sum
}
sumOf()
sumOf(numbers: 42, 597, 12)

// 内嵌函数 : 用于组织代码，避免函数过于复杂
func returnFifteen() -> Int {
    var y = 10
    func add() {
        y += 5 // 内嵌函数可以访问外部函数里的变量
    }
    add()
    return y
}
returnFifteen()

// 函数作为返回值
func makeIncrementer() -> ((Int) -> Int) {
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    return addOne // 函数式一等类型
}
var increment = makeIncrementer()
increment(7)

// 函数作为参数
func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}
func lessThanTen(number: Int) -> Bool {
    return number < 10
}
var numbers = [20, 19, 7, 12]
hasAnyMatches(list: numbers, condition: lessThanTen)

// 函数其实就是闭包的一种特殊形式
numbers.map { (number: Int) -> Int in
    let result = 3 * number
    return result
}

// 单语句闭包
let mapperNumbers = numbers.map({number in 3 * number})
print(mapperNumbers)

// 通过数字调用闭包参数
// 闭包作为最后一个参数括号可以省略
let sortedNumbers = numbers.sorted{ $0 > $1 }
print(sortedNumbers)

// MARK : Objects and Classes (对象和类)

// class 创建类
class Shape {
    var numberOfSides = 0 // 声明属性
    func simpleDescription() -> String { // 声明方法
        return "A shape with \(numberOfSides) sides."
    }
}
var shape = Shape()     // 通过圆括号"()"创建一个实例
shape.numberOfSides = 7 // 使用点语法"."访问实例属性和方法
var shapeDescription = shape.simpleDescription()

// 初始化器
class NamedShape {
    var numberOfSides: Int = 0
    var name: String
    
    init(name: String) { // init 创建初始化器
        self.name = name // self 用来区分属性和初始化器参数
    }
    
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

// 子类
class Square: NamedShape {
    var sideLength: Double
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }
    
    func area() -> Double {
        return sideLength * sideLength
    }
    // 重写父类方法需要使用 override
    override func simpleDescription() -> String {
        return "A square with sides of legth \(sideLength)"
    }
}
let test = Square(sideLength: 5.2, name: "my test square")
test.area()
test.simpleDescription()

// 计算属性
class EquilateralTriangle: NamedShape {
    var sideLength: Double = 0.0
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }
    
    var perimter: Double {
        get {
            return 3.0 * sideLength
        }
        set { // 新值为 newValue
            sideLength = newValue / 3.0
        }
    }
    override func simpleDescription() -> String {
        return "An equilateral triangle with sides of length \(sideLength)."
    }
}
var triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
print(triangle.perimter)
triangle.perimter = 9.9

// willSet : 设置新值之前执行代码
// didSet : 设置新值之后执行代码
class TriangleAndSquare {
    var triangle: EquilateralTriangle {
        willSet {
            square.sideLength = newValue.sideLength
        }
    }
    var square: Square {
        willSet {
            triangle.sideLength = newValue.sideLength
        }
    }
    init(size: Double, name: String) {
        square = Square(sideLength: size, name: name)
        triangle = EquilateralTriangle(sideLength: size, name: name)
    }
}
var triangleAndSquare = TriangleAndSquare(size: 10, name: "another test shape")
print(triangleAndSquare.square.sideLength)
print(triangleAndSquare.triangle.sideLength)
triangleAndSquare.square = Square(sideLength: 50, name: "larger square")
print(triangleAndSquare.square.sideLength)

// ? : 可选值
let optionalSquare: Square? = Square(sideLength: 2.5, name: "optional square")
let sideLength = optionalSquare?.sideLength

// MARK: Enumerations and Structures (枚举和结构体)

// enum 创建枚举
// 枚举值默认从 0 开始给原始值赋值后面递增，可以通过指定特定值来改变
enum Rank: Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    
    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}
let ace = Rank.ace
let aceRawValue = ace.rawValue // 使用 rawValue 属性访问枚举成员的原始值

// 使用 init?(rawValue:) 初始化器从一个原始值来创建枚举的实例
if let convertedRank = Rank(rawValue: 3) {
    let threeDescription = convertedRank.simpleDescription()
    print(threeDescription)
}

enum Suit {
    case spades, hearts, diamonds, clubs
    
    func simpleDescription() -> String {
        switch self {
        case .spades:
            return "spades"
        case .hearts:
            return "hearts"
        case .diamonds:
            return "diamonds"
        case .clubs:
            return "clubs"
        }
    }
}
let hearts = Suit.hearts
let heartsDescription = hearts.simpleDescription()

enum ServerResponse {
    case result(String, String)
    case failure(String)
}
// 初始化实例时确定枚举原始值
let success = ServerResponse.result("6:00 am", "8:09 pm")
let failure = ServerResponse.failure("Out of cheese")

switch success {
case let .result(sunrise, sunset):
    print("Sunrise is at \(sunrise) and sunset is at \(sunset).")
case let .failure(message):
    print("Failure... \(message)")
}

// struct 创建结构体
// 结构体与类的区别:
//      结构体传递其自身拷贝
//      类传递其引用
struct Card {
    var rank: Rank
    var suit: Suit
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
}
let threeOfSpades = Card(rank: .three, suit: .spades)
let threeOfSpadesDescription = threeOfSpades.simpleDescription()

// MARK: Protocols and Extensions (协议和扩展)

// protocol 声明协议
protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
    // mutating 关键字:
    //      在结构体中可以使得方法可以修改结构体属性
    //      在类中不需要声明，因为类中方法总可以修改自身属性
}

// 类实现协议
class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple class."
    var antherProperty: Int = 69105
    func adjust() {
        simpleDescription += " Now 100% adjusted."
    }
}
var a = SimpleClass()
a.adjust()
let aDescription = a.simpleDescription

// 结构体实现协议
struct SimpleStructure: ExampleProtocol {
    var simpleDescription: String = "A simple structure"
    mutating func adjust() {
        simpleDescription += " (adjusted)"
    }
}
var b = SimpleStructure()
b.adjust()
let bDescription = b.simpleDescription

// extension 给现存类型增加功能(新的方法、计算属性...)
// 扩展实现协议
extension Int: ExampleProtocol {
    var simpleDescription: String {
        return "The number \(self)"
    }
    mutating func adjust() {
        self += 42
    }
}
print(7.simpleDescription)

let protocolValue: ExampleProtocol = a
print(protocolValue.simpleDescription)

// MARK: Error Handling (错误处理)

// 错误类型需要实现 Error 协议
enum PrinterError: Error {
    case outOfPaper
    case onToner
    case onFire
}

// throw : 抛出一个错误
// throws : 标记一个可以抛出错误的函数
func send(job: Int, toPrinter printerName: String) throws -> String {
    if printerName == "Never Has Toner" {
        throw PrinterError.onToner
    }
    return "Job sent"
}

// do-catch : 处理错误
// try : 标记抛出错误的函数
do {
    let printerResponse = try send(job: 1040, toPrinter: "Bi Sheng")
    print(printerResponse)
} catch {
    print(error)
}
// catch : 处理特定的错误
do {
    let printerResponse = try send(job: 1440, toPrinter: "Gutenberg")
    print(printerResponse)
} catch PrinterError.onFire {
    print("I'll just put this over here, with the rest of the fire.")
} catch let printerError as PrinterError {
    print("Printer error: \(printerError).")
} catch {
    print(error)
}

// try? : 转换结果为可选项
//      如果抛出错误，怎错误被忽略结果为nil
//      未抛出错误，返回函数返回值的可选项
let printerSuccess = try? send(job: 1884, toPrinter: "Mergenthaler")
let printFailure = try? send(job: 1885, toPrinter: "Never Has Toner")

// defer : 函数返回后会被执行的代码块，无论是否抛出错误
var fridgeIsOpen = false
let fridgeContent = ["milk", "eggs", "leftovers"]

func fridgeContains(_ food: String) -> Bool {
    fridgeIsOpen = true
    defer {
        fridgeIsOpen = false
    }
    let result = fridgeContent.contains(food)
    return result
}
fridgeContains("banana")
print(fridgeIsOpen)
fridgeContains("milk")
print(fridgeIsOpen)

// MARK: Generics (泛型)

// <> 用来创建泛型
func makeArray<Item>(repeating item: Item, numberOfTimes: Int) -> [Item] {
    var result = [Item]()
    for _ in 0..<numberOfTimes {
        result.append(item)
    }
    return result
}
makeArray(repeating: "knock", numberOfTimes: 4)

// 枚举泛型
enum OptionalValue<Wrapped> {
    case none
    case some(Wrapped)
}

var possibleInteger: OptionalValue<Int> = .none
possibleInteger = .some(100)

// where : 明确一系列需求
func anyCommonElements<T: Sequence, U: Sequence>(_ lhs: T, rhs: U) -> Bool
    where T.Element: Equatable, T.Element == U.Element
{
    for lhsItem in lhs {
        for rhsItem in rhs {
            if lhsItem == rhsItem {
                return true
            }
        }
    }
    return false
}
anyCommonElements([1, 2, 3], rhs: [3])

//: [The Basics](@next)
