//: [Memory Safety](@previous)

//: ## Access Control : 访问控制

//: Modules and Source Files ()

//: Access Levels

// Guiding Principle of Access Levels

// Default Access Levels

// Access Levels for Single-Target Apps

// Access Levels for Frameworks

// Access Levels for Unit Test Targets


//: Access Control Syntax ()

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

//: Custom Types ()

public class SomePublicClass1 {                  // explicitly public class
    public var somePublicProperty = 0            // explicitly public class member
    var someInternalProperty = 0                 // implicitly internal class member
    fileprivate func someFilePrivateMethod() {}  // explicitly file-private class member
    private func somePrivateMethod() {}          // explicitly private class member
}
class SomeInternalClass2 {                       // implicitly internal class
    var someInternalProperty = 0                 // implicitly internal class member
    fileprivate func someFilePrivateMethod() {}  // explicitly file-private class member
    private func somePrivateMethod() {}          // explicitly private class member
}
fileprivate class SomeFilePrivateClass1 {        // explicitly file-private class
    func someFilePrivateMethod() {}              // implicitly file-private class member
    private func somePrivateMethod() {}          // explicitly private class member
}
private class SomePrivateClass1 {                // explicitly private class
    func somePrivateMethod() {}                  // implicitly private class member
}

// Tuple Types

// Function Types
//func someFunction1() -> (SomeInternalClass, SomePrivateClass) {}
//private func someFunction2() -> (SomeInternalClass, SomePrivateClass) {}

// Enumeration Types
public enum CompassPoint {
    case north
    case south
    case east
    case west
}

// Raw Values and Associated Values

// Nested Types

//: Subclassing ()

public class A {
    fileprivate func someMethod() {}
}

internal class B: A {
    override internal func someMethod() {
        super.someMethod()
    }
}

//: Constants, Variables, Properties, and Subscripts ()

private var privateInstance = SomePrivateClass()

// Getters and Setters

struct TrackedString {
    private(set) var numberOfEdits = 0
    var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
}

var stringToEdit = TrackedString()
stringToEdit.value = "This string will be tracked."
stringToEdit.value += " This edit will increment numberOfEdits."
stringToEdit.value += " So will this one."
print("The number of edits is \(stringToEdit.numberOfEdits)")

public struct TrackedString1 {
    public private(set) var numberOfEdits = 0
    public var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
    public init() {}
}

//: Initializers

// Default Initializers

// Default Memberwise Initializers for Structure Types

//: Protocols

// Protocol Inheritance

// Protocol Conformance

//: Extensions

// Private Members in Extensions

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

//: Generics

//: Type Aliases


//: [Advanced Operators](@next)
