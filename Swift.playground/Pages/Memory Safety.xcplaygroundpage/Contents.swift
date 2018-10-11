//: [Automatic Reference Counting](@previous)

//: ## Memory Safety : 内存安全性

//: Understanding Conflicting Access to Memory (理解产生内存访问冲突的原因)
//  * 访问内存
//      - 给变量赋值
//      - 给一个方法传递参数

var one = 1
print("We're number \(one)!")

// Characteristics of Memory Access - 内存访问要素
//  * 内存访问三要素
//      - 读或写操作
//      - 操作时长
//      - 访问的内存地址
//  * 内存访问冲突情况
//      - 至少有一个写操作
//      - 访问同一块内存地址
//      - 访问时间发生重叠
//  * 内存访问时长
//      - 瞬时访问，大部分内存访问是瞬时的
//      - 长期访问，嵌套调用其它代码
//      - 相交 : 长期访问可能与另一个长期访问或者瞬时访问相交
func oneMore(than number: Int) -> Int {
    return number + 1
}
var myNumber = 1
myNumber = oneMore(than: myNumber)
print(myNumber)

// Conflicting Access to In-Out Parameters - In-Out 参数引起的访问冲突
//  * 函数对它的所有 in-out 参数拥有长期写访问权，直到函数调用完毕

var stepSize = 1
func increment(_ number: inout Int) {
    number += stepSize
}
increment(&stepSize)

var copyOfStepSize = stepSize
increment(&copyOfStepSize)
stepSize = copyOfStepSize

func balance(_ x: inout Int, _ y: inout Int) {
    let sum = x + y
    x = sum / 2
    y = sum - x
}
var playerOneScore = 42
var playerTwoScore = 30
balance(&playerOneScore, &playerTwoScore) // 访问不同内存地址，不发生重叠
//balance(&playerOneScore, &playerOneScore)
//  * 错误:
//      - 两个 in-out 参数调用同一块内存地址，发生重叠

//: Conflicting Access to self in Methods (方法内部 self 的访问冲突)
//  * 一个结构体的 mutating 方法在其呗调用期间对 self 有写访问权

struct Player {
    var name: String
    var health: Int
    var energy: Int
    
    static let maxHealth = 10
    mutating func restoreHealth() {
        health = Player.maxHealth
    }
}
extension Player {
    mutating func shareHealth(with teammate: inout Player) {
        balance(&teammate.health, &health)
    }
}
var oscar = Player(name: "Oscar", health: 10, energy: 10)
var maria = Player(name: "Maria", health: 5, energy: 10)
oscar.shareHealth(with: &maria)
//oscar.shareHealth(with: &oscar)
//  * 错误：重叠访问
//      - mutating 方法对 self 有写访问权
//      - in-out 参数对 teammate 有写访问权
//      - self 和 teammate 指向同一内存地址，发生重叠


//: Conflicting Access to Properties (属性访问冲突)
//  * 值类型(结构体、元组、枚举...)改变其中一个值就相当于改变其整体
//  * 对值类型一个属性的读写访问，就需要对其整体进行读写访问
//  * 结构体重叠访问安全条件
//      - 访问的是实例变量的存储属性(不是计算属性)，也不是类属性
//      - 结构体是局部变量，而不是全局变量
//      - 结构体没有被任意闭包捕获，或者仅被非逃逸闭包捕获

var playerInformation = (health: 10, energy: 20)
balance(&playerInformation.health, &playerInformation.energy)
print(playerInformation)

var holly = Player(name: "Holly", health: 12, energy: 10)
balance(&holly.health, &holly.energy)
print(holly)

func someFunction() {
    var oscar = Player(name: "Oscar", health: 14, energy: 10)
    balance(&oscar.health, &oscar.energy)
    print(oscar)
}
someFunction()

//: [Access Control](@next)
