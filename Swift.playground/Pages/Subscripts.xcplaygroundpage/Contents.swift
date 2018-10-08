//: [Methods](@previous)

//: ## Subscripts : 下标
//  * 类、结构体和枚举都可以定义下标
//  * 下标是用于访问集合、列表或者序列的成员的快捷方式

//: Subscript Syntax (下标语法)

struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int { // 只读下标，省略 get
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")

//: Subscript Usage (下标的用法)

var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
numberOfLegs["bird"] = 2

//: Subscript Options (下标选项)
//  * 下标可以设置任意数量的输入参数，输入参数可以是任意类型
//  * 下标可以返回任何类型
//  * 下标可以使用可变参数，但是不能使用 inout 参数，也不能提供默认参数值

struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}
var matrix = Matrix(rows: 2, columns: 2)
matrix[0, 1] = 1.5
matrix[1, 0] = 3.2
let someValue = matrix[2, 2]


//: [Inheritance](@next)
