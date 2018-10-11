//: [Inheritance](@previous)

//: ## Initialization : 构造过程
//  * 区别于 Objective-C 的构造器，Swift构造器不返回值
//  * 析构器 : 用于释放实例前执行自定义的清理工作

//: Setting Initial Values for Stored Properties (设置存储属性的初始值)
//  * 存储属性设置默认值以及在构造器中设置初始值时，是直接设置属性值，不会调用属性观察器

// Initializers - 构造器
//  * init 关键字创建构造器
struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}
var f = Fahrenheit()
print("The default temperature is \(f.temperature)° Fahrenheit")

// Default Property Values - 默认属性值
//  * 默认值更容易使用默认构造器和构造器继承
struct Fahrenheit1 {
    var temperature = 32.0
}

//: Customizing Initialization (自定义构造过程)

// Initialization Parameters - 构造参数
struct Celsius { // 摄氏温度
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) { // 华氏温度
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) { // 开氏温度
        temperatureInCelsius = kelvin - 273.15
    }
}
let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
let freezingPointOfWater = Celsius(fromKelvin: 273.15)

// Parameter Names and Argument Labels - 内部参数名和外部参数名
struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
}
let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)
// 不使用外部参数名无法调用构造器
//let veryGreen = Color(0.0, 1.0, 0.0)

// Initializer Parameters Without Argument Labels - 无外部参数名的构造器
//  * _ 下划线来代替显式外部参数民
struct Celsius1 {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}
let bodyTemperature = Celsius1(37.0)

// Optional Property Types - 可选属性类型
//  * ? 标记可选属性
//  * 可选属性会自动被初始化为 nil
class SurveyQuestion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
cheeseQuestion.response = "Yes, I do like cheese."

// Assigning Constant Properties During Initialization - 在构造过程中给常量复制
//  * 可以在构造期间给常量属性复制，只要构造完成之前设置确定值就行。
//  * 常量值设置之后不能再修改
//  * 注：
//      - 常量属性只能在定义常量属性的类构造器中设置，不能在派生类中设置。
class SurveyQuestion1 {
    let text: String // 常量
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let beetsQuestion = SurveyQuestion1(text: "How about beets?")
beetsQuestion.ask()
beetsQuestion.response = "I also like beets. (But not with cheese.)"

//: Default Initializers (默认构造器)
//  * 默认构造器 : 属性值均有默认值，但是没有构造器的类或者结构体

class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()

// Memberwise Initializers for Structure Types - 结构体类型的成员构造器
//  * 成员构造器 : 结构体每个成员属性的构造器
//  * 如果结构体没有任何自定义构造器，结构体会自动创建一个成员构造器
//  * 成员构造器不同于默认构造器，即使属性没有默认值，也会自动创建

struct Size {
    var width = 0.0, height = 0.0
}
let zeroByzero = Size()
let twoByTwo = Size(width: 2.0, height: 2.0)

//: Initializer Delegation for Value Types (值类型构造器代理)
//  * 构造器代理 : 构造器可以调用其它构造器来执行部分构造过程

struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    init() {}
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}
let basicRect = Rect()
let originRect = Rect(origin: Point(x: 2.0, y: 2.0),
                      size: Size(width: 5.0, height: 5.0))
let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                      size: Size(width: 3.0, height: 3.0))

//: Class Inheritance and Initialization (类的继承和构造过程)
//  * 类的所有存储属性(包括从父类继承的)，必须在构造过程中赋值
//  * 构造器类型
//      - 指定构造器
//      - 便利构造器

// Designated Initializers and Convenience Initializers - 指定构造器和便利构造器
//  * 指定构造器 : 类的主要构造器，每一个类至少有一个指定构造器
//  * 便利构造器 : 类的辅助构造器，调用指定构造器来设置一些参数的默认值

// Syntax for Designated and Convenience Initializers - 指定构造器和便利构造器语法
// * convernience 关键字标记便利构造器

/**
// 指定构造器
init(parameters) {
    statements
}
// 便利构造器
convenience init(parameters) {
    statements
}
*/

