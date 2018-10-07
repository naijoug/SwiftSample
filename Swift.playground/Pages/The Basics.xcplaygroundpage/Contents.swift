//: [Swift Tutor](@previous)

//: ## The Basics - 基础内容

//: Constants and Variables (常量和变量)

// Declaring Constants and Variables : 定义常量和变量
let maximumNumberOfLoginAttempts = 10
var currentLoginAttempt = 0
// 一行定义多个变量使用逗号分隔
var x = 0.0, y = 0.0, z = 0.0

// Type Annotations : 类型标注
//var welcomeMessage: String
//welcomeMessage = "Hello"

//var red, green, blue: Double

// Naming Constants and Variables : 命名常量和变量
let π = 3.14159
let 你好 = "你好世界"
let 🐶🐮 = "dogcow"

var friendlyWelcome = "Hello!"
friendlyWelcome = "Bonjour!"

let languageName = "Swift"
//languageName = "Swift++"

// Printing Constants and Variables : 输出常量和变量
print(friendlyWelcome)
print("The current value of friendlyWelcome is \(friendlyWelcome)")

//: Comments (注释)

// This is a comment.

/* This is also a comment
 but is written over multiple lines. */

/* This is the start of the first multiline comment.
 /* This is the second, nested multiline comment. */
 This is the end of the first multiline comment. */

//: Semicolons (分号)
let cat = "🐱"; print(cat)

//: Integers (整数)

// Integer Bounds : 整数范围
let minValue = UInt8.min // 最小值 : 0
let maxValue = UInt8.max // 最大值 : 255

// Int
// 32 位 => Int == Int32 (-2,147,483,648 ~ 2,147,483,647)
// 64 位 => Int == Int64

// UInt
// 32 位 => UInt == UInt32
// 64 位 => UInt == UInt64

//: Floating-Point Nubmers (浮点数)
// Double : 64 位浮点数
// Float : 32 位浮点数

//: Type Safety and Type Inference (类型安全和类型推断)

let meaningOfLife = 42
let onePi = 3.14159
let anotherPi = 3 + 0.14159

//: Numeric Literals (数值字面量)

let decimalInteger = 17         // 十进制
let binaryInteger = 0b10001     // 二进制   : 0b
let octalInteger = 0o21         // 八进制   : 0o
let hexadecimalInteger = 0x11   // 十六进制 : ox

let decimalDouble = 12.1875
let exponentDouble = 1.21875e1  // 指数
let hexadecimalDouble = 0xC.3p0 //

let paddedDouble = 000123.456
let oneMillion = 1_000_000
let justOverOneMillion = 1_000_000.000_000_1

//: Numeric Type Conversion (数值类型转换)

// Integer Conversion : 整数转换
//let cannotBeNegative: UInt8 = -1
//let tooBig: Int8 = Int8.max + 1

let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
let twoThousandAndOne = twoThousand + UInt16(one)

// Integer and Floating-Point Conversion : 整数和浮点数转换
let three = 3
let pointOneFourOneFiveNine = 0.14159
let pi = Double(three) + pointOneFourOneFiveNine
let integerPi = Int(pi)

//: Type Aliases (类型别名)

typealias AudioSample = UInt16
var maxAmplitudeFound = AudioSample.min

//: Booleans (布尔值)

let orangesAreOrange = true
let turnipsAreDelicious = false

if turnipsAreDelicious {
    print("Mmm, tasty turnips!")
} else {
    print("Eww, turnips are horrible.")
}

let i = 1
if i == 1 {
    print("success")
}

//: Tuples (元组)

let http404Error = (404, "Not Found")

let (statusCode, statusMessage) = http404Error
print("The status code is \(statusCode)")
print("The status message is \(statusMessage)")

let (justTheStatusCode, _) = http404Error
print("The status code is \(justTheStatusCode)")

print("The status code is \(http404Error.0)")
print("The status message is \(http404Error.1)")

let http200Status = (statusCode: 200, description: "OK")
print("The status code is \(http200Status.statusCode)")
print("The status message is \(http200Status.description)")

//: Optionals (可选值)

let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)

// nil
var serverResponseCode: Int? = 404
serverResponseCode = nil

var surveyAnswer: String?

// If Statements and Forced Unwrapping : if语句和强制展开
if convertedNumber != nil {
    print("convertedNumber contains some integer value.")
}
if convertedNumber != nil {
    print("convertedNumber has an integer value of \(convertedNumber!).")
}

// Optional Binding : 可选绑定
if let actualNumber = Int(possibleNumber) {
    print("The string \"\(possibleNumber)\" has an integer value of \(actualNumber)")
} else {
    print("The string \"\(possibleNumber)\" could not be converted to an integer")
}

if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100 {
    print("\(firstNumber) < \(secondNumber) < 100")
}

if let firstNumber = Int("4") {
    if let secondNumber = Int("42") {
        if firstNumber < secondNumber && secondNumber < 100 {
            print("\(firstNumber) < \(secondNumber) < 100")
        }
    }
}

// Implicitly Unwrapped Optionals : 隐式展开可选值
let possibleString: String? = "An optional string."
let forcedString: String = possibleString!

let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString

if assumedString != nil {
    print(assumedString!)
}

if let definiteString = assumedString {
    print(definiteString)
}

//: Error Handling (错误处理)

func canThrowAnError() throws {
    // 抛出异常
}
do {
    try canThrowAnError() // try 捕获抛出异常函数
} catch {
    // 处理捕获异常
}

//: Assertions and Preconditions (断言和先决条件)

// Debugging with Assertions : 使用断言进行调试
// 断言 : 运行时检查一个逻辑条件，true -> 代码继续运行；false -> 结束运行，程序终止
let age = 3
assert(age >= 0, "A person's age can't be less than zero.")

assert(age >= 0) // 可以省略 false 时显示的信息

if age > 10 {
    print("You can ride the roller-coaster or the ferris wheel.")
} else if age >= 0 {
    print("You can ride the ferris wheel.")
} else {
    assertionFailure("A person's age can't be less than zero.") // 标明断言失败
}

// Enforcing Preconditions : 强制先决条件
// 先决条件 : 条件必须为真代码才能继续运行
let index = 1
precondition(index > 0, "Index must be greater than zero.")
// preconditionFailure(_:file:line:) // 标明错误发生

// fatalError(_:file:line:) // 终止执行
// fatalError("Unimplemeneted") // 用于标明早期未实现的函数

//: [Basic Operators](@next)

