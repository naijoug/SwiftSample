//: [Structures and Classes](@previous)

// Properties : 属性
//  * 属性可以将值与特定的类、结构体或者枚举类型相关联
//  * 属性分类
//      - 存储属性 : 将常量和变量值存储为实例的一部分，只适合于类和结构体，可以是常量或者变量属性
//      - 计算属性 : 通过计算得到一个值，始终是变量属性
//  * 类型属性 : 属性与类型本身相关联

//: Stored Properties (存储属性)

struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
print(rangeOfThreeItems.firstValue)
rangeOfThreeItems.firstValue = 6
print(rangeOfThreeItems.firstValue)
print(rangeOfThreeItems.length)

// Stored Properties of Constant Structure Instances  - 常量结构体实例的存储属性
//  * 结构体实例声明为常量，无法修改实例属性，即使实例属性声明为变量

/**
let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
rangeOfFourItems.firstValue = 6
*/

// Lazy Stored Properties - 延迟存储属性
//  * 初始值直到第一次使用是才进行计算
//  * lazy 标明延迟存储属性
//  * 注：
//      - 延迟属性必须声明为变量，应为常量属性必须在实例初始化完成赋值
//      - 延迟属性不是线程安全的

class DataImporter {
    var filename = "data.txt"
    init() {
        print("DataImporter init().")
    }
}
class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
print("manger ------")
print(manager.importer.filename)

// Stored Properties and Instance Variables - 存储属性与实例变量
//  * Swift 属性的底层存储变量不能直接访问

//: Computed Properties (计算属性)
//  * 提供 getter 和 setter 读取和设置属性值

struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0),
                  size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at \(square.origin.x), \(square.origin.y)")

// Shorthand Setter Declaration - Setter 简写定义
//  * 使用默认的名称 newValue

struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

// Read-Only Computed Properties - 只读计算属性
//  * 只读计算属性 : 只有 getter 没有 setter 的计算属性
//  * 常量属性 : 使用 let 定义，属性初始化之后不能再改变
//  * 注：
//      - 必须使用变量声明计算属性(包括只读计算属性)，因为他们的值是可变的

struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double { // 可以省略 get 关键字来简写只读计算属性
        return width * height * depth
    }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")

//: Property Observers (属性观察者)
//  * 对属性的变化做出反应，每次设置属性时调用属性观察器，即使新值与当前值相等
//  * 父类属性
//      - 已经调用父类初始化方法，会调用父类属性观察器
//      - 未调用父类初始化方法，不会调用父类属性观察器
//  * 注：
//      - 观察器属性作为 in-out 参数传递给函数，属性观察器一定会被调用

class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) { // 默认参数为 : newValue
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet { // 默认参数为 : oldValue
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
stepCounter.totalSteps = 360
stepCounter.totalSteps = 896

//: Global and Local Variables (全局和局部变量)
//  * 全局变量 : 任何函数、方法、闭包或类型上下文之外定义的变量
//  * 局部变量 : 在函数、方法或者闭包上下文中定义的变量
//  * 注：
//      - 全局变量和常量会被自动延迟计算，与延迟存储属性类似，但是不需要使用 lazy 修饰
//      - 局部变量和常量不会被延迟计算

//: Type Properties (类型属性)
//  * 实例属性 : 属于特定类型实例的属性
//  * 类型属性 : 属性类型本身的属性
//      - 存储类型属性 : 必须提供默认值，没有初始化方法进行赋值
//      - 存储类型属性自动延迟加载，不需要 lazy 修饰
//      - 类型属性是线程安全的

// Type Property Syntax - 类型属性语法
//  * static 关键字定义类型属性
//  * class 关键字声明允许子类覆盖父类的实现

struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}
class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}

// Querying and Setting Type Properties - 查询和设置类型属性
print(SomeStructure.storedTypeProperty)
SomeStructure.storedTypeProperty = "Another value."
print(SomeStructure.storedTypeProperty)
print(SomeEnumeration.computedTypeProperty)
print(SomeClass.computedTypeProperty)

struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}
var leftChannel = AudioChannel()
var rightChannel = AudioChannel()

leftChannel.currentLevel = 7
print(leftChannel.currentLevel)
print(AudioChannel.maxInputLevelForAllChannels)

rightChannel.currentLevel = 11
print(rightChannel.currentLevel)
print(AudioChannel.maxInputLevelForAllChannels)

//: [Methods](@next)
