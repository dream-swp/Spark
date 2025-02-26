//
//  SparkTests.Header.swift
//  Spark
//
//  Created by Dream on 2025/2/26.
//

import XCTest
@testable import Spark

extension SparkTests {
    
    func testHeader_Accept() -> Void {
        let header = Spark.Header.accept("Accept")
        XCTAssertEqual(header.name, "Accept")
    }
    
    func testHeader_AcceptCharset() -> Void {
        let header = Spark.Header.acceptCharset("Accept-Charset")
        XCTAssertEqual(header.name, "Accept-Charset")
    }
    
    func testHeader_AcceptLanguage() -> Void {
        let header = Spark.Header.acceptLanguage("Accept-Language")
        XCTAssertEqual(header.name, "Accept-Language")
    }
    
    func testHeader_AcceptEncoding() -> Void {
        let header = Spark.Header.acceptEncoding("Accept-Encoding")
        XCTAssertEqual(header.name, "Accept-Encoding")
    }
    
    func testHeader_Authorization() -> Void {
        let header = Spark.Header.authorization("Authorization")
        XCTAssertEqual(header.name, "Authorization")
    }
    
    func testHeader_AuthorizationBasic() -> Void {
        let header = Spark.Header.authorization(username: "username", password: "password")
        XCTAssertEqual(header.name, "Authorization")
        XCTAssertTrue(header.value.contains("Basic"))
    }
    
    func testHeader_AuthorizationBearer() -> Void {
        let header = Spark.Header.authorization(bearerToken: "username | password")
        XCTAssertEqual(header.name, "Authorization")
        XCTAssertTrue(header.value.contains("Bearer"))
    }
    
    func testHeader_ContentDisposition() -> Void {
        let header = Spark.Header.contentDisposition("Content-Disposition")
        XCTAssertEqual(header.name, "Content-Disposition")
    }
    
    func testHeader_ContentEncoding() -> Void {
        let header = Spark.Header.contentEncoding("Content-Encoding")
        XCTAssertEqual(header.name, "Content-Encoding")
    }
    
    func testHeader_ContentType() -> Void {
        let header = Spark.Header.contentType("Content-Type")
        XCTAssertEqual(header.name, "Content-Type")
    }
    
    func testHeader_UserAgent() -> Void {
        let header = Spark.Header.userAgent("User-Agent")
        XCTAssertEqual(header.name, "User-Agent")
        XCTAssertEqual(header.description, "User-Agent : User-Agent")
    }

}
