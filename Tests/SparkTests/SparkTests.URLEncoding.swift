//
//  SparkTests.URLEncodeing.swift
//  Spark
//
//  Created by Dream on 2025/3/4.
//

import XCTest

@testable import Spark

final class SparkTestsURLEncoding: SparkTests {

    private let encoding = URLEncoding.default
    private var urlRequest: URLRequest {  try! .init(url: "wwww.test.com", method: .get) }

    func test_URLEncodeing_ParametersNil() throws {

        // Given, When
        let urlRequest = try encoding.encode(urlRequest, with: nil)

        // Then
        XCTAssertNil(urlRequest.url?.query)
    }

    func test_URLEncodeing_EmptyDictionaryParameter() throws {
        // Given
        let parameters: [String: Any] = [:]

        // When
        let urlRequest = try encoding.encode(urlRequest, with: parameters)

        // Then
        XCTAssertNil(urlRequest.url?.query)
    }

    func test_URLEncodeing_KeyString_ValueSting_Parameter() throws {
        // Given
        let parameters = ["key": "value"]

        // When
        let urlRequest = try encoding.encode(urlRequest, with: parameters)

        // Then
        XCTAssertEqual(urlRequest.url?.query, "key=value")
    }

    func test_URLEncodeing_Two_KeyString_ValueSting_Parameters() throws {
        // Given
        let parameters = ["key1": "value1", "key2": "value2"]

        // When
        let urlRequest = try encoding.encode(urlRequest, with: parameters)

        // Then
        XCTAssertEqual(urlRequest.url?.query, "key1=value1&key2=value2")
    }

    func test_URLEncodeing_KeyString_ValueSting_ParameterAppendedToQuery() throws {
        // Given
        var mutableURLRequest = urlRequest
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
        let urlRequest = try encoding.encode(urlRequest, with: parameters)

        // Then
        XCTAssertEqual(urlRequest.url?.query, "NSNumber=88")
    }

    func test_URLEncodeing_KeyString_ValueNSNumberBool_Parameter() throws {
        // Given
        let parameters = ["key": NSNumber(value: false)]

        // When
        let urlRequest = try encoding.encode(urlRequest, with: parameters)

        // Then
        XCTAssertEqual(urlRequest.url?.query, "key=0")
    }

    func test_URLEncodeing_KeyString_ValueBool_Parameter() throws {
        // Given
        let parameters = ["key": true]

        // When
        let urlRequest = try encoding.encode(urlRequest, with: parameters)

        // Then
        XCTAssertEqual(urlRequest.url?.query, "key=1")
    }

    func test_URLEncodeing_KeyString_ValueInteger_Parameter() throws {
        // Given
        let parameters = ["key": 10]

        // When
        let urlRequest = try encoding.encode(urlRequest, with: parameters)

        // Then
        XCTAssertEqual(urlRequest.url?.query, "key=10")
    }

    func test_URLEncodeing_KeyString_ValueDouble_Parameter() throws {
        // Given
        let parameters = ["key": 1.111]

        // When
        let urlRequest = try encoding.encode(urlRequest, with: parameters)

        // Then
        XCTAssertEqual(urlRequest.url?.query, "key=1.111")
    }

    func test_URLEncodeing_KeyString_ValueArray_Parameter() throws {
        // Given
        let parameters = ["key": ["value", 1, true]]

        // When
        let urlRequest = try encoding.encode(urlRequest, with: parameters)

        // Then
        XCTAssertEqual(urlRequest.url?.query, "key%5B%5D=value&key%5B%5D=1&key%5B%5D=1")
    }

    func test_URLEncodeing_ArrayNestedDictionary_ValueParameter_indexInBrackets() throws {
        // Given
        let encoding = URLEncoding(arrayEncoding: .indexInBrackets)
        let parameters = ["key": ["value1", 1, true, ["key1": 2], ["key2": 3], ["key3": ["key4": 3]]]]

        // When
        let urlRequest = try encoding.encode(urlRequest, with: parameters)

        // Then
        XCTAssertEqual(urlRequest.url?.query, "key%5B0%5D=value1&key%5B1%5D=1&key%5B2%5D=1&key%5B3%5D%5Bkey1%5D=2&key%5B4%5D%5Bkey2%5D=3&key%5B5%5D%5Bkey3%5D%5Bkey4%5D=3")
    }

