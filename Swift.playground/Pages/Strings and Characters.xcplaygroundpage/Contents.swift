//: [Basic Operators](@previous)

//: ## Strings and Characters : 字符串和字符

//: String Literals (字符串字面量)

let someString = "Some string literal value" // 字符串字面量设置初始值

// Multiline String Literals - 多行字符串字面量
// 使用 """ 三个双引号括起来
let quotation = """
The White Rabbit put on his spectacles.  "Where shall I begin,
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on
till you come to the end; then stop."
"""

let singleLineString = "These are the same."
let multilineString = """
These are the same.
"""

// \ 反斜杠进行转义
let softWrappedQuotation = """
The White Rabbit put on his spectacles.  "Where shall I begin, \
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on \
till you come to the end; then stop."
"""
print(softWrappedQuotation)

let lineBreaks = """

This string starts with a line break.
It also ends with a line break.

"""
print(lineBreaks)

// Special Characters in String Literals - 字符串字面量中的特殊字符
let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
let dollarSign = "\u{24}"        // $
let blackHeart = "\u{2665}"      // ♥
let sparklingHeart = "\u{1F496}" // 💖

let threeDoubleQuotationMarks = """
Escaping the first quotation mark \"""
Escaping all three quotation marks \"\"\"
"""
print(threeDoubleQuotationMarks)

//: Initializing an Empty String (初始化一个空字符串)

var emptyString = ""
var anotherEmptyString = String()

if emptyString.isEmpty {
    print("Nothing to see here")
}

//: String Mutability (字符串可变性)

var variableString = "Horse"
variableString += " and carriage"

let constantString = "Highlander"
//constantString += " and another Highlander"

//: Strings Are Value Types (字符串是值类型)
//  * 进行复制和传递时，会被复制
//  * Swift 编译器进行字符串使用优化，实际拷贝只会在确实使用的时候进行

//: Working with Characters (操作字符)

for character in "Dog!🐶" {
    print(character)
}

let exclamationMark: Character = "!"

let catCharacters: [Character] = ["C", "a", "t", "!", "🐱"]
let catString = String(catCharacters)
print(catString)

//: Concatenating Strings and Characters (连接字符串和字符)
let string1 = "hello"
let string2 = " there"
var welcome = string1 + string2

var instruction = "look over"
instruction += string2

let exclamationMark1: Character = "!"
welcome.append(exclamationMark1)

let badStart = """
one
two
"""
let end = """
three
"""
print(badStart + end)

let goodStart = """
one
two

"""
print(goodStart + end)

//: String Interpolation (字符串插值)

let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"

//: Unicode (统一字符编码)

// Unicode Scalar Values - Unicode 标量
17718532464


// Extended Grapheme Clusters - 扩展字形集群

let eAcute: Character = "\u{E9}"                // é
let combinedEAcute: Character = "\u{65}\u{301}" // e  ́.

let precomposed: Character = "\u{D55C}"                  // 한
let decomposed: Character = "\u{1112}\u{1161}\u{11AB}"   // ᄒ, ᅡ, ᆫ

let enclosedEAcute: Character = "\u{E9}\u{20DD}"

let regionalIndicatorForUS: Character = "\u{1F1FA}\u{1F1F8}"

//: Counting Characters (字符统计)

let unusualMenagerie = "Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐪"
print("unusualMenagerie has \(unusualMenagerie.count) characters")

var word = "cafe"
print("the number of characters in \(word) is \(word.count)")
word += "\u{301}"
print("the number of characters in \(word) is \(word.count)")

//: Accessing and Modifying a String (访问和修改字符串)

// String Indices - 字符串索引
let greeting = "Guten Tag!"
greeting[greeting.startIndex]
greeting[greeting.index(before: greeting.endIndex)]
greeting[greeting.index(after: greeting.startIndex)]
let index = greeting.index(greeting.startIndex, offsetBy: 7)
greeting[index]

//greeting[greeting.endIndex]
//greeting.index(after: greeting.endIndex)

for index in greeting.indices {
    print("\(greeting[index]) ", terminator: "")
}

//: Inserting and Removing (插入和删除)

var welcome1 = "hello"
welcome1.insert("!", at: welcome1.endIndex)
welcome1.insert(contentsOf: " there", at: welcome1.index(before: welcome1.endIndex))

welcome1.remove(at: welcome1.index(before: welcome1.endIndex))
let range = welcome1.index(welcome1.endIndex, offsetBy: -6)..<welcome1.endIndex
welcome1.removeSubrange(range)


//: Substrings (子字符串)

let greeting1 = "Hello, world!"
let index1 = greeting1.firstIndex(of: ",") ?? greeting1.endIndex
let beginning = greeting1[..<index1]

let newString = String(beginning)


//: Comparing Strings (字符串比较)

// String and Character Equality - 字符串和字符相等性
let quotation1 = "We're a lot alike, you and I."
let sameQuotation = "We're a lot alike, you and I."
if quotation1 == sameQuotation {
    print("These two strings are considered equal")
}

let eAcuteQuestion = "Voulez-vous un caf\u{E9}?"
let combinedEAcuteQuestion = "Voulez-vous un caf\u{65}\u{301}?"
if eAcuteQuestion == combinedEAcuteQuestion {
    print("These two strings are considered equal")
}

let latinCapitalLetterA: Character = "\u{41}"
let cyrillicCapitalLetterA: Character = "\u{0410}"
if latinCapitalLetterA != cyrillicCapitalLetterA {
    print("These two characters are not equivalent.")
}

// Prefix and Suffix Equality - 前缀和后缀相等性
let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]
var act1SceneCount = 0
for scene in romeoAndJuliet {
    if scene.hasPrefix("Act 1 ") { // hasPrefix 判断字符串前缀
        act1SceneCount += 1
    }
}
print("There are \(act1SceneCount) scenes in Act 1")

var mansionCount = 0
var cellCount = 0
for scene in romeoAndJuliet {
    if scene.hasSuffix("Capulet's mansion") { // hasSuffix 判断字符串后缀
        mansionCount += 1
    } else if scene.hasSuffix("Friar Lawrence's cell") {
        cellCount += 1
    }
}
print("\(mansionCount) mansion scenes; \(cellCount) cell scenes")

//: Unicode Representations of Strings (字符串的 Unicode 表示法)

let dogString = "Dog‼🐶"

// UTF-8 Representation - UTF-8 表示法
for codeUnit in dogString.utf8 {
    print("\(codeUnit) ", terminator: "")
}
print("")

// UTF-16 Representation - UTF-16 表示法
for codeUnit in dogString.utf16 {
    print("\(codeUnit) ", terminator: "")
}
print("")

// Unicode Scalar Representation - Unicode 标量表示法
for scalar in dogString.unicodeScalars {
    print("\(scalar.value) ", terminator: "")
}
print("")

for scalar in dogString.unicodeScalars {
    print("\(scalar) ")
}

//: [Collection Types](@next)
