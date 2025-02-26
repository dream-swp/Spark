//
//  SparkTests.Headers.swift
//  Spark
//
//  Created by Dream on 2025/2/27.
//


import XCTest
@testable import Spark

/**

 mutating func add(key: Spark.Header.Key, value: String)
 mutating func add(name: String, value: String)
 mutating func update(key: Spark.Header.Key, value: String)
 mutating func update(name: String, value: String)
 mutating func update(_ header: Spark.Header)
 mutating func remove(key: Spark.Header.Key)
 mutating func remove(name: String)
 func value(for key: Spark.Header.Key)
 func value(for name: String)
 mutating func sort()
 func sorted()
 
 */

extension SparkTests {
    
    
    
    func testHeaders() {
        
        var headers = Spark.Headers()
        
        // Add
        headers.add(name:  "Accept", value: "Accept")
        XCTAssertTrue((headers["Accept"] ?? "") == "Accept")
        
        headers.add(key: .AcceptCharset, value: ".AcceptCharset")
        XCTAssertTrue((headers[.AcceptCharset] ?? "") == ".AcceptCharset")
        
        headers["AcceptLanguage"] = "AcceptLanguage"
        XCTAssertTrue((headers["AcceptLanguage"] ?? "") == "AcceptLanguage")
        
        headers[.AcceptEncoding] = ".AcceptEncoding"
        XCTAssertTrue((headers[.AcceptEncoding] ?? "") == ".AcceptEncoding")
        
        headers[.AcceptEncoding] = nil
        XCTAssertTrue((headers[.AcceptEncoding] ?? "").isEmpty)
        
        
        // Updata
        headers.update(Spark.Header(name: "Accept", value: "update: header"))
        XCTAssertTrue((headers["Accept"] ?? "") == "update: header")
        
        headers.update(name: "Accept", value: "update: name")
        XCTAssertTrue((headers["Accept"] ?? "") == "update: name")
        
        headers.update(key: .AcceptCharset, value: "update: key")
        XCTAssertTrue((headers[.AcceptCharset] ?? "") == "update: key")
        
        headers["AcceptLanguage"] = "update name: subscript"
        XCTAssertTrue((headers["AcceptLanguage"] ?? "") == "update name: subscript")
        
        headers[.AcceptEncoding] = "update key: subscript"
        XCTAssertTrue((headers[.AcceptEncoding] ?? "") == "update key: subscript")
        
        // remove
        headers.remove(name: "Accept")
        XCTAssertTrue((headers["Accept"] ?? "").isEmpty)
        
        headers.remove(key: .AcceptCharset)
        XCTAssertTrue((headers[.AcceptCharset] ?? "").isEmpty)
        
        headers.remove(key: .AcceptCharset)
        XCTAssertTrue((headers[.AcceptCharset] ?? "").isEmpty)
    }
    
}
