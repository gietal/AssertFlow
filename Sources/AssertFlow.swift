
import Foundation
import XCTest

public class AssertHandler {
    
    public static var instance: AssertHandler = XCTestAssertHandler()
    
    public init() {
    }

    public func fail<T>(matcher: Matcher<T>, message: String) {
        fail(message, file: matcher.matchInfo.file, line: matcher.matchInfo.line)
    }

    public func fail(message: String, file: String, line: UInt) {
    }

}

public class XCTestAssertHandler : AssertHandler {
    
    override public func fail(message: String, file: String, line: UInt) {
        XCTFail(message, file: file, line: line)
    }
}

public struct MatchInfo<T> {
    
    let actual: T?
    let file: String
    let line: UInt
    
    public init(actual: T?, file: String, line: UInt) {
        self.actual = actual
        self.file = file
        self.line = line
    }
}

public func assertThat<K: Hashable, V>(actual: Dictionary<K,V>?, file: String = __FILE__, line: UInt = __LINE__) -> DictionaryMatcher<K,V> {
    return DictionaryMatcher(actual: MatchInfo(actual: actual, file: file, line: line))
}

public func assertThat(actual: String?, file: String = __FILE__, line: UInt = __LINE__) -> StringMatcher {
    return StringMatcher(actual: MatchInfo(actual: actual, file: file, line: line))
}

public func assertThat<E>(actual: E?, file: String = __FILE__, line: UInt = __LINE__) -> Matcher<E> {
    return Matcher(actual: MatchInfo(actual: actual, file: file, line: line))
}