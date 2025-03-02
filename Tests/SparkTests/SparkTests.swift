import XCTest
@testable import Spark

final class SparkTests: XCTestCase {
    func testExample() throws {
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest

        // Defining Test Cases and Test Methods
        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods
    }
}


extension SparkTests: SparkCompatible { }

extension SK where SK: SparkTests {
    
    func urlRequest(url: String = "https://wwww.spark.test.com", method: Spark.Method = .get, headers: Spark.Headers? = nil) throws -> URLRequest {
        try URLRequest(url: url, method: method, headers: headers)
    }
}

extension Data: SparkCompatible { }

internal extension SK where SK == Data {
    
    var string: String {
        String(decoding: sk, as: UTF8.self)
    }
    
    func JSONObject() throws -> Any {
        try JSONSerialization.jsonObject(with: sk, options: .allowFragments)
    }
}
