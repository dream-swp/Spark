//
//  SparkTests.swift
//  Spark
//
//  Created by Dream on 2025/2/22.
//

import XCTest
@testable import Spark

class SparkTests: XCTestCase { }

extension SparkTests: SparkCompatible { }

extension SK where SK: SparkTests {
    func urlRequest(url: String = "https://wwww.spark.test.com", method: Spark.Method = .get, headers: Spark.Headers? = nil) throws -> URLRequest {
        try URLRequest(url: url, method: method, headers: headers)
    }
}

extension Data: SparkCompatible { }
extension SK where SK == Data {
    
    var string: String {
        String(decoding: sk, as: UTF8.self)
    }
    
    func JSONObject() throws -> Any {
        try JSONSerialization.jsonObject(with: sk, options: .allowFragments)
    }
}
