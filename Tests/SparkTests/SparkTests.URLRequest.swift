//
//  SparkTests.URLRequest.swift
//  Spark
//
//  Created by Dream on 2025/2/28.
//

import XCTest
@testable import Spark

final class SparkTestsURLRequest: SparkTests {
    
    
    private let encoding = Spark.URLEncodeing.default
    
    func test_URLEncodeing_ParametersNil() throws {
        
        // Given, When
        let urlRequest = try encoding.encode(sk.urlRequest(), with: nil)

        // Then
        XCTAssertNil(urlRequest.url?.query)
    }
    
    func test_URLEncodeing_EmptyDictionaryParameter() throws {
        // Given
        let parameters: [String: Any] = [:]

        // When
        let urlRequest = try encoding.encode(sk.urlRequest(), with: parameters)

        // Then
        XCTAssertNil(urlRequest.url?.query)
    }
    
    func test_URLEncodeing_KeyString_ValueSting_Parameter() throws {
        // Given
        let parameters = ["key": "value"]

        // When
        let urlRequest = try encoding.encode(sk.urlRequest(), with: parameters)

        // Then
        XCTAssertEqual(urlRequest.url?.query, "key=value")
    }
    
    func test_URLEncodeing_Two_KeyString_ValueSting_Parameters() throws {
        // Given
        let parameters = ["key1": "value1", "key2": "value2"]

        // When
        let urlRequest = try encoding.encode(sk.urlRequest(), with: parameters)

        // Then
        XCTAssertEqual(urlRequest.url?.query, "key1=value1&key2=value2")
    }
    
    func test_URLEncodeing_KeyString_ValueSting_ParameterAppendedToQuery() throws {
        // Given
        var mutableURLRequest = try sk.urlRequest()
        var urlComponents = URLComponents(url: mutableURLRequest.url!, resolvingAgainstBaseURL: false)!
        urlComponents.query = "key1=value1"
        mutableURLRequest.url = urlComponents.url

        let parameters = ["key2": "value2"]

        // When
        let urlRequest = try encoding.encode(mutableURLRequest, with: parameters)

        // Then
        XCTAssertEqual(urlRequest.url?.query, "key1=value1&key2=value2")
    }
    
    func test_URLEncodeing_KeyString_ValueNSNumberInteger_Parameter() throws {
        // Given
        let parameters = ["NSNumber": NSNumber(value: 88)]

        // When
        let urlRequest = try encoding.encode(sk.urlRequest(), with: parameters)

        // Then
        XCTAssertEqual(urlRequest.url?.query, "NSNumber=88")
    }
    
    func test_URLEncodeing_KeyString_ValueNSNumberBool_Parameter() throws {
        // Given
        let parameters = ["key": NSNumber(value: false)]

        // When
        let urlRequest = try encoding.encode(sk.urlRequest(), with: parameters)

        // Then
        XCTAssertEqual(urlRequest.url?.query, "key=0")
    }
    
    func test_URLEncodeing_KeyString_ValueBool_Parameter() throws {
        // Given
        let parameters = ["key": true]

        // When
        let urlRequest = try encoding.encode(sk.urlRequest(), with: parameters)

        // Then
        XCTAssertEqual(urlRequest.url?.query, "key=1")
    }
    
    func test_URLEncodeing_KeyString_ValueInteger_Parameter() throws {
        // Given
        let parameters = ["key": 10]

        // When
        let urlRequest = try encoding.encode(sk.urlRequest(), with: parameters)

        // Then
        XCTAssertEqual(urlRequest.url?.query, "key=10")
    }
    
    func test_URLEncodeing_KeyString_ValueDouble_Parameter() throws {
        // Given
        let parameters = ["key": 1.111]

        // When
        let urlRequest = try encoding.encode(sk.urlRequest(), with: parameters)

        // Then
        XCTAssertEqual(urlRequest.url?.query, "key=1.111")
    }
    
    func test_URLEncodeing_KeyString_ValueArray_Parameter() throws {
        // Given
        let parameters = ["foo": ["a", 1, true]]

        // When
        let urlRequest = try encoding.encode(sk.urlRequest(), with: parameters)

        // Then
        XCTAssertEqual(urlRequest.url?.query, "foo%5B%5D=a&foo%5B%5D=1&foo%5B%5D=1")
    }
}
