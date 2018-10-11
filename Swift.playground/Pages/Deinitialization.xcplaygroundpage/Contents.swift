//: [Initialization](@previous)

//: ## Deinitialization : 析构过程
//  * 析构器 : 在实例销毁之前会被立即调用
//  * deinit 关键字标记析构器
//  * 只有类才能有析构器，结构体和枚举没有析构器
//  * 析构器自动调用，不能自己调用析构器

//: How Deinitialization Works (析构器如何工作)

/**
    * 类只能有一个析构器
    * 析构器没有参数，没有括号
    * 实例在调用析构器之后才释放，所以析构器可以访问实例所有实例和方法
 deinit {
    //执行析构器
 }
 */

//: Deinitializers in Action (析构器实践)

class Bank {
    static var coinsInBank = 10_000
    static func distribute(coins numberOfCoinsRequested: Int) -> Int {
        let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    static func receive(coins: Int) {
        coinsInBank += coins
    }
}
class Player {
    var coinsInPurse: Int
    init(coins: Int) {
        coinsInPurse = Bank.distribute(coins: coins)
    }
    func win(coins: Int) {
        coinsInPurse += Bank.distribute(coins: coins)
    }
    deinit {
        Bank.receive(coins: coinsInPurse)
    }
}
var playerOne: Player? = Player(coins: 100)
print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
print("There are now \(Bank.coinsInBank) coins left in the bank")

playerOne!.win(coins: 2_000)
print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins")
print("The bank now only has \(Bank.coinsInBank) coins left")

playerOne = nil
print("PlayerOne has left the game")
print("The bank now has \(Bank.coinsInBank) coins")


//: [Optional Chaining](@next)
