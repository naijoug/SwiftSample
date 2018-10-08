//: [Properties](@previous)

//: ## Methods : 方法
//  * 方法是与特定类型相关联的函数
//  * 类、机构提和枚举都可以定义方法

//: Instance Methods (实例方法)
//  * 属性特性类、结构体或者枚举实例的函数

class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}
let counter = Counter()
counter.increment()
counter.increment(by: 5)
counter.reset()

// The self Property - self 属性
//  * 每个类型实例都有一个 self 的隐式属性，与实例本身等效
//  * self 一般用于避免冲突问题

struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x
    }
}
let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOf(x: 1.0) {
    print("This point is to the right of the line where x == 1.0")
}

// Modifying Value Types from Within Instance Methods - 在实例方法中修改值类型
//  * 由于结构体和枚举是值类型，默认情况下无法在实例方法中修改值类型的属性
//  * mutating 修饰的方法可以修改值类型的属性

struct Point1 {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}
var somePoint1 = Point1(x: 1.0, y: 1.0)
somePoint1.moveBy(x: 2.0, y: 3.0)
print("The point is now at \(somePoint1.x), \(somePoint1.y)")

// 不能再常量结构体实例上调用 mutating 方法，因为它的属性(包括变量属性)不能修改
/**
let fixedPoint = Point1(x: 3.0, y: 3.0)
fixedPoint.moveBy(x: 2.0, y: 3.0)
 */

// Assigning to self Within a Mutating Method - 在可变方法中给 self 赋值
struct Point2 {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = Point2(x: x + deltaX, y: y + deltaY)
    }
}
// 枚举中可以将隐私 self 赋值为枚举中的不同值
enum TriStateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}
var ovenLight = TriStateSwitch.low
ovenLight.next()
ovenLight.next()

//: Type Methods (类型方法)
//  * 类、结构体或者枚举都可以定义类型方法
//  * static 关键字声明类方法
//  * class 关键字声明允许子类重写父类的类型方法

class SomeClass {
    class func someTypeMethod() {
        print("Some Class Some Type Method.")
    }
}
SomeClass.someTypeMethod()

struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    
    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel { highestUnlockedLevel = level }
    }
    
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    
    @discardableResult // 用于忽略返回值
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let playerName: String
    func complete(level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    init(name: String) {
        playerName = name
    }
}

var player = Player(name: "Argyrios")
player.complete(level: 1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")

player = Player(name: "Beto")
if player.tracker.advance(to: 6) {
    print("player is now on level 6")
} else {
    print("level 6 has not yet been unlocked")
}


//: [Subscripts](@next)
