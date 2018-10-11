//: [Error Handling](@previous)

//: ## Type Casting : 类型转换

//: Defining a Class Hierarchy for Type Casting (定义一个层次类作为类型转换)

class MediaItem { // 多媒体类型
    var name: String
    init(name: String) {
        self.name = name
    }
}
class Movie: MediaItem { // 电影
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}
class Song: MediaItem { // 歌曲
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]

//: Checking Type (类型检查)
//  * is 类型检查运算符，判断实例是否属于某个类

var movieCount = 0
var songCount = 0
for item in library {
    if item is Movie {
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}
print("Media library contains \(movieCount) movies and \(songCount) songs")

//: Downcasting (强制转换)
//  * 类型强制转换运算符 : 将某常量或变量强制转换为子类型
//      - as? 前置转换为类型可选值
//      - as! 强制解包，解包失败，触发运行时错误
//  * 注：
//      - 转换不变改变和修改实例原来值

for item in library {
    if let movie = item as? Movie {
        print("Movie: \(movie.name), dir. \(movie.director)")
    } else if let song = item as? Song {
        print("Song: \(song.name), by \(song.artist)")
    }
}

//: Type Casting for Any and AnyObject (Any 和 AnyObject 的类型转换)
//  * Any : 表示任何类型的实例，包括函数类型、可选类型...
//  * AnyObject : 表示任何类类型的实例

var things = [Any]()

things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({ (name: String) -> String in "Hello, \(name)" })

for thing in things {
    switch thing { // switch 值绑定匹配
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
        print("a movie called \(movie.name), dir. \(movie.director)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Michael"))
    default:
        print("something else")
    }
}

let optionalNumber: Int? = 3
//things.append(optionalNumber) // 警告 ：将 Int? 转为 Any
things.append(optionalNumber as Any) // 使用 as 可以显示的转化为 Any

//: [Nested Types](@next)
