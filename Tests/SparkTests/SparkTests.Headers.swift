//
//  SparkTests.Headers.swift
//  Spark
//
//  Created by Dream on 2025/2/27.
//

import XCTest

@testable import Spark

final class SparkTestsHeaders: SparkTests {

    func test_Header_subscript_name1() {

        // Given
        var headers = Headers()

        // When
        headers["Accept"] = nil

        // Then
        headers["Accept"].map { XCTAssertTrue($0.isEmpty) }
    }

    func test_Header_subscript_name2() {

        // Given
        var headers = Headers()

        // When
        headers["Accept"] = "Accept"

        // Then
        XCTAssertEqual(headers["Accept"], "Accept")
    }

    func test_Header_subscript_key1() {

        // Given
        var headers = Headers()

        // When
        headers[.Accept] = nil

        // Then
        headers[.Accept].map { XCTAssertTrue($0.isEmpty) }
    }

    func test_Header_subscript_key2() {

        // Given
        var headers = Headers()

        // When
        headers[.Accept] = "Accept"

        // Then
        XCTAssertEqual(headers[.Accept], "Accept")
    }

    func test_Headers_add_name() {

        // Given
        var headers = Headers()

        // When
        headers.add(name: "Accept", value: "Accept")

        // Then
        XCTAssertEqual(headers["Accept"], "Accept")

    }

    func test_Headers_add_key() {

        // Given
        var headers = Headers()

        // When
        headers.add(key: .Accept, value: "Accept")

        // Then
        XCTAssertEqual(headers["Accept"], "Accept")
    }

    func test_Headers_update_name() {

        // Given
        var headers = Headers()

        // When
        headers.update(name: "Accept", value: "Accept")

        // Then
        XCTAssertEqual(headers["Accept"], "Accept")

    }

    func test_Headers_update_key() {

        // Given
        var headers = Headers([.Accept: "Accept"])

        // When
        headers.update(key: .Accept, value: "update: accept")

        // Then
        XCTAssertEqual(headers[.Accept], "update: accept")
    }

    func test_Headers_remove_name() {
        // Given
        var headers = Headers(["Accept": "Accept"])

        // When
        headers.remove(name: "Accept")

        // Then
        headers["Accept"].map { XCTAssertTrue($0.isEmpty) }
    }

    func test_Headers_remove_key() {

        // Given
        var headers = Headers([.Accept: "Accept"])

        // When
        headers.remove(key: .Accept)

        // Then
        headers[.Accept].map { XCTAssertTrue($0.isEmpty) }

    }

    func test_Headers_sort() {

        // Given
        let headers = Headers([.Basic: "Basic", .Accept: "Accept", .UserAgent: "UserAgent", .ContentType: "ContentType"])

        // When
        let sorted = headers.sorted()

        // Then
        sorted.first.map { XCTAssertEqual($0.name, "Accept") }
    }

    func test_Headers_dictionary() {

        // Given
        let dictionary = ["Accept": "Accept", "Basic": "Basic", "ContentType": "ContentType"]

        // When
        let headers = Headers(dictionary)

        // Then
        XCTAssertEqual(dictionary, headers.dictionary)
    }

    func test_Headers_firstIndex() {

        // Given
        let dictionary = ["ContentType": "ContentType", "Basic": "Basic", "Accept": "Accept", "User-Agent": "User-Agent"]

        // When
        let headers = Headers(dictionary).sorted()

        // Then
        XCTAssertEqual(headers[headers.startIndex].name, "Accept")
    }

    func test_Headers_lastIndex() {

        // Given
        let dictionary = ["Basic": "Basic", "Accept": "Accept", "User-Agent": "User-Agent", "ContentType": "ContentType"]

        // When
        let headers = Headers(dictionary).sorted()

        // Then
        let lastIndex = headers.index(before: headers.endIndex)
        XCTAssertEqual(headers[lastIndex].name, "User-Agent")
    }

    func test_Headers_Index() {

        // Given
        let dictionary = ["Basic": "Basic", "Accept": "Accept", "User-Agent": "User-Agent", "ContentType": "ContentType"]
        let headers = Headers(dictionary).sorted()

        // When
        let index = headers.index(after: headers.startIndex)

        // Then
        XCTAssertEqual(headers[index].name, "Basic")
    }

    func test_Headers_arrayLiteral() {

        // Given, When
        let headers = Headers(arrayLiteral: Header(key: .Accept, value: ""), Header(name: "Basic", value: "Basic"))

        // Then
        XCTAssertFalse(headers.isEmpty)
    }

    func test_Headers_dictionaryLiteral() {

        // Given, When
        let headers = Headers(dictionaryLiteral: ("Basic", "Basic"), (Header.Key.Accept.rawValue, "Accept"))

        // Then
        XCTAssertFalse(headers.isEmpty)

    }

    func test_Headers_makeIterator() {

        // Given
        let dictionary = ["Accept": "Accept", "Basic": "Basic", "ContentType": "ContentType"]
        let headers = Headers(dictionary)

        // When
        var iterator = headers.makeIterator()
        var iteratorData: [String: String] = [:]
        while let header = iterator.next() {
            iteratorData[header.name] = header.value
        }

        // Then
        XCTAssertTrue(headers.dictionary == iteratorData && iteratorData == dictionary)
    }

}
