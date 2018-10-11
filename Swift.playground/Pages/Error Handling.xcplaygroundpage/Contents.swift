//: [Optional Handling](@previous)

//: ## Error Handling : 错误处理

//: Representing and Throwing Errors (表示和抛出错误)
//  * Error 是一个空协议，表明遵循该协议的类型就可以用于错误处理
//  * Swift 中枚举特别适合进行错误建模

enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

//: Handling Errors (处理错误)
//  * Swift 错误处理不会展开调用堆栈(此过程计算成本很大)

// Propagating Errors Using Throwing Functions - 使用抛出函数传递错误
//  * throws 关键字标记抛出函数
//  * 非抛出函数必须在函数内部处理错误

func canThrowErrors() throws -> String { return "" }
func cannotThrowErrors() -> String { return "" }

struct Item {
    var price: Int
    var count: Int
}
class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0
    
    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        coinsDeposited -= item.price
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispensing \(name)")
    }
}

let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]
func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}

struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}

// Handling Errors Using Do-Catch - 使用 do-catch 处理错误
//  * catch 不需要处理 do 抛出的所有可能错误

var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
    print("Success! Yum.")
} catch VendingMachineError.invalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.outOfStock {
    print("Out of Stock.")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
} catch {
    print("Unexpected error: \(error).")
}

func nourish(with item: String) throws {
    do {
        try vendingMachine.vend(itemNamed: item)
    } catch is VendingMachineError { // 处理错误枚举中的所有错误类型
        print("Invalid selection, out of stock, or not enough money.")
    }
}

do {
    try nourish(with: "Beet-Flavored Chips")
} catch {
    print("Unexpected non-vending-machine-related error: \(error)")
}

// Converting Errors to Optional Values - 将错误转换为可选值
//  * try? 将错误转换为可选值来处理错误

func someThrowingFunction() throws -> Int {
    return 0
}
let x = try? someThrowingFunction()
/**
let y: Int?
do {
    y = try someThrowingFunction()
} catch {
    y = nil
}
 */

/**
func fetchData() -> Data? {
    if let data = try? fetchDataFromDisk() { return data }
    if let data = try? fetchDataFromServer() { return data }
    return nil
}
 */

// Disabling Error Propagation - 禁止错误传播
//  * try! 禁止错误传播，将调用过程包装到运行断言中，运行时会收到错误。

//let photo = try! loadImage(atPath: "./Resources/John Appleseed.jpg")

//: Specifying Cleanup Actions (指定清理操作)
//  * defer 退出之前延迟执行

/**
func processFile(filename: String) throws {
    if exists(filename) {
        let file = open(filename)
        defer {
            close(file)
        }
        while let line = try file.readline() {
            // 处理文件
        }
        // 关闭文件
    }
}
*/


//: [Type Casting](@next)
