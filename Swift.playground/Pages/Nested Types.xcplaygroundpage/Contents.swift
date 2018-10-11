//: [Type Casting](@previous)

//: ## Nested Types : 嵌套类型

//: Nested Types in Action (嵌套类型实践)

struct BlackjackCard { // 扑克牌
    enum Suit: Character { // 嵌套的花色枚举
        case spades = "♠", hearts = "♡", diamonds = "♢", clubs = "♣"
    }
    enum Rank: Int { // 嵌套的牌值枚举
        case two = 2, three, four, five, six, seven, eight, nine, ten
        case jack, queen, king, ace
        struct Values {
            let first: Int, second: Int?
        }
        var values: Values {
            switch self {
            case .ace:
                return Values(first: 1, second: 11)
            case .jack, .queen, .king:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    // 属性和方法
    let rank: Rank, suit: Suit
    var description: String {
        var output = "suit is \(suit.rawValue),"
        output += " value is \(rank.values.first)"
        if let second = rank.values.second {
            output += " or \(second)"
        }
        return output
    }
}

let theAceOfSpades = BlackjackCard(rank: .ace, suit: .spades)
print("theAceOfSpades: \(theAceOfSpades.description)")

//: Referring to Nested Types (引用嵌套类型)

let heartsSymbol = BlackjackCard.Suit.hearts.rawValue

//: [Extensions](@next)