// Initializer Delegation for Class Types - 类的构造代理
//  * 三条规则：
//      - 指定构造器必须调用器真系父类的指定构造器
//      - 便利构造器必须调用同一类中的其它构造器
//      - 便利构造器最后必须调用指定构造器
//  * 记忆方法：
//      - 指定构造器必须向上代理
//      - 便利构造器必须横向代理

// Two-Phase Initialization - 两段式构造过程
//  * 两段式过程
//      - 1. 为类引入的每个存储属性设置初始值
//          + 在类中调用指定或者遍历构造器
//          + 对一个新实例分配内存，但内存还没有初始化
//          + 指定构造器确认其所属类的所有存储属性都有值。存储属性内存初始化完成。
//          + 指定构造器移交给父类构造器为其存储属性执行初始化
//          + 沿着继承链向上到达最顶层基类
//          + 继承链上所有存储属性都有值，内存初始化完成
//      - 2. 新的实例被认为可以使用前，每个类都有机会进一步定制其存储属性
//          + 从链顶往下，每个指定构造器可以进一步定制实例
//          + 构造器可以访问 self 并修改属性，调用实例方法
//          + 链上的任何便利构造器可以定制实例以及使用 self
//  * 四个安全检查
//      - 1. 指定构造器必须确定其类引入的所有属性在向上代理父类构造器之前完成初始化
//      - 2. 指定构造器必须在继承属性赋值前向上代理父类构造器
//      - 3. 便利构造器必须在任何属性赋值前代理指定构造器
//      - 4. 构造器在第一阶段完成前，不能调用任何实例方法，不能读取任何实例属性的值，也不能使用 self


// Initializer Inheritance and Overriding - 构造器的继承和重写
//  * 派生类默认不继承父类构造器
//      - 防止定制化的派生类继承父类简单构造器
//      - 防止简单构造器用于创建不完全初始化或错误初始化的派生类实例
//  * 注：
//      - 在安全和合适情况下(自动构造器继承)，父类构造器是可以继承的

class Vehicle { // 交通工具
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}
let vehicle = Vehicle()
print("Vehicle: \(vehicle.description)")

class Bicycle: Vehicle { // 自行车
    override init() {
        super.init()
        numberOfWheels = 2
    }
}
let bicycle = Bicycle()
print("Bicycle: \(bicycle.description)")

class Hoverboard: Vehicle { // 漂浮滑板
    var color: String
    init(color: String) {
        self.color = color
        // super.init() 在这里隐式调用
    }
    override var description: String {
        return "\(super.description) in a beautiful \(color)"
    }
}
let hoverboard = Hoverboard(color: "silver")
print("Hoverboard: \(hoverboard.description)")

// Automatic Initializer Inheritance - 自动构造器的继承
//  * 自动继承两种情况
//      - 派生类没有定义任何指定构造器，会自动继承父类所有的指定构造器
//      - 派生类为父类所有指定构造器提供了实现
//  * 注：
//      - 派生类可以用便利构造器实现父类指定构造器以实现自动继承

// Designated and Convenience Initializers in Action - 实践指定构造器和便利构造器
class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}
let namedMeat = Food(name: "Bacon")
let mysteryMeat = Food()

class RecipeIngredient: Food { // 食谱配料
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) { // 便利构造器重写父类指定构造器
        self.init(name: name, quantity: 1)
    }
}
let oneMysteryItem = RecipeIngredient() // 派生类实现了父类所有指定构造器，继承了父类便利构造器 init()
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)

// 所有属性有默认值，并且没有任何构造器，自动继承父类所有指定构造器和便利构造器
class ShoppingListItem1: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}

var breakfastList = [
    ShoppingListItem1(),
    ShoppingListItem1(name: "Bacon"),
    ShoppingListItem1(name: "Eggs", quantity: 6),
]
breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.description)
}


//: Failable Initializers (可失败构造器)
//  * init? 声明可失败构造器
//  * return nil 表示触发失败，构造器没有返回值，return nil 仅用于触发失败，构造器不使用 return 返回值

