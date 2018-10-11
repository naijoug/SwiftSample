//: [Generics](@previous)

//: ## Automatic Reference Counting : 自动引用计数
//  * Swift 使用 ARC 进行应用程序的内存使用管理和跟踪
//  * ARC 仅适用于引用实例对象

//: How ARC Works (ARC 工作机制)


//: ARC in Action (ARC 实践)

class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("Person \(name) is being initialized")
    }
    deinit {
        print("Person \(name) is being deinitialized")
    }
}
var reference1: Person?
var reference2: Person?
var reference3: Person?

reference1 = Person(name: "John Appleseed")
reference2 = reference1
reference3 = reference1

reference1 = nil
reference2 = nil
reference3 = nil

//: Strong Reference Cycles Between Class Instances (类实例之间的强引用)
//  * 强循环引用 : 两个实例之间相互强引用对方
//  * 使用 weak(弱引用) 和 unowned(无主引用) 来解决循环引用问题

class Person1 {
    let name: String
    init(name: String) {
        self.name = name
        print("Person1 \(name) is being initialized")
    }
    var apartment: Apartment1?
    deinit { print("Person1 \(name) is being deinitialized") }
}
class Apartment1 {
    let unit: String
    init(unit: String) {
        self.unit = unit
        print("Apartment1 \(unit) is being initialized")
    }
    var tenant: Person1?
    deinit { print("Apartment1 \(unit) is being deinitialized") }
}
var john1: Person1?
var unit4A1: Apartment1?
john1 = Person1(name: "John Appleseed")
unit4A1 = Apartment1(unit: "4A")
john1!.apartment = unit4A1
unit4A1!.tenant = john1
john1 = nil
unit4A1 = nil

//: Resolving Strong Reference Cycles Between Class Instances (解决实例之间的强循环引用)
//  * weak : 弱引用，一个实例的生命周期比引用它的实例短，也就是先于引用它的实例释放
//  * unowned : 无主引用，一个实例的生命周期比引用它的实例长

// Weak References - 弱引用
//  * weak 关键字声明弱引用
//  * 不会强持有引用的实例，不会阻止 ARC 销毁引用的实例
//  * 弱引用实例释放时，ARC 自动将其设置为 nil
//  * 注：
//      - ARC 将弱引用设置为 nil 时，不会调用属性观察器
//  * 垃圾回收与ARC
//      - 垃圾回收 : 弱引用用来实现简单缓存机制，在内存压力时触发回收机制，释放没有没有强引用的对象
//      - ARC : 最后一个强引用断开，值就会被释放

// 解决循环引用场景一 : 引用双方均可设置为 nil
//  > 一方使用 weak 解决
class Person2 {
    let name: String
    init(name: String) {
        self.name = name
        print("Person2 \(name) is being initialized")
    }
    var apartment: Apartment2?
    deinit { print("Person2 \(name) is being deinitialized") }
}
class Apartment2 {
    let unit: String
    init(unit: String) {
        self.unit = unit
        print("Apartment2 \(unit) is being initialized")
    }
    weak var tenant: Person2?
    deinit { print("Apartment2 \(unit) is being deinitialized") }
}
var john2: Person2?
var unit4A2: Apartment2?
john2 = Person2(name: "John Appleseed")
unit4A2 = Apartment2(unit: "4A")
john2!.apartment = unit4A2
unit4A2!.tenant = john2
john2 = nil
unit4A2 = nil

// Unowned References - 无主引用
//  * 无主引用总是有值的，需要被定义为非可选类型
//  * ARC 不会讲无主引用值设置为 nil
//  * 无主引用对象释放后，访问改值，会触发运行时错误

// 解决循环引用场景二 : 一个属性可以设置为 nil，另一个不允许设置为 nil
//  > 不能设置为 nil 的一方使用 unowned
class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit { print("Customer \(name) is being deinitialized") }
}
class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { print("Card #\(number) is being deinitialized") }
}
var john3: Customer?
john3 = Customer(name: "John Appleseed")
john3!.card = CreditCard(number: 1234_5678_9012_3456, customer: john3!)
john3 = nil

// Unowned References and Implicitly Unwrapped Optional Properties - 无主引用和隐式解析可选类型

// 解决循环引用场景二 : 引用双方均不能设置为 nil
//  > 一方使用 unowned，另一方使用隐式可选类型
//  初始化之后两个属性都能直接访问(不需要显示解包)，同时避免了循环引用
class Country {
    let name: String
    var capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}
class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}
var country = Country(name: "Canada", capitalName: "Ottawa")
print("\(country.name)'s capital city is called \(country.capitalCity.name)")


//: Strong Reference Cycles for Closures (闭包引起的强循环引用)
//  * 循环引用发生情况:
//      - 两个实例互相强引用
//      - 将一个闭包复制给一个实例的属性，并且这个闭包又捕获了这个实例(如：闭包内部访问了实例的属性或者调用了实例的方法)
//  * 闭包循环引用解决方案：closure capture list (闭包捕获列表)


class HTMLElement {
    let name: String
    let text: String?
    lazy var asHTML: () -> String = { // 使用 lazy 懒加载才可以访问实例属性，使用 self
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    deinit {
        print("HTMLElement \(name) is being deinitialized")
    }
}
let heading = HTMLElement(name: "h1")
let defaultText = "some default text"
heading.asHTML = {
    return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}
print(heading.asHTML())

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())
paragraph = nil

//: Resolving Strong Reference Cycles for Closures (解决闭包强循环引用)
//  * Swift 强制要求
//      - 闭包内部使用 self 成员，必须使用 self.property 或 self.method()，不能直接使用 property 或 method()

// Defining a Capture List - 定义捕获列表
//  * 捕获列表放在闭包的参数和返回值前面
/**
lazy var someClosure: (Int, String) -> String = {
    [unowned self, weak delegate = self.delegate!] (index: Int, stringToProcess: String) -> String in
}

lazy var someClosure: () -> String = {
    [unowned self, weak delegate = self.delegate!] in
}
 */

// Weak and Unowned References - 弱引用和无主引用
class HTMLElement1 {
    let name: String
    let text: String?
    lazy var asHTML: () -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    deinit {
        print("HTMLElement1 \(name) is being deinitialized")
    }
}

var paragraph1: HTMLElement1? = HTMLElement1(name: "p", text: "hello, world")
print(paragraph1!.asHTML())


//: [Memory Safety](@next)
