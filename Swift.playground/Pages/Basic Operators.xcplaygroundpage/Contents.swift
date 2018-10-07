//: [The Basics](@previous)

//: ## Basic Operators (基本运算符)

//: Terminology (术语)
/**
 一元 : 一个目标进行操作 ( -a )
 二元 : 两个目标进行操作 ( 2 + 3 )
 三元 : 三个目标进行操作 ( a ? b : c)
 */

//: Assignment Operator (赋值操作)

let b = 10
var a = 5
a = b

let (x, y) = (1, 2)

//: Arithmetic Operator (算术运算符)

1 + 2       // 加 Addition
5 - 3       // 减 Subtraction
2 * 3       // 乘 Multiplication
10.0 / 2.5  // 除 Division

"hello, " + "world"

// Remainder Operator - 余数运算符
9 % 4
-9 % 4

// Unary Minus Operator - 一元减号运算符
let three = 3
let minusThree = -three
let plusThree = -minusThree

// Unary Plus Operator - 一元加号运算符
let minusSix = -6
let alsoMinusSix = +minusSix // 不会对值有修改

//: Compound Assignment Operators (组合赋值符号)

var aa = 1
aa += 2

//: Comparison Operators (比较运算符)

1 == 1
2 != 1
2 > 1
1 < 2
1 >= 1
2 <= 1

let name = "world"
if name == "world" {
    print("hello, world")
} else {
    print("I'm sorry \(name), but I don't recognize you")
}

// 同样数量值得元组可以进行比较，元组的每个值是可以比较的。
// 如 : (Int, String) - Int & String 均可以进行比较
// 元组比较规则: 从左到右比较
//      1. 所有值均相等则元组相等
//      2. 两个值比较出大小，则不进行后面比较
(1, "zebra") < (2, "apple")     // true -> 1 < 2
(3, "apple") < (3, "bird")      // true -> apple < bird
(4, "dog") == (4, "dog")        // true -> 两个值均相等

("blue", -1) < ("purple", 1)    // true -> blue < purple
//("blue", false) < ("purple", true) // Bool 不能进行比较，所以含有 Bool 的元组不能进行比较大小


//: Ternary Conditional Operator (三元条件运算符)

let contentHeight = 40
let hasHeader = true
let rowHeight = contentHeight + (hasHeader ? 50 : 20)

// 复杂写法
/**
let contentHeight1 = 40
let hasHeader1 = true
// error: variables currently must have an initial value when entered at the top level of the REPL
let rowHeight1: Int
if hasHeader1 {
    rowHeight1 = contentHeight1 + 50
} else {
    rowHeight1 = contentHeight1 + 20
}
 */

//: Nil-Coalescing Operator (合并控制运算符)
// a ?? b -> (a != nil) ? a! : b
// a! : 强制展开 a

let defaultColorName = "red"
var userDefinedColorName: String?
var colorNameToUse = userDefinedColorName ?? defaultColorName

userDefinedColorName = "green"
colorNameToUse = userDefinedColorName ?? defaultColorName

//: Range Operators (区间运算符)

// Closed Range Operator - 闭区间运算符
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}

// Half-Open Range Operator - 半开区间运算符
let names = ["Anna", "Alex", "Brian", "Jack"]
let count = names.count
for i in 0..<count {
    print("Person \(i + 1) is called \(names[i])")
}

// One-Sided Ranges - 单侧区间
for name in names[2...] { // 2、3
    print(name)
}
for name in names[...2] { // 0、1、2
    print(name)
}
for name in names[..<2] { // 0、1
    print(name)
}

let range = ...5 // 负无穷 ~ 5
range.contains(7)
range.contains(4)
range.contains(-1)
range.contains(-10000)

//: Logical Operators (逻辑运算符)

// Logical NOT Operator - 逻辑非
let allowedEntry = false
if !allowedEntry {
    print("ACCESS DENIED")
}

// Logical AND Operator - 逻辑与
let enteredDoorCode = true
let passedRetinaScan = false
if enteredDoorCode && passedRetinaScan {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}

// Logical OR Operator - 逻辑或
let hasDoorKey = false
let knowsOverridePassword = true
if hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}

// Combining Logical Operators - 混合逻辑运算
if enteredDoorCode && passedRetinaScan || hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}

// Explicit Parentheses - 显示括号
if (enteredDoorCode && passedRetinaScan) || hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}

//: [Strings and Characters](@next)
