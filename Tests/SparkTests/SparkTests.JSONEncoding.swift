//
//  SparkTests.JSONEncoding.swift
//  Spark
//
//  Created by Dream on 2025/2/28.
//

import XCTest
@testable import Spark

extension SparkTests {
    
    func testJSONEncoding_isValidJSONObject() -> Void {
        
       let encoding = Spark.JSONEncoding.default
        
        let jsonObject1 = ["Accept": "Accept", "AcceptCharset": "AcceptCharset", "UserAgent": "UserAgent"]
        XCTAssertNoThrow(try encoding.isValidJSONObject(jsonObject1))
        
        let jsonObject2 = [1: "a"]
        XCTAssertThrowsError(try encoding.isValidJSONObject(jsonObject2)) { error in
            let error1 = error as? Spark.Error
            let error2: Spark.Error? = Spark.Error.parameterEncodingFailed(reason: .jsonEncodingFailed(error: Spark.Error.JSONEncodingError.invalidJSONObject))
            XCTAssertEqual(error1?.localizedDescription, error2?.localizedDescription)
        }
    }
    
    
    func testJSONEncoding_jsonData() -> Void {
       let encoding = Spark.JSONEncoding.prettyPrinted
        
        let jsonObject1 = ["Accept": "Accept", "AcceptCharset": "AcceptCharset", "UserAgent": "UserAgent"]
        XCTAssertNoThrow(try encoding.jsonData(jsonObject1))

        let expectedData = try? JSONSerialization.data(withJSONObject: jsonObject1, options: encoding.options)
        let resultData   = try? encoding.jsonData(jsonObject1, options: encoding.options)
        XCTAssertEqual(resultData, expectedData)
    }
    
    func testJSONEncoding_requestConfig() throws -> Void {
       let encoding = Spark.JSONEncoding.default
        let jsonObject = ["Accept": "Accept", "AcceptCharset": "AcceptCharset", "UserAgent": "UserAgent"]
        
        if var request = try? URLRequest(url: "https://wwww.aaaaccc.com", method: .get, headers: nil), let jsonData = try? encoding.jsonData(jsonObject) {
            request = encoding.requestConfig(request, jsonData: jsonData)
            let expected = ["Content-Type": "application/json"]
            XCTAssertEqual(request.headers.dictionary, expected)
        }
        
        let headers = Spark.Headers(headers: [.accept("accept"), .contentType("application/json"), .authorization(bearerToken: "bearerToken")])
        
        let request = try URLRequest(url: "https://wwww.aaaaccc.com", method: .get, headers: headers)
        let jsonData = try encoding.jsonData(jsonObject)
        
        let result = encoding.requestConfig(request, jsonData: jsonData)
        XCTAssertEqual(result.headers.dictionary, headers.dictionary)
    
       
    }
    
    func testJSONEncoding_encodeJsonObject() throws -> Void {
        let encoding = Spark.JSONEncoding.prettyPrinted
        
        // Given
        let parameters: [String: Any] = ["accept"       : "string",
                                         "array"        : ["a", 1, true],
                                         "dictionary"   : ["a": 1, "b": [2, 2], "c": [3, 3, 3]]]

        
        let request = try self.sk.urlRequest()
        
        // When
        let result  = try encoding.encode(request, jsonObject: parameters)
    
        // Then
        XCTAssertNil(result.url?.query)
        XCTAssertNotNil(result.value(forHTTPHeaderField: "Content-Type"))
        XCTAssertEqual(result.value(forHTTPHeaderField: "Content-Type"), "application/json")
        XCTAssertNotNil(result.httpBody)
        XCTAssertEqual(try result.httpBody?.sk.JSONObject() as? NSObject, parameters as NSObject, "Decoded request body and parameters should be equal.")
        
        
    
    }
    
    func testJSONEncoding_encode() throws -> Void {
        
        let encoding = Spark.JSONEncoding.prettyPrinted
        
        let parameters: Spark.Parameters = ["accept"     : "string",
                                            "array"      : ["a", "b", "c"],
                                            "dictionary" : ["a": "1",  "b": "2", "c": "3"]]
        let request = try self.sk.urlRequest()
        
        // When
        let result  = try encoding.encode(request, with: parameters)
    
        // Then
        XCTAssertNil(result.url?.query)
        XCTAssertNotNil(result.value(forHTTPHeaderField: "Content-Type"))
        XCTAssertEqual(result.value(forHTTPHeaderField: "Content-Type"), "application/json")
        XCTAssertNotNil(result.httpBody)

        XCTAssertEqual(try result.httpBody?.sk.JSONObject() as? NSObject, parameters as NSObject, "Decoded request body and parameters should be equal.")
    
    }
    
}
