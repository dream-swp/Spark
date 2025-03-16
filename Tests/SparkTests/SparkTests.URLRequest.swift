//
//  SparkTests.URLRequest.swift
//  Spark
//
//  Created by Dream on 2025/2/28.
//

import XCTest

@testable import Spark

final class SparkTestsURLRequest: SparkTests {

    private let url = "https://wwww.test.com"

    private func url(_ url: String) throws -> URLConvert {
        try URL(string: url)!.urlConvert()
    }

    private func urlComponents(_ url: String) throws -> URLConvert {
        try URLComponents(string: url)!.urlConvert()
    }

    func test_error_URLRequest_get1() throws {

        // Given, When
        let urlRequest = try URLRequest(url: url, method: .get, headers: [.accept("accept"), .userAgent("userAgent")])

        // Then
        XCTAssertEqual(urlRequest.httpMethod, Method.get.rawValue)
    }

    func test_error_URLRequest_get2() throws {

        // Given
        var urlRequest = try URLRequest(url: url, method: .post, headers: nil)

        // When
        urlRequest.method = .get
        urlRequest.headers = [.accept("accept")]

        // Then
        XCTAssertEqual(urlRequest.method?.rawValue, urlRequest.httpMethod)
    }

    func test_error_URLRequest_post1() throws {

        // Given, When
        let header: Headers = [.accept("accept"), .userAgent("userAgent")]
        let urlRequest = try URLRequest(url: url(url), method: .post, headers: header)

        // Then
        XCTAssertEqual(urlRequest.httpMethod, Method.post.rawValue)
        XCTAssertEqual(urlRequest.allHTTPHeaderFields, header.dictionary)
    }

    func test_error_URLRequest_post2() throws {

        // Given, When
        let urlRequest = try URLRequest(url: url(url), method: .post)

        // Then
        XCTAssertNotNil(urlRequest.allHTTPHeaderFields)
    }

    func test_error_URLRequest_urlComponents() throws {

        // Given, When
        let urlRequest = try URLRequest(url: urlComponents(url), method: .post)

        // Then
        XCTAssertNotNil(urlRequest.allHTTPHeaderFields)
    }

}
