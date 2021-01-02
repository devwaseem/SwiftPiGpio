import XCTest
@testable import SwiftPiGpio

final class SwiftPiGpioTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SwiftPiGpio.shared!.version(), UInt32(78))
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