let wholeNumber: Double = 12345.0
let pi = 3.14159
if let valueMaintained = Int(exactly: wholeNumber) {
    print("\(wholeNumber) conversion to Int maintains value of \(valueMaintained)")
}
let valueChanged = Int(exactly: pi)
if valueChanged == nil {
    print("\(pi) conversion to Int does not maintain value")
}

struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty { return nil }
        self.species = species
    }
}
let someCreature = Animal(species: "Giraffe")
if let giraffe = someCreature {
    print("An animal was initialized with a species of \(giraffe.species)")
}
let anonymousCreature = Animal(species: "")
if anonymousCreature == nil {
    print("The anonymous creature could not be initialized")
}

// Failable Initializers for Enumerations - 枚举的可失败构造器
enum TemperatureUnit {
    case kelvin, celsius, fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .kelvin
        case "C":
            self = .celsius
        case "F":
            self = .fahrenheit
        default: // 不匹配任何枚举值，构造失败
            return nil
        }
    }
}
let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}
let unknownUnit = TemperatureUnit(symbol: "X")
if unknownUnit == nil {
    print("This is not a defined temperature unit, so initialization failed.")
}

// Failable Initializers for Enumerations with Raw Values - 带有原始值枚举的可失败构造器
//  * 带原始值的枚举会自动生成一个可失败构造器 init?(rawValue:)
enum TemperatureUnit1: Character {
    case kelvin = "K", celsius = "C", fahrenheit = "F"
}
let fahrenheitUnit1 = TemperatureUnit1(rawValue: "F")
if fahrenheitUnit1 != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}
let unknownUnit1 = TemperatureUnit1(rawValue: "X")
if unknownUnit1 == nil {
    print("This is not a defined temperature unit, so initialization failed.")
}

// Propagation of Initialization Failure - 构造失败的传递
//  * 可以横向代理同一类型中其它可失败构造器
//  * 可以向上代理父类的可失败构造器
//  * 注：
//      - 可失败构造器可以代理一个非失败构造器

class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 { return nil }
        self.quantity = quantity
        super.init(name: name)
    }
}

if let twoSocks = CartItem(name: "sock", quantity: 2) {
    print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
}
if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
    print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
} else {
    print("Unable to initialize zero shirts")
}
if let oneUnnamed = CartItem(name: "", quantity: 1) {
    print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
} else {
    print("Unable to initialize one unnamed product")
}

// Overriding a Failable Initializer - 重写可失败构造器
//  * 需要强制解包(force-unwrap)父类可失败构造器结果
//  * 注：
//      - 非失败构造器可以重写可失败构造器
//      - 可失败构造器不能重写非失败构造器

class Document {
    var name: String?
    init() {}
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}
class AutomaticallyNamedDocument: Document { // 自动命令文档
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}
class UntitledDocument: Document { // 无标题文档
    override init() {
        super.init(name: "[Untitled]")! // 强制解包
    }
}

// The init! Failable Initializer - init! 可失败构造器
//  * init? 创建一个可选类型实例的可失败构造器
//  * init! 创建一个隐私解包可选类型的可失败构造器
//  * 注:
//      - init! 构造失败会触发断言


//: Required Initializers (必要构造器)
//  * 每个派生类必须实现此构造器
//  * required 关键字标记必要构造器
//  * 子类重写必要构造器，不需要使用 override
//  * 注:
//      - 子类符合继承构造器要求，就不需要显示实现必要构造器

class SomeClass {
    required init() {
    }
}
class SomeSubclass: SomeClass {
    required init() {
    }
}

//: Setting a Default Property Value with a Closure or Function (使用闭包或者函数设置默认属性值)
//  * 类型实例初始化时，闭包或者函数就会被调用，返回值作为属性的默认值
//  * 注：
//      - 闭包执行时，实例还未初始化，不能访问其他属性，也不能使用 self

struct Chessboard {
    let boardColors: [Bool] = { // 闭包作为属性默认值
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...8 {
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }() // 闭包后面括号，通知 Swift 立即执行闭包
    func squareIsBlackAt(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
}
let board = Chessboard()
print(board.squareIsBlackAt(row: 0, column: 1))
print(board.squareIsBlackAt(row: 7, column: 7))


//: [Deinitialization](@next)
