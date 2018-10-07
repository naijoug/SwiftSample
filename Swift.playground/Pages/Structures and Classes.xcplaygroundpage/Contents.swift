//: [Enumeration](@previous)

//: ## Structures and Classes (结构体和类)

//: Comparing Structures and Classes (类和结构体的对比)
//  * 共同点
//      - 定义属性
//      - 定义方法
//      - 定义下标脚本
//      - 实现扩展
//      - 遵循协议
//  * 类的额外功能
//      - 可以继承另一个类
//      - 可以在运行时检查和解释一个类实例的类型
//      - 反初始化器可以在类释放其被分配的资源
//      - 引用计数允许对一个类实例多次引用

// Definition Syntax - 定义语法
struct SomeStructure {
    // 结构体定义
}
class SomeClass {
    // 类定义
}

struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

// Structure and Class Instances - 结构体和类实例
let someResolution = Resolution()
let someVideoMode = VideoMode()

// Accessing Properties - 访问属性
print("The width of someResolution is \(someResolution.width)")
print("The width of someVideoMode is \(someVideoMode.resolution.width)")
someVideoMode.resolution.width = 1280
print("The width of someVideoMode is now \(someVideoMode.resolution.width)")

// Memberwise Initializers for Structure Types - 结构体类型的成员初始化器
//  * 所有的结构体都有一个自动生成的成员初始化器
let vga = Resolution(width: 640, height: 480)

//: Structures and Enumerations Are Value Types (结构体和枚举是值类型)

let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
cinema.width = 2048
print("cinema is now \(cinema.width) pixels wide")
print("hd is still \(hd.width) pixels wide")

enum CompassPoint {
    case north, south, east, west
    mutating func turnNorth() {
        self = .north
    }
}
var currentDirection = CompassPoint.west
let rememberedDirection = currentDirection
currentDirection.turnNorth()

print("The current direction is \(currentDirection)")
print("The remembered direction is \(rememberedDirection)")

//: Classes Are Reference Types (类是引用类型)

let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0

print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")

// Identity Operators - 特征运算符
//  * === : 相等于，意味着两个类类型常量或者变量引用自相同的实例
//  * !== : 不相等于
if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
}

// Pointers - 指针


//: [Properties](@next)
