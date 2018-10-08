//: [Subscripts](@previous)

//: ## Inheritance : 继承
//  * 子类可以访问父类方法、属性和下标
//  * 子类可以重写父类方法、属性和下标
//  * 子类可以给继承父类的属性(存储属性和计算)添加属性观察器

//: Defining a Base Class (定义一个基类)
//  * 基类: 不继承任何类
//  * Swift 类不继承自统一的类

class Vehicle { // 交通工具
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        // 空方法，不是所有车辆都发出噪音
    }
}
let someVehicle = Vehicle()
print("Vehicle: \(someVehicle.description)")

//: Subclassing (子类化)
//  * 在已有类的基础上创建新类的行为

class Bicycle: Vehicle { // 自行车🚲
    var hasBasket = false
}
let bicycle = Bicycle()
bicycle.hasBasket = true
bicycle.currentSpeed = 15.0
print("Bicycle: \(bicycle.description)")

class Tandem: Bicycle { // 双人自行车
    var currentNumberOfPassengers = 0
}
let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
print("Tandem: \(tandem.description)")

//: Overriding (重写)
//  * override 关键声明重写

// Accessing Superclass Methods, Properties, and Subscript - 访问父类的方法、属性和下标
//  * super 隐式属性用于访问父类方法、属性和下标

// Overriding Methods - 重写方法
class Train: Vehicle { // 火车🚄
    override func makeNoise() {
        print("Choo Choo")
    }
}
let train = Train()
train.makeNoise()

// Overriding Properties - 重写属性
//  * 可以重写继承的的实例和类型属性
//  * 可以为重写属性提供自定义 getter 和 setter
//  * 可以为重写属性添加属性观察器 willSet 和 didSet

// Overriding Property Getters and Setters - 重写属性 getter 和 setter
class Car: Vehicle { // 手动挡汽车🚗
    var gear = 1 // 档位
    override var description: String { // 继承只读属性
        return super.description + " in gear \(gear)"
    }
}
let car = Car()
car.currentSpeed = 25.0
car.gear = 3
print("Car: \(car.description)")

// Overriding Property Observers - 重写属性观察器
class AutomaticCar: Car { // 自动档汽车
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}
let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
print("AutomaticCar: \(automatic.description)")

//: Preventing Overrides (防止重写)
//  * final 修饰的方法、属性和下标可以防止被重写
//  * final 修饰的类可以防止被继承


//: [Initalization](@next)
