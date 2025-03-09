//
//  SparkTests.JSONEncoding.swift
//  Spark
//
//  Created by Dream on 2025/2/28.
//

import XCTest
@testable import Spark

final class SparkTestsJSONEncoding: SparkTests {
    
    private let encoding = Spark.JSONEncoding.default
    private var urlRequest: URLRequest { sk.defaultRequest }
    
    func test_JSONEncoding_EncodeNilParameters() throws {
        
        // Given, When
        let request = try encoding.encode(urlRequest, with: nil)

        // Then
        XCTAssertNil(request.url?.query, "query should be nil")
        XCTAssertNil(request.value(forHTTPHeaderField: "Content-Type"))
        XCTAssertNil(request.httpBody, "HTTPBody should be nil")
        
    }
    
    func test_JSONEncoding_EncodeComplexParameters() throws {
        
        // Given
        let parameters: [String: Any] = ["accept": "string",
                                         "array" : ["a", 1, true],
                                         "dictionary" : ["a": 1, "b": [2, 2], "c": [3, 3, 3]]]

        // When
        let request = try encoding.encode(urlRequest, with: parameters)

        // Then
        XCTAssertNil(request.url?.query)
        XCTAssertNotNil(request.value(forHTTPHeaderField: "Content-Type"))
        XCTAssertEqual(request.value(forHTTPHeaderField: "Content-Type"), "application/json")
        XCTAssertNotNil(request.httpBody)

        XCTAssertEqual(try request.httpBody?.sk.JSONObject() as? NSObject, parameters as NSObject, "Decoded request body and parameters should be equal.")
    }
    
    func test_JSONEncoding_EncodeArray() throws {
        // Given
        let array = ["value1", "value2", "value3"]

        // When
        let request = try encoding.encode(urlRequest, jsonObject: array)

        // Then
        XCTAssertNil(request.url?.query)
        XCTAssertNotNil(request.value(forHTTPHeaderField: "Content-Type"))
        XCTAssertEqual(request.value(forHTTPHeaderField: "Content-Type"), "application/json")
        XCTAssertNotNil(request.httpBody)
        XCTAssertEqual(try request.httpBody?.sk.JSONObject() as? NSObject, array as NSObject, "Decoded request body and parameters should be equal.")
    }
    
    func test_JSONEncoding_ParametersRetainsCustomContentType() throws {
       
        // Given
        var config = SKRequest()
        config.scheme = .https
        config.host = .custom("wwww.spark.test.com")
        config.headers = [.contentType("application/custom-json-type+json")]
        config.method = .get
        let request = try config.skURLRequest()
        
        let parameters = ["key": "value"]

        // When
        let urlRequest = try encoding.encode(request, with: parameters)

        // Then
        XCTAssertNil(urlRequest.url?.query)
        XCTAssertEqual(urlRequest.headers["Content-Type"], "application/custom-json-type+json")
    }
    
    func test_JSONEncoding_isValidJSONObjectNoThrow() -> Void {
        
        // Given, When
        let parameters = ["Accept": "Accept", "AcceptCharset": "AcceptCharset", "UserAgent": "UserAgent"]
        
        // Then
        XCTAssertNoThrow(try encoding.isValidJSONObject(parameters))
    }
    
    func test_JSONEncoding_isValidJSONObjectThrowsError() -> Void {
        
        // Given, When
        let parameters = [1: "a"]
        
        // Then
        XCTAssertThrowsError(try encoding.isValidJSONObject(parameters))
    }

    
    func test_JSONEncoding_jsonDataNoThrow() -> Void {
        
        // Given, When
        let parameters = ["Accept": "Accept", "AcceptCharset": "AcceptCharset", "UserAgent": "UserAgent"]
        
        // Then
        XCTAssertNoThrow(try encoding.jsonData(parameters))
    }
    
    func test_JSONEncoding_jsonDataEqual() -> Void {
        
        // Given
        let parameters = ["Accept": "Accept", "AcceptCharset": "AcceptCharset", "UserAgent": "UserAgent"]
        
        // When
        let expectedData = try? JSONSerialization.data(withJSONObject: parameters, options: encoding.options)
        let resultData   = try? encoding.jsonData(parameters, options: encoding.options)
        
        // Then
        XCTAssertEqual(resultData, expectedData)
    }
    
    func test_JSONEncoding_requestConfig_DictionaryParameters() throws -> Void {
        
        
        // Given
        let parameters = ["Accept": "Accept", "AcceptCharset": "AcceptCharset", "UserAgent": "UserAgent"]
        let jsonData = try encoding.jsonData(parameters)
        
        // When
        let request = encoding.requestConfig(urlRequest, jsonData: jsonData)
        
        // Then
        let expected = ["Content-Type": "application/json"]
        XCTAssertEqual(request.headers.dictionary, expected)
        
    }
    
    func test_JSONEncoding_requestConfig_HeadersParameters() throws -> Void {
        
        // Given
        let parameters = Spark.Headers(headers: [.accept("accept"), .contentType("application/json"), .authorization(bearerToken: "bearerToken")])
        let jsonData = try encoding.jsonData(parameters.dictionary)
        var mutableURLRequest = urlRequest
        mutableURLRequest.headers = parameters
        
        // When
        let result = encoding.requestConfig(mutableURLRequest, jsonData: jsonData)
        
        // Then
        XCTAssertEqual(result.headers.dictionary, parameters.dictionary)
    }

    func test_JSONEncoding_encode() throws -> Void {
        
        // Given
        let encoding = Spark.JSONEncoding.prettyPrinted
        let parameters: Spark.Parameters = ["accept"     : "string",
                                            "array"      : ["a", "b", "c"],
                                            "dictionary" : ["a": "1",  "b": "2", "c": "3"]]
        
        // When
        let result  = try encoding.encode(urlRequest, with: parameters)
    
        // Then
        XCTAssertNil(result.url?.query)
        XCTAssertNotNil(result.value(forHTTPHeaderField: "Content-Type"))
        XCTAssertEqual(result.value(forHTTPHeaderField: "Content-Type"), "application/json")
        XCTAssertNotNil(result.httpBody)

        XCTAssertEqual(try result.httpBody?.sk.JSONObject() as? NSObject, parameters as NSObject, "Decoded request body and parameters should be equal.")
    
    }
    
}
