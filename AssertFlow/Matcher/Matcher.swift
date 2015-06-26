
import Foundation

public class Matcher<T> : MatcherType {
    
    typealias Element = T
    
    let matchInfo: MatchInfo<Element>
    
    public var actual: Element { get { return matchInfo.actual! } }
    
    public init(actual: MatchInfo<Element>) {
        self.matchInfo = actual
    }
    
    public func isNil() -> Self {
        if let a = matchInfo.actual {
            fail("Expected nil, but was \(a)")
        }
        return self
    }
    
    public func equals<X: Equatable>(expected: X) -> Self {
        if unpack() {
            if let a = actual as? X {
                if expected != a {
                    fail("Expected \(a) to equal \(expected)")
                }
            } else {
                fail("Expected \(actual) to equal \(expected)")
            }
        }
        return self
    }
    
    public func unpack() -> Bool {
        if matchInfo.actual == nil {
            fail("MatchInfo for assertion is nil")
            return false
        } else {
            return true
        }
    }
    
    public func fail(message: String) {
        AssertHandler.instance.fail(self, message: message)
    }
}
