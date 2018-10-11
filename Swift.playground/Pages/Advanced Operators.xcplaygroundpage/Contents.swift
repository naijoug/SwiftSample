//: [Access Control](@previous)

//: ## Advanced Operators : 高级运算符
//  * Swift 算术运算符默认不会溢出，溢出后可以被捕获作为错误处理
//  * 溢出运算符使用 & 符号开头 (如：&+...)


//: Bitwise Operators (按位运算符)
//  * 按位运算符可以操作数据结构体中的各个原始数据位
//  * 用处:
//      - 底层编程，如图像编程和设备驱动的创建
//      - 操作尾部数据源原始数据，如自定义通信协议数据的编码和解码

// Bitwise NOT Operator - 按位取反运算符
//  * 反转二进制中每一位数字( 1 -> 0, 0 -> 1 )
let initialBits: UInt8 = 0b00001111
let invertedBits = ~initialBits

// Bitwise AND Operator - 按位与运算符
let firstSixBits: UInt8 = 0b11111100
let lastSixBits: UInt8  = 0b00111111
let middleFourBits = firstSixBits & lastSixBits

// Bitwise OR Operator - 按位或运算符
let someBits: UInt8 = 0b10110010
let moreBits: UInt8 = 0b01011110
let combinedbits = someBits | moreBits

// Bitwise XOR Operator - 按位异或运算符
let firstBits: UInt8 = 0b00010100
let otherBits: UInt8 = 0b00000101
let outputBits = firstBits ^ otherBits

// Bitwise Left and Right Shift Operators - 按位左移和右移运算符
//  * << : 按位左移运算符，将所有二进制位左移n位数 ( == 乘以 2^n )
//  * >> : 按位右移运算符，将所有二进制位右移n位数 ( == 除以 2^n )

// Shifting Behavior for Unsigned Integers - 无符号整数的移位
//  * 将二进制数按位左移或右移
//  * 移动到该数存储空间之外的二进制位会被舍弃
//  * 将 0 插入移位操作之后的空留位

let shiftBits: UInt8 = 4   // 00000100
0b00000100
// 左移
shiftBits << 1             // 00001000
0b00001000
shiftBits << 2             // 00010000
0b00010000
shiftBits << 3             // 00100000
0b00100000
shiftBits << 4             // 01000000
0b01000000
shiftBits << 5             // 10000000
0b10000000
shiftBits << 6             // 00000000
0b00000000
// 右移
shiftBits >> 1             // 00000010
0b00000010
shiftBits >> 2             // 00000001
0b00000001
shiftBits >> 3             // 00000000
0b00000000


let pink: UInt32 = 0xCC6699 // 粉色
// 提取粉色的红绿蓝成分
let redComponent = (pink & 0xFF0000) >> 16    // 红色成分 ( 0xCC | 204 )
let greenComponent = (pink & 0x00FF00) >> 8   // 绿色成分 ( 0x66 | 102 )
let blueComponent = pink & 0x0000FF           // 蓝色成分 ( 0x99 | 153 )

// Shifting Behavior for Signed Integers - 有符号整形的移位
//  * 有符号整数的二进制表示 (二进制补码表示法)
//      - 第一位作为符号位(0 : 正数 ; 1 : 负数)
//      - 剩余位数为数值位
//  * 数值左移翻倍，右移减半
//  * 右移额外规则
//      - 右移空白位使用符号位填充(不是 0 填充)
0b00000100  //
0b11111100  // 1 1111100
0b01111100  // 128 - 4

//: Overflow Operators (溢出运算符)
//  * 溢出运算符
//      - &+ : 溢出加法运算符
//      - &- : 溢出减法运算符
//      - &* : 溢出乘法运算符

var potentialOverflow = Int16.max
// error: Execution was interrupted, reason: EXC_BAD_INSTRUCTION (code=EXC_I386_INVOP, subcode=0x0).
//potentialOverflow += 1 // 超过了 Int16 最大值

// Value Overflow - 值溢出
//  * 正向溢出 : 从最大有效值环绕到最小值
//  * 负向溢出 : 从最小有效值环绕到最大值

