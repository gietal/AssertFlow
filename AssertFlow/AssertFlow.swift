
import Foundation
import XCTest

public class AssertHandler {
    
    public static var instance: AssertHandler = XCTestAssertHandler()
    
    public init() {
    }
    
    public func fail<T>(matcher: AbstractMatcher<T>, message: String) {
    }
}

public class XCTestAssertHandler : AssertHandler {
    
    override public func fail<T>(matcher: AbstractMatcher<T>, message: String) {
        XCTFail(message, file: matcher.matchInfo.file, line: matcher.matchInfo.line)
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

public func assertThat<T: IntegerType>(actual: T?, file: String = __FILE__, line: UInt = __LINE__) -> IntegerTypeMatcher<T> {
    return IntegerTypeMatcher(actual: MatchInfo(actual: actual, file: file, line: line))
}

public func assertThat<K: Hashable, V>(actual: Dictionary<K,V>?, file: String = __FILE__, line: UInt = __LINE__) -> DictionaryMatcher<K,V> {
    return DictionaryMatcher(actual: MatchInfo(actual: actual, file: file, line: line))
}

public func assertThat(actual: String?, file: String = __FILE__, line: UInt = __LINE__) -> StringMatcher<String> {
    return StringMatcher(actual: MatchInfo(actual: actual, file: file, line: line))
}

public func assertThat<T: SequenceType>(actual: T?, file: String = __FILE__, line: UInt = __LINE__) -> SequenceTypeMatcher<T> {
    return SequenceTypeMatcher(actual: MatchInfo(actual: actual, file: file, line: line))
}
