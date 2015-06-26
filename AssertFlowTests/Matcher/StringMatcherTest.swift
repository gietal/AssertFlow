
import Foundation
import XCTest
import AssertFlow


class StringMatcherTest : XCTestCase {
    
    var handler: CaptureAssertHandler = CaptureAssertHandler()
    
    override func setUp() {
        handler = CaptureAssertHandler()
        AssertHandler.instance = handler
    }
    
    func testContainsSubstring() {
        let s = "This is a longer string for testing"
        
        assertThat(s).contains("a longer")
        XCTAssertFalse(handler.called)
        assertThat(s).contains("unknown")
        XCTAssertTrue(handler.called)
    }
    
    func testContainsSubstringWithOptional() {
        var s: String? = "Hello"
        
        assertThat(s).contains("ll")
        XCTAssertFalse(handler.called)
        
        s = nil
        
        assertThat(s).contains("ll")
        XCTAssertTrue(handler.called)
    }
}
