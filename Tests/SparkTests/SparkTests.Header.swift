//
//  SparkTests.Header.swift
//  Spark
//
//  Created by Dream on 2025/2/26.
//

import XCTest
@testable import Spark

final class SparkTestsHeader: SparkTests {
    
    func test_Header_Accept() -> Void {
        
        // Given, When
        let header = Spark.Header.accept("Accept")
        
        // Then
        XCTAssertEqual(header.name, "Accept")
    }
    
    func test_Header_AcceptCharset() -> Void {
        
        // Given, When
        let header = Spark.Header.acceptCharset("Accept-Charset")
        
        // Then
        XCTAssertEqual(header.name, "Accept-Charset")
    }
    
    func test_Header_AcceptLanguage() -> Void {
        
        // Given, When
        let header = Spark.Header.acceptLanguage("Accept-Language")
        
        // Then
        XCTAssertEqual(header.name, "Accept-Language")
    }
    
    func test_Header_AcceptEncoding() -> Void {
        
        // Given, When
        let header = Spark.Header.acceptEncoding("Accept-Encoding")
        
        // Then
        XCTAssertEqual(header.name, "Accept-Encoding")
    }
    
    func test_Header_Authorization() -> Void {
        
        // Given, When
        let header = Spark.Header.authorization("Authorization")
        
        // Then
        XCTAssertEqual(header.name, "Authorization")
    }
    
    func test_Header_AuthorizationBasic() -> Void {
        
        // Given, When
        let header = Spark.Header.authorization(username: "username", password: "password")
        
        // Then
        XCTAssertEqual(header.name, "Authorization")
        XCTAssertTrue(header.value.contains("Basic"))
    }
    
    func test_Header_AuthorizationBearer() -> Void {
        
        // Given, When
        let header = Spark.Header.authorization(bearerToken: "username | password")
        
        // Then
        XCTAssertEqual(header.name, "Authorization")
        XCTAssertTrue(header.value.contains("Bearer"))
    }
    
    func test_Header_ContentDisposition() -> Void {
        
        // Given, When
        let header = Spark.Header.contentDisposition("Content-Disposition")
        
        // Then
        XCTAssertEqual(header.name, "Content-Disposition")
    }
    
    func test_Header_ContentEncoding() -> Void {
        
        // Given, When
        let header = Spark.Header.contentEncoding("Content-Encoding")
        
        // Then
        XCTAssertEqual(header.name, "Content-Encoding")
    }
    
    func test_Header_ContentType() -> Void {
        
        // Given, When
        let header = Spark.Header.contentType("Content-Type")
        
        // Then
        XCTAssertEqual(header.name, "Content-Type")
    }
    
    func test_Header_UserAgent() -> Void {
        
        // Given, When
        let header = Spark.Header.userAgent("User-Agent")
        
        // Then
        XCTAssertEqual(header.name, "User-Agent")
        XCTAssertEqual(header.description, "User-Agent : User-Agent")
    }

}