    func test_URLEncodeing_KeyStringArray_Value_Parameter_noBrackets() throws {
        // Given
        let encoding = URLEncoding(arrayEncoding: .noBrackets)
        let parameters = ["key": ["value", 1, true]]

        // When
        let urlRequest = try encoding.encode(urlRequest, with: parameters)

        // Then
        XCTAssertEqual(urlRequest.url?.query, "key=value&key=1&key=1")
    }

    func test_URLEncodeing_KeyStringArray_Value_Parameter_CustomClosure() throws {
        // Given
        let encoding = URLEncoding(
            arrayEncoding: .custom { key, index in
                "\(key)_\(index + 1)"
            })
        let parameters = ["key": ["value", 1, true]]

        // When
        let urlRequest = try encoding.encode(urlRequest, with: parameters)

        // Then
        XCTAssertEqual(urlRequest.url?.query, "key_1=value&key_2=1&key_3=1")
    }

    func test_URLEncodeing_KeyStringDictionary_Value_Parameter() throws {
        // Given
        let parameters = ["key1": ["key2": 1]]

        // When
        let urlRequest = try encoding.encode(urlRequest, with: parameters)

        // Then
        XCTAssertEqual(urlRequest.url?.query, "key1%5Bkey2%5D=1")
    }

    func test_URLEncodeing_KeyStringNestedDictionary_Value_Parameter() throws {
        // Given
        let parameters = ["key1": ["key2": ["key3": 1]]]

        // When
        let urlRequest = try encoding.encode(urlRequest, with: parameters)

        // Then
        XCTAssertEqual(urlRequest.url?.query, "key1%5Bkey2%5D%5Bkey3%5D=1")
    }

    func test_URLEncodeing_KeyStringNestedDictionaryArray_Value_Parameter() throws {
        // Given
        let parameters = ["key1": ["key2": ["key3": ["value", 1, true]]]]

        // When
        let urlRequest = try encoding.encode(urlRequest, with: parameters)

        // Then
        let expectedQuery = "key1%5Bkey2%5D%5Bkey3%5D%5B%5D=value&key1%5Bkey2%5D%5Bkey3%5D%5B%5D=1&key1%5Bkey2%5D%5Bkey3%5D%5B%5D=1"
        XCTAssertEqual(urlRequest.url?.query, expectedQuery)
    }

    func test_URLEncodeing_KeyStringNestedDictionaryArray_ValueParameterWithoutBrackets() throws {
        // Given
        let encoding = URLEncoding(arrayEncoding: .noBrackets)
        let parameters = ["key1": ["key2": ["key3": ["value", 1, true]]]]

        // When
        let urlRequest = try encoding.encode(urlRequest, with: parameters)

        // Then
        let expectedQuery = "key1%5Bkey2%5D%5Bkey3%5D=value&key1%5Bkey2%5D%5Bkey3%5D=1&key1%5Bkey2%5D%5Bkey3%5D=1"
        XCTAssertEqual(urlRequest.url?.query, expectedQuery)
    }

    func test_URLEncodeing_LiteralBoolEncodingWorksAndDoesNotAffectNumbers() throws {
        // Given
        let encoding = URLEncoding(boolEncoding: .literal)
        let parameters: [String: Any] = [  // Must still encode to numbers
            "key01": 1,
            "key02": 0,
            "key03": 1.0,
            "key04": 0.0,
            "key05": NSNumber(value: 1),
            "key06": NSNumber(value: 0),
            "key07": NSNumber(value: 1.0),
            "key08": NSNumber(value: 0.0),

            // Must encode to literals
            "key09": true,
            "key10": false,
            "key11": NSNumber(value: true),
            "key12": NSNumber(value: false),
        ]

        // When
        let urlRequest = try encoding.encode(urlRequest, with: parameters)

        // Then
        XCTAssertEqual(urlRequest.url?.query, "key01=1&key02=0&key03=1&key04=0&key05=1&key06=0&key07=1&key08=0&key09=true&key10=false&key11=true&key12=false")
    }

