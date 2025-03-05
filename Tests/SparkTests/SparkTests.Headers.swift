//
//  SparkTests.Headers.swift
//  Spark
//
//  Created by Dream on 2025/2/27.
//

import XCTest
@testable import Spark

final class SparkTestsHeaders: SparkTests {
    
    
    func test_Header_subscript_name() -> Void {
        
        // Given
        var headers = Spark.Headers()
        
        // When
        headers["Accept"] = nil
        
        // Then
        headers["Accept"].map { XCTAssertTrue($0.isEmpty) }
    }
    
    func test_Header_subscript_key() -> Void {
        
        // Given
        var headers = Spark.Headers()
        
        // When
        headers[.Accept] = nil
        
        // Then
        headers[.Accept].map { XCTAssertTrue($0.isEmpty) }
    }
    
    func test_Headers_add_name() -> Void {
        
        // Given
        var headers = Spark.Headers()
        
        // When
        headers.add(name: "Accept", value: "Accept")
        
        // Then
        XCTAssertEqual(headers["Accept"], "Accept")
      
    }
    
    func test_Headers_add_key() -> Void {
        
        // Given
        var headers = Spark.Headers()
        
        // When
        headers.add(key: .Accept, value: "Accept")
        
        // Then
        XCTAssertEqual(headers["Accept"], "Accept")
    }
    
    func test_Headers_update_name() -> Void {
        
        // Given
        var headers = Spark.Headers()
        
        // When
        headers.update(name: "Accept", value: "Accept")
        
        // Then
        XCTAssertEqual(headers["Accept"], "Accept")
      
    }
    
    func test_Headers_update_key() -> Void {
        
        // Given
        var headers = Spark.Headers([.Accept : "Accept"])
        
        // When
        headers.update(key: .Accept, value: "update: accept")
        
        // Then
        XCTAssertEqual(headers[.Accept], "update: accept")
    }
    
    func test_Headers_remove_name() -> Void {
        // Given
        var headers = Spark.Headers(["Accept" : "Accept"])
        
        // When
        headers.remove(name: "Accept")
        
        // Then
        headers["Accept"].map { XCTAssertTrue($0.isEmpty) }
    }
    
    func test_Headers_remove_key() -> Void {
        
        // Given
        var headers = Spark.Headers([.Accept : "Accept"])
        
        // When
        headers.remove(key: .Accept)
        
        // Then
        headers[.Accept].map { XCTAssertTrue($0.isEmpty) }
        
    }
    
    func test_Headers_sort() -> Void {
        
        // Given
        let headers = Spark.Headers([.Basic : "Basic", .Accept : "Accept",  .UserAgent : "UserAgent", .ContentType : "ContentType"])
        
        // When
        let sorted =  headers.sorted()
        
        // Then
        sorted.first.map {  XCTAssertEqual($0.name, "Accept") }
    }

    func test_Headers_dictionary() -> Void {
        
        // Given
        let dictionary = ["Accept" : "Accept", "Basic" : "Basic", "ContentType" : "ContentType"]
        
        // When
        let headers = Spark.Headers(dictionary)
        
        // Then
        XCTAssertEqual(dictionary, headers.dictionary)
    }
    
    func test_Headers_firstIndex() -> Void {
        
        // Given
        let dictionary = ["ContentType" : "ContentType", "Basic" : "Basic", "Accept" : "Accept", "User-Agent" : "User-Agent"]
        
        // When
        let headers = Spark.Headers(dictionary).sorted()
        
        // Then
        XCTAssertEqual(headers[headers.startIndex].name, "Accept")
    }
    
    func test_Headers_lastIndex() -> Void {
        
        // Given
        let dictionary = ["Basic" : "Basic", "Accept" : "Accept", "User-Agent" : "User-Agent", "ContentType" : "ContentType"]
        
        // When
        let headers = Spark.Headers(dictionary).sorted()
        
        // Then
        let lastIndex = headers.index(before: headers.endIndex)
        XCTAssertEqual(headers[lastIndex].name, "User-Agent")
    }
    
    
    
//
//    func testHeaders_dictionary() -> Void {
//        let dictionary = ["Accept" : "Accept", "Basic" : "Basic", "ContentType" : "ContentType"]
//        let headers = Spark.Headers(dictionary)
//        let converts = headers.dictionary
//        XCTAssertTrue(dictionary == converts)
//        
//        let sorted =  headers.sorted()
//        
//        // first index
//        let firstIndex = sorted.startIndex
//        XCTAssertEqual(sorted[firstIndex].name, "Accept")
//        
//        let index2 = sorted.index(after: sorted.startIndex)
//        XCTAssertEqual(sorted[index2].name, "Basic")
//        
//        let lastIndex = sorted.index(before: sorted.endIndex)
//        XCTAssertEqual(sorted[lastIndex].name, "ContentType")
//        
//        let headers1 = Spark.Headers(arrayLiteral: Spark.Header(key: .Accept, value: ""), Spark.Header(name: "Basic", value: "Basic"))
//        XCTAssertTrue(!headers1.isEmpty)
//        
//        let headers2 = Spark.Headers(dictionaryLiteral: ("Basic", "Basic"), (Spark.Header.Key.Accept.rawValue, "Accept"))
//        XCTAssertTrue(!headers2.isEmpty)
//    }
//    
//    func testHeaders_makeIterator() -> Void {
//        
//        let dictionary = ["Accept" : "Accept", "Basic" : "Basic", "ContentType" : "ContentType"]
//        let headers = Spark.Headers(dictionary)
//        var iterator = headers.makeIterator()
//        
//        var iteratorData = [String : String] ()
//        while let header = iterator.next() {
//            iteratorData[header.name] = header.value
//        }
//        XCTAssertTrue(headers.dictionary == iteratorData && iteratorData == dictionary)
//    }
    
}


