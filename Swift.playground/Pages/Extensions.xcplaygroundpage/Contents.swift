//: [Nested Types](@previous)

//: ## Extensions : 扩展
//  * 为已存在的类、结构体、枚举或者协议添加新功能
//  * 类似与 Objective-C 的分类(Categories)，但是 Swift 不需要为扩展命名
//  * 扩展功能
//      - 添加计算实例属性和计算类型属性
//      - 定义实例方法和类方法
//      - 添加新的初始化方法
//      - 定义下标脚本
//      - 定义和使用新的嵌套类型
//      - 实现协议
//  * 注：
//      - 不能重写已经存在的功能
//      - 不能添加存储属性

//: Extension Syntax (扩展语法)

//extension SomeType {
//    // 定义新功能方法
//}

//extension SomeType: SomeProtocol, AnotherProtocol {
//    // 实现协议
//}

//: Computed Properties (计算属性)

extension Double {
    var km: Double { return self * 1_000.0 }    // 千米
    var m: Double { return self }               // 米
    var cm: Double { return self / 100.0 }      // 厘米
    var mm: Double { return self / 1_000.0 }    // 毫米
    var ft: Double { return self / 3.28084 }    // 英寸
}
let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")
let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")

let aMarathon = 42.km + 195.m
print("A marathon is \(aMarathon) meters long")

//: Initializers (初始化器)
//  * 可以扩展现有类型的指定初始化器
//  * 可以扩展现有类型的便利初始化器
//  * 不能扩展特定的初始化器和析构器
//  * 注：
//      - 一个值类型存储属性均有默认值，并且没有提供任何初始化器，那么扩展初始化器中可以使用默认构造器和成员构造器

struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}
let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
                          size: Size(width: 5.0, height: 5.0))

extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}
let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                      size: Size(width: 3.0, height: 3.0))

//: Methods (方法)
//  * 可以为现有类型扩展实例方法和类方法

extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}
3.repetitions {
    print("Hello!")
}

// Mutating Instance Methods - 可变实例方法
//  * 可以扩展可变实例方法来修改变量

extension Int {
    mutating func square() {
        self = self * self
    }
}
var someInt = 3
someInt.square()

//: Subscripts (下标)

extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}
746381295[0]
746381295[1]
746381295[2]
746381295[8]
746381295[9]
0746381295[9]

//: Nested Types (嵌套类型)

extension Int {
    enum Kind {
        case negative, zero, positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
}

func printIntegerKinds(_ numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .negative:
            print("- ", terminator: "")
        case .zero:
            print("0 ", terminator: "")
        case .positive:
            print("+ ", terminator: "")
        }
    }
    print("")
}
printIntegerKinds([3, 19, -27, 0, -6, 0, 7])


//: [Protocols](@next)
