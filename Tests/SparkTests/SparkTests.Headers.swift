//
//  SparkTests.Headers.swift
//  Spark
//
//  Created by Dream on 2025/2/27.
//

import XCTest
@testable import Spark

extension SparkTests {
    
    func testHeaders_add() -> Void {
        
        var headers = Spark.Headers()
        
        // Add
        headers["Accept"] = nil
        XCTAssertTrue((headers["Accept"] ?? "").isEmpty)
        
        headers.add(name:  "Accept", value: "Accept")
        XCTAssertTrue((headers["Accept"] ?? "") == "Accept")
        
        headers.add(key: .AcceptCharset, value: ".AcceptCharset")
        XCTAssertTrue((headers[.AcceptCharset] ?? "") == ".AcceptCharset")
        
        headers["AcceptLanguage"] = "AcceptLanguage"
        XCTAssertTrue((headers["AcceptLanguage"] ?? "") == "AcceptLanguage")
        
        headers[.AcceptEncoding] = nil
        XCTAssertTrue((headers[.AcceptEncoding] ?? "").isEmpty)
        
        headers[.AcceptEncoding] = ".AcceptEncoding"
        XCTAssertTrue((headers[.AcceptEncoding] ?? "") == ".AcceptEncoding")
      
    }
    
    func testHeaders_update() -> Void {
        var headers = Spark.Headers(headers: [Spark.Header(key: .Accept, value: "update: header")])
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
        
    }
    
    func testHeaders_remove() -> Void {
        
        var headers = Spark.Headers(["Accept" : "Accept"])
        // remove
        headers.remove(name: "Accept")
        XCTAssertTrue((headers["Accept"] ?? "").isEmpty)
        
        headers.remove(key: .AcceptCharset)
        XCTAssertTrue((headers[.AcceptCharset] ?? "").isEmpty)
        
        headers.remove(key: .AcceptCharset)
        XCTAssertTrue((headers[.AcceptCharset] ?? "").isEmpty)
    }
    
    func testHeaders_sort() -> Void {
        let headers = Spark.Headers([.Basic : "Basic", .Accept : "Accept",  .UserAgent : "UserAgent", .ContentType : "ContentType"])
        let sorted =  headers.sorted()
        sorted.first.map { XCTAssertEqual($0.name, "Accept")  }
    }
    
    func testHeaders_dictionary() -> Void {
        let dictionary = ["Accept" : "Accept", "Basic" : "Basic", "ContentType" : "ContentType"]
        let headers = Spark.Headers(dictionary)
        let converts = headers.dictionary
        XCTAssertTrue(dictionary == converts)
        
        let sorted =  headers.sorted()
        
        // first index
        let firstIndex = sorted.startIndex
        XCTAssertEqual(sorted[firstIndex].name, "Accept")
        
        let index2 = sorted.index(after: sorted.startIndex)
        XCTAssertEqual(sorted[index2].name, "Basic")
        
        let lastIndex = sorted.index(before: sorted.endIndex)
        XCTAssertEqual(sorted[lastIndex].name, "ContentType")
        
        let headers1 = Spark.Headers(arrayLiteral: Spark.Header(key: .Accept, value: ""), Spark.Header(name: "Basic", value: "Basic"))
        XCTAssertTrue(!headers1.isEmpty)
        
        let headers2 = Spark.Headers(dictionaryLiteral: ("Basic", "Basic"), (Spark.Header.Key.Accept.rawValue, "Accept"))
        XCTAssertTrue(!headers2.isEmpty)
    }
    
    func testHeaders_makeIterator() -> Void {
        
        let dictionary = ["Accept" : "Accept", "Basic" : "Basic", "ContentType" : "ContentType"]
        let headers = Spark.Headers(dictionary)
        var iterator = headers.makeIterator()
        
        var iteratorData = [String : String] ()
        while let header = iterator.next() {
            iteratorData[header.name] = header.value
        }
        XCTAssertTrue(headers.dictionary == iteratorData && iteratorData == dictionary)
    }
    
}


