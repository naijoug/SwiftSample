//: [Memory Safety](@previous)

//: ## Access Control : 访问控制
//  * 访问控制 : 限制其他资源文件或模块的代码对你代码的访问
//  * 功能:
//      - 隐藏代码的实现细节
//      - 可以指定一个喜欢的接口，通过这个接口被访问和使用
//  * 实体 : 可以被设置访问的各部分(属性、方法、初始化器、下标...)

//: Modules and Source Files (模块和资源文件)
//  * Swift 访问控制模型是基于模块和资源文件的概念
//  * module : 模块，代码分发的独立单元
//      - 可以作为以独立单元被不见和发的 Framework 或 Application
//      - 可以被另一个模块使用 import 引入
//  * source file : 资源文件，模块中单独的 Swift 源代码文件

//: Access Levels (访问级别)
//  * 五种访问级别
//      - open : 最高访问级别，实体可以在定义模块任何文件中使用，也可以在引入模块的文件中使用
//      - public : 与 open 一样
//          + 用于 framework 声明公共接口
//      - internal : 可以在定义模块中的任何文件中使用，不能再引入模块中使用
//          + 定义一个 application
//          + 定义 framework 的内部结构
//      - file-private : 只能在所它所定义的源文件中使用
//          + 定义一个特定功能片段供整个文件使用
//      - private : 最低访问级别，只能同一文件中附加声明、扩展声明
//          + 定义一个特定功能片段仅呗单个声明中使用
//  * open 与 public 区别
//      - open 仅用于类和类的成员
//      - public 修饰的类，仅可以被定义模块的类继承
//      - open 修饰的类，可以被其定义模块和引入模块的类继承
//      - public 修饰的类成员，仅可以被其定义模块的子类重载
//      - open 修改时的类成员，可以被其定义模块和引入模块的子类重载

// Guiding Principle of Access Levels - 访问级别的使用原则
//  * 任何实体都不能在另一个更低访问级别的实体中定义
//      - public 的变量不能定义在一个 (internal、file-private 或 private)的类型中
//      - 函数不能拥有比它参数、返回值类型拥有更高访问权限

// Default Access Levels - 默认访问级别
//  * internal : 默认访问级别

// Access Levels for Single-Target Apps - 单目标应用的访问级别
//  * 应用模块内的代码默认级别是 internal，所有可以相互访问。

// Access Levels for Frameworks - framework 的访问级别
//  * framework 需要将公共接口标记为 open 或 public，以供其它引入模块使用

// Access Levels for Unit Test Targets - 单元测试目标的访问级别
//  * 使用 @testable 标记模块，可以使单元测试访问任何内部实体


//: Access Control Syntax (访问控制语法)
//  * 访问控制修饰符放置在最前面

public class SomePublicClass {}
internal class SomeInternalClass {}
fileprivate class SomeFilePrivateClass {}
private class SomePrivateClass {}

public var somePublicVariable = 0
internal let someInternalConstant = 0
fileprivate func someFilePrivateFunction() {}
private func somePrivateFunction() {}

class SomeInternalClass1 {}        // 隐式
let someInternalConstant1 = 0      // 隐式

//: Custom Types (自定义类型)
//  * 类的访问控制级别会影响类的成员(属性、方法、构造器、下标)的默认访问级别
//      - 类为 private 或 file-private，则类成员为 private 或 file-private
//      - 类为 internal 或 public，则类成员为 internal
//  * public 类型的成员是 internal，需要显示标明 public，才可以为 public

public class SomePublicClass1 {                  // 显示 public 类
    public var somePublicProperty = 0            // 显示 public 属性
    var someInternalProperty = 0                 // 隐式 internal 属性
    fileprivate func someFilePrivateMethod() {}  // 显示 file-private 方法
    private func somePrivateMethod() {}          // 显示 private 方法
}
class SomeInternalClass2 {                       // 隐式 internal 类
    var someInternalProperty = 0                 // 隐式 internal 属性
    fileprivate func someFilePrivateMethod() {}  // 显示 file-private 方法
    private func somePrivateMethod() {}          // 显示 private 方法
}
fileprivate class SomeFilePrivateClass1 {        // 显示 file-private 类
    func someFilePrivateMethod() {}              // 隐式 file-private 方法
    private func somePrivateMethod() {}          // 显示 private 方法
}
private class SomePrivateClass1 {                // 显示 private 类
    func somePrivateMethod() {}                  // 隐式 private 方法
}

// Tuple Types - 元组类型
//  * 元组访问权限是元组中全部类型访问级别中限制性最强的
//      - 元组元素中，一个 internal，另一个 private，则元组访问级别为 private
//  * 元组的访问级别不能定义，是自动推导出来的

// Function Types - 函数类型
//  * 函数访问权限计算是函数参数和返回值中限制性最强的访问级别
//  * 函数计算的访问权限与上下文不匹配，则需要显示的指定

//func someFunction1() -> (SomeInternalClass, SomePrivateClass) {}
//  错误：计算的访问限制为 private 比函数默认的限制 internal 小，所以需要显示标记为 private
private func someFunction2() -> (SomeInternalClass, SomePrivateClass) {
    return (SomeInternalClass(), SomePrivateClass())
}

