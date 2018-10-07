//: [Functions](@previous)

//: ## Closures : 闭包

//  * 闭包的三种形式
//      - 全局函数是一个有名字但不会捕获任何值得闭包
//      - 内嵌函数式一个有名字且能从上层函数捕获值得闭包
//      - 闭包表达式是一个轻量级语法所写的可以捕获器上下文中常量或变量值的没有名字的闭包
//  * 常见的闭包优化
//      - 利用上下文推断形式参数和返回值的类型
//      - 单表达式的闭包可以隐身返回
//      - 简写实际参数名
//      - 尾随闭包语法


//: Closure Expressions (闭包表达式)

// The Sorted Method  - Sorted 方法
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
var reversedNames = names.sorted(by: backward)

// Closure Expression Syntax - 闭包表达式语法
reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})
reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 } )

// Inferring Type From Context - 从语境中推断类型
reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )

// Implicit Returns from Single-Expression Closures - 单表达式闭包省略 return
reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )

// Shorthand Argument Names - 简写实际参数名
reversedNames = names.sorted(by: { $0 > $1 } )

// Operator Methods - 运算符函数
reversedNames = names.sorted(by: >)


//: Trailing Closures (尾随闭包)
//  * 将一个很长的闭包表达式作为函数最后一个参数
//  * 尾随闭包是书写在函数参数括号外的闭包表达式

func someFunctionThatTakesAClosure(closure: () -> Void) {
    
}
someFunctionThatTakesAClosure(closure: {
    
})
someFunctionThatTakesAClosure() {
    
}

reversedNames = names.sorted() { $0 > $1 }
reversedNames = names.sorted { $0 > $1 } // 只有一个闭包参数，函数括号可以省略

let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]

let strings = numbers.map { (number) -> String in
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    return output
}

//: Capturing Values (捕获值)
//  * 闭包可以从上下文捕获已被定义的常量和变量
//  * 即使被捕获值在原作用域不存在，在闭包内仍可以使用
//  * 优化 : 在闭包内没有改变闭包外的值，Swift 可能使用值得拷贝而不是捕获

func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10)
incrementByTen()
incrementByTen()
incrementByTen()

let incrementBySeven = makeIncrementer(forIncrement: 7)
incrementBySeven()

incrementByTen()

//: Closures Are Reference Types (闭包是引用类型)

let alsoIncrementByTen = incrementByTen
alsoIncrementByTen()

incrementByTen()

//: Escaping Closures (逃逸闭包)
//  * 逃逸闭包 : 闭包作为一个参数传递给函数，在函数返回之后才被调用
//  * @escaping 声明允许逃逸

var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}
// 非逃逸闭包
func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 } // 逃逸闭包需要显示地使用 self
        someFunctionWithNonescapingClosure { x = 200 }
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)

completionHandlers.first?()
print(instance.x)

//: Autoclosures (自动闭包)
//  * 自动将表达式打包成闭包
//  * @autoclosure 声明自动闭包参数

var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)

let customerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count)

print("Now serving \(customerProvider())!")
print(customersInLine.count)

func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: { customersInLine.remove(at: 0) } )

func serve(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: customersInLine.remove(at: 0))

// 自动闭包允许逃逸
var customerProviders: [() -> String] = []
func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
    customerProviders.append(customerProvider)
}
collectCustomerProviders(customersInLine.remove(at: 0))
collectCustomerProviders(customersInLine.remove(at: 0))

print("Collected \(customerProviders.count) closures.")
for customerProvider in customerProviders {
    print("Now serving \(customerProvider())!")
}


//: [Enumerations](@next)