    func test_URLEncodeing_CharactersArePercentEscapedMinusQuestionMarkAndForwardSlash() throws {
        // Given
        let generalDelimiters = ":#[]@"
        let subDelimiters = "!$&'()*+,;="
        let parameters = ["key": "\(generalDelimiters)\(subDelimiters)"]

        // When
        let urlRequest = try encoding.encode(urlRequest, with: parameters)

        // Then
        let expectedQuery = "key=%3A%23%5B%5D%40%21%24%26%27%28%29%2A%2B%2C%3B%3D"
        XCTAssertEqual(urlRequest.url?.query, expectedQuery)
    }

    func test_URLEncodeing_UnreservedNumericCharactersAreNotPercentEscaped() throws {
        // Given
        let parameters = ["key_number": "0123456789"]

        // When
        let urlRequest = try encoding.encode(urlRequest, with: parameters)

        // Then
        XCTAssertEqual(urlRequest.url?.query, "key_number=0123456789")
    }

    func test_URLEncodeing_UnreservedLowercaseCharactersAreNotPercentEscaped() throws {
        // Given
        let parameters = ["key_lowercase": "abcdefghijklmnopqrstuvwxyz"]

        // When
        let urlRequest = try encoding.encode(urlRequest, with: parameters)

        // Then
        XCTAssertEqual(urlRequest.url?.query, "key_lowercase=abcdefghijklmnopqrstuvwxyz")
    }

    func test_URLEncodeing_UnreservedUppercaseCharactersAreNotPercentEscaped() throws {
        // Given
        let parameters = ["key_uppercase": "ABCDEFGHIJKLMNOPQRSTUVWXYZ"]

        // When
        let urlRequest = try encoding.encode(urlRequest, with: parameters)

        // Then
        XCTAssertEqual(urlRequest.url?.query, "key_uppercase=ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    }

    func test_URLEncodeing_EncodesGETParametersInURL() throws {
        // Given
        var mutableURLRequest = urlRequest
        mutableURLRequest.httpMethod = Method.get.rawValue
        let parameters = ["key1": 1, "key2": 2]

        // When
        let urlRequest = try encoding.encode(mutableURLRequest, with: parameters)

        // Then
        XCTAssertEqual(urlRequest.url?.query, "key1=1&key2=2")
        XCTAssertNil(urlRequest.value(forHTTPHeaderField: "Content-Type"), "Content-Type should be nil")
        XCTAssertNil(urlRequest.httpBody, "HTTPBody should be nil")
    }

    func test_URLEncodeing_EncodesPOSTParametersInHTTPBody() throws {
        // Given
        var mutableURLRequest = urlRequest
        mutableURLRequest.httpMethod = Method.post.rawValue
        let parameters = ["key1": 1, "key2": 2]

        // When
        let urlRequest = try encoding.encode(mutableURLRequest, with: parameters)

        // Then
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/x-www-form-urlencoded; charset=utf-8")
        XCTAssertNotNil(urlRequest.httpBody, "HTTPBody should not be nil")

        XCTAssertEqual(urlRequest.httpBody?.sk.string, "key1=1&key2=2")
    }

    func test_URLEncodeing_InURLParameterEncodingEncodesPOSTParametersInURL() throws {
        // Given
        var mutableURLRequest = urlRequest
        mutableURLRequest.httpMethod = Method.post.rawValue
        let parameters = ["key1": 1, "key2": 2]

        // When
        let urlRequest = try URLEncoding.queryString.encode(mutableURLRequest, with: parameters)

        // Then
        XCTAssertEqual(urlRequest.url?.query, "key1=1&key2=2")
        XCTAssertNil(urlRequest.value(forHTTPHeaderField: "Content-Type"))
        XCTAssertNil(urlRequest.httpBody, "HTTPBody should be nil")
    }

}
