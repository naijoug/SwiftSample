//: [Strings and Characters](@previous)

// Collection Types : 集合类型

//: Mutability of Collections (集合的可变性)
//  * 赋值给变量集合中的元素可以改变
//  * 赋值给常量集合的大小和内容不可改变

//: Arrays (数组)

// Array Type Shorthand Syntax - 数组类型简写语法
//  * 完整写法 - Array<Element>
//  * 简写写法 - [Element]  // 推荐写法

// Creating an Empty Array - 创建一个空数组
var someInts = [Int]()
print("someInts is of type [Int] with \(someInts.count) items.")

someInts.append(3)
someInts = []

// Creating an Array with a Default Value - 使用默认值创建数组
var threeDoubles = Array(repeating: 0.0, count: 3)

// Creating an Array by Adding Two Arrays Together - 通过连接两个数组来创建数组
var anotherThreeDoubles = Array(repeating: 2.5, count: 3)
var sixDoubles = threeDoubles + anotherThreeDoubles

// Creating an Array with an Array Literal - 使用数组字面量创建数组
var shoppingList: [String] = ["Eggs", "Milk"]
var shoppingList1 = ["Eggs", "Milk"]

// Accessing and Modifying an Array - 访问和修改数组
print("The shopping list contains \(shoppingList.count) items.")

if shoppingList.isEmpty {
    print("The shopping list is empty.")
} else {
    print("The shopping list is not empty.")
}

shoppingList.append("Flour")
shoppingList += ["Baking Powder"]
shoppingList += ["Chocolate Spread", "Cheese", "Butter"]

var firstItem = shoppingList[0]
shoppingList[0] = "Six eggs"
shoppingList[4...6] = ["Bananas", "Apples"]
shoppingList.insert("Maple Syrup", at: 0)

let mapleSyrup = shoppingList.remove(at: 0)
firstItem = shoppingList[0]
let apples = shoppingList.removeLast()

// Iterating Over an Array - 遍历数组
for item in shoppingList {
    print(item)
}

// enumerated() 返回数组元素的元组
for (index, value) in shoppingList.enumerated() {
    print("Item \(index + 1): \(value)")
}

//: Sets (集合)
//  * 无序存储的集合

// Hash Values for Set Types - Set 类型的哈希值
//  * 存储在集合当中的元素必须是可哈希的。
//  * 需要遵循 Hashable 协议，需要提供一个 hashValue 的属性
//  * Hashable 遵循 Equatable 协议，需要实现一个 == 运算符(满足三个条件)
//      - 自反性 ( a == a )
//      - 对称性 ( a == b  ==>  b == a )
//      - 传递性 ( a == b && b == c  ==>  a == c )

// Set Type Syntax - 结合类型语法
//  * 写法 : Set<Element> ，没有简写

// Creating and Initializing an Empty Set - 创建并初始化一个空集合
var letters = Set<Character>()
print("letters is of type Set<Character> with \(letters.count) items.")

letters.insert("a")
letters = []

// Creating a Set with an Array Literal - 使用数组字面量创建一个集合
var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
var favoriteGenres1: Set = ["Rock", "Classical", "Hip hop"]

// Accessing and Modifying a Set - 访问和修改集合
print("I have \(favoriteGenres.count) favorite music genres.")

if favoriteGenres.isEmpty {
    print("As far as music goes, I'm not picky.")
} else {
    print("I have particular music preferences.")
}

favoriteGenres.insert("Jazz")

if let removedGenre = favoriteGenres.remove("Rock") {
    print("\(removedGenre)? I'm over it.")
} else {
    print("I never much cared for that.")
}

if favoriteGenres.contains("Funk") {
    print("I get up on the good foot.")
} else {
    print("It's too funky in here.")
}

// Iterating Over a Set - 遍历集合
for genre in favoriteGenres {
    print("\(genre)")
}

// sorted() 使用 < 运算符排序
for genre in favoriteGenres.sorted() {
    print("\(genre)")
}

//: Performing Set Operations (执行集合操作)

// Fundamental Set Operations - 基本集合操作
let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

oddDigits.union(evenDigits).sorted()    // 两个集合的所有值
oddDigits.intersection(evenDigits).sorted() // 两个集合的共有值
oddDigits.subtracting(singleDigitPrimeNumbers).sorted() // 两个集合不包含另一个集合中的值的剩余值
oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted() // 两个集合非共有值得其它值

// Set Membership and Equality - 集合成员关系和相等性
let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]
houseAnimals.isSubset(of: farmAnimals)      // 是否为另一个集合的子集合
farmAnimals.isSuperset(of: houseAnimals)    // 是否为另一个集合的父集合
farmAnimals.isDisjoint(with: cityAnimals)   // 判断两个集合是否完全没有交集

//: Dictionaries (字典)

// Dictionary Type Shorthand Syntax - 字典类型的简写语法
//  * 完整写法 : Dictionary<Key, Value>
//  * 简写写法 : [Key: Value]
//  * Key 必须遵循 Hashable 协议

// Creating an Empty Dictionary - 创建一个空字典
var namesOfIntegers = [Int: String]()

namesOfIntegers[16] = "sixteen"
namesOfIntegers = [:]

// Creating a Dictionary with a Dictionary Literal - 用字典字面量创建字典
var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
var airports1 = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

// Accessing and Modifying a Dictionary - 访问和修改字典
print("The airports dictionary contains \(airports.count) items.")

if airports.isEmpty {
    print("The airports dictionary is empty.")
} else {
    print("The airports dictionary is not empty.")
}

airports["LHR"] = "London"
airports["LHR"] = "London Heathrow"

if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
    print("The old value for DUB was \(oldValue).")
}

if let airportName = airports["DUB"] {
    print("The name of the airport is \(airportName).")
} else {
    print("That airport is not in the airports dictionary.")
}

airports["APL"] = "Apple International"
airports["APL"] = nil

if let removedValue = airports.removeValue(forKey: "DUB") {
    print("The removed airport's name is \(removedValue).")
} else {
    print("The airports dictionary does not contain a value for DUB.")
}

// Iterating Over a Dictionary - 遍历字典
for (airportCode, airportName) in airports {
    print("\(airportCode): \(airportName)")
}

for airportCode in airports.keys {
    print("Airport code: \(airportCode)")
}
for airportName in airports.values {
    print("Airport name: \(airportName)")
}

let airportCodes = [String](airports.keys)
let airportNames = [String](airports.values)

//: [Control Flow](@next)