// 无符号溢出
var unsignedOverflow = UInt8.max
unsignedOverflow = unsignedOverflow &+ 1 // 正向溢出
var unsignedOverflow1 = UInt8.min
unsignedOverflow1 = unsignedOverflow1 &- 1 // 负向溢出
// 有符号溢出
var signedOverflow = Int8.min
signedOverflow = signedOverflow &- 1

//: Precedence and Associativity (优先级和关联性)
//  * 优先级 : 某些运算符比其它运算符拥有更高的优先级，优先参与运算
//  * 关联性 : 拥有相同优先级的运算符怎样组合在一起

2 + 3 % 4 * 5 // * % 比 + 拥有更高的优先级
2 + ((3 % 4) * 5)
2 + (3 * 5)
2 + 15

//: Operator Methods (运算符方法)
//  * 重载运算符 : 类和结构体可以提供现有运算符的实现

struct Vector2D {
    var x = 0.0, y = 0.0
}

extension Vector2D { // 重载 + 运算符
    static func + (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y + right.y)
    }
}
let vector = Vector2D(x: 3.0, y: 1.0)
let anotherVector = Vector2D(x: 2.0, y: 4.0)
let combinedVector = vector + anotherVector

// Prefix and Postfix Operators - 前缀和后缀运算符

extension Vector2D { // 重载一元运算符 -
    static prefix func - (vector: Vector2D) -> Vector2D {
        return Vector2D(x: -vector.x, y: -vector.y)
    }
}
let positive = Vector2D(x: 3.0, y: 4.0)
let negative = -positive
let alsoPositive = -negative

// Compound Assignment Operators - 复合赋值运算符
//  * 不能重载默认的赋值运算符 = ，可以重载复合赋值运算符
//  * 三元条件运算符 ( a ? b : c ) 也不能重载

extension Vector2D { // 重载加法赋值运算符 +=
    static func += (left: inout Vector2D, right: Vector2D) {
        left = left + right
    }
}
var original = Vector2D(x: 1.0, y: 2.0)
let vectorToAdd = Vector2D(x: 3.0, y: 4.0)
original += vectorToAdd

// Equivalence Operators - 等价运算符
//  * 需要实现 Equtable 协议
//  * 等号运算符的实现
//      - 结构体只包含符合 Equatable 协议的存储属性
//      - 枚举只包含符合 Equatable 协议的关联类型
//      - 枚举不包含关联类型

extension Vector2D: Equatable {
    static func == (left: Vector2D, right: Vector2D) -> Bool {
        return (left.x == right.x) && (left.y == right.y)
    }
}
let twoThree = Vector2D(x: 2.0, y: 3.0)
let anotherTwoThree = Vector2D(x: 2.0, y: 3.0)
if twoThree == anotherTwoThree {
    print("These two vectors are equivalent.")
}

struct Vector3D: Equatable {
    var x = 0.0, y = 0.0, z = 0.0
}
let twoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
let anotherTwoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
if twoThreeFour == anotherTwoThreeFour {
    print("These two vectors are also equivalent.")
}

//: Custom Operators (自定义运算符)
//  * operator 关键字在全局声明新的运算符
//  * 修饰符标记
//      - prefix    : 前缀
//      - infix     : 中缀
//      - postfix   : 后缀

prefix operator +++
extension Vector2D {
    static prefix func +++ (vector: inout Vector2D) -> Vector2D {
        vector += vector
        return vector
    }
}
var toBeDoubled = Vector2D(x: 1.0, y: 4.0)
let afterDoubling = +++toBeDoubled

// Precedence for Custom Infix Operators - 自定义中缀运算符优先级
//  * 未定义优先级的自定义中缀运算符，被放入默认优先级组
//  * 前缀和后缀运算符不需要指定优先级，同时使用前缀和后缀运算符，优先使用后缀运算符

infix operator +-: AdditionPrecedence // 自定义中缀操作符 +- ，属于优先级组 AdditionPrecedence
extension Vector2D {
    static func +- (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y - right.y)
    }
}
let firstVector = Vector2D(x: 1.0, y: 2.0)
let secondVector = Vector2D(x: 3.0, y: 4.0)
let plusMinusVector = firstVector +- secondVector