// Enumeration Types - 枚举类型
//  * 枚举中的成员自动使用枚举类型的访问级别
//  * 不能给枚举成员设置不同的访问级别
public enum CompassPoint {
    case north
    case south
    case east
    case west
}

// Raw Values and Associated Values - 原始值和关联值
//  * 枚举中原始值和关联值的类型访问级别不能低于枚举的访问级别
//      - 不能使用 private 类型作为 internal 枚举的原始值类型

// Nested Types - 嵌套类型
//  * 嵌套类型自动继承外部类的的访问级别

//: Subclassing (子类化)
//  * 子类不能拥有高于父类的访问级别
//      - 父类是 internal，子类不能是 public
//  * 重写类成员可以比父类更高访问级别
//      - 父类 file-private 的方法，子类可以重写为 internal 访问级别

public class A {
    fileprivate func someMethod() {}
}
internal class B: A {
    override internal func someMethod() {
        super.someMethod()
    }
}

//: Constants, Variables, Properties, and Subscripts (常量、变量、属性和下标)
//  * 常量、变量、属性访问级别不能高于其所在类型的访问级别
//  * 下标的访问级别不能高于其索引或返回值的访问级别

private var privateInstance = SomePrivateClass()

// Getters and Setters (get set 方法)
//  * get set 方法制动接收对应属性的访问级别
//  * set 方法可以设置比 get 方法访问级别更低的访问级别，来约束属性或下标
//      - 可以在 var 或 subscript 前面，添加修饰 fileprivate(set)、private(set) 或者 internal(set) 来约束 set 方法访问级别

struct TrackedString {
    private(set) var numberOfEdits = 0 // get 方法: internal ; set 方法: private
    var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
}
var stringToEdit = TrackedString()
//stringToEdit.numberOfEdits = 1 // 错误，不能访问
stringToEdit.value = "This string will be tracked."
stringToEdit.value += " This edit will increment numberOfEdits."
stringToEdit.value += " So will this one."
print("The number of edits is \(stringToEdit.numberOfEdits)")

public struct TrackedString1 {
    public private(set) var numberOfEdits = 0 // get 方法: public ; set 方法: private
    public var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
    public init() {}
}

//: Initializers (构造器)
//  * 自定义构造器的访问级别可以小于当前类型的访问级别
//  * 必须初始化器(required) 访问级别需要当前类型访问级别一直
//  * 构造器参数的访问级别不能小于当前构造器访问级别

// Default Initializers - 默认构造器
//  * 默认构造器与当前类型的访问级别相同
//  * 当前类型访问级别为 public，则默认构造器的访问级别为 internal
//  * public 的无参构造器必须显示声明

// Default Memberwise Initializers for Structure Types - 结构体的默认成员构造器
//  * 结构体任何一属性访问级别为 private 或 file-private，则默认成员构造器访问级别为 private 或 file-private
//  * 其它情况为 internal
//  * public 的成员构造器需要显示声明

//: Protocols (协议)
//  * 协议要求的的访问级别自动与协议访问级别一直，不能设置为不同级别
//  * 实现 public 协议的类型的访问级别也必须是 public

// Protocol Inheritance - 协议继承
//  * 继承协议的访问级别与继承协议相同
//      - internal 协议不能继承一个 public 协议

// Protocol Conformance - 协议一致性
//  * 一个类型可以实现访问级别更低的协议
//      - public 类型可以实现一个 internal 协议，但是只能在 internal 协议定义的模块使用
//  * 一个类型不能以两种访问级别实现协议
//      - public 类型实现一个 internal 协议，每个协议要求至少是 internal

//: Extensions (扩展)
//  * 扩展添加的成员与原始类型具有相同的默认访问级别
//      - 扩展 public 或 internal 类型，则默认访问级别为 internal
//      - 扩展 private 或 file-private，怎默认访问级别为 private 或 file-private
//  * 可以显示声明扩展的访问级别
//  * 扩展实现协议，则无法显示声明扩展的访问级别，协议的访问级别为扩展的协议实现的默认访问级别

// Private Members in Extensions - 扩展私有成员
//  * 类、结构体或枚举与原始类型定义在在同一文件的的扩展可以访问原始类型的一切
//  * 与原始类型定义在同一文件的扩展功能 :
//      - 原始声明的 private 成员，在同一文件中的扩展可以访问
//      - 一个扩展中定义的 private 成员，在同一文件中的原始声明(或另一个扩展)中访问

protocol SomeProtocol {
    func doSomething()
}
struct SomeStruct {
    private var privateVariable = 12
}
extension SomeStruct: SomeProtocol {
    func doSomething() {
        print(privateVariable)
    }
}
let someStruct = SomeStruct()
someStruct.doSomething()

//: Generics (泛型)
//  * 泛型参数或泛型函数的访问级别是两者访问级别的最小值

//: Type Aliases (类型别名)
//  * 定义的类型别名会被看作不同的类型
//  * 类型别名可以拥有小于或等于其所代表类型的访问级别
//      - private 类型别名，可以代表 private、file-private、internal、public 或 open 类型
//      - public 类型别名，不能代表 internal、file-private 或 private 类型
//  * 注：
//      - 适用于协议中的关联类型的类型别名

//: [Advanced Operators](@next)
