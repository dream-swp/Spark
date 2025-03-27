//
//  SparkTests.Error.swift
//  Spark
//
//  Created by Dream on 2025/2/28.
//

import XCTest

@testable import Spark

final class SparkTestsError: SparkTests {

    func test_error_urlError() {

        // Given, When
        let error = SKError.urlError

        // Then
        XCTAssertEqual(error.localizedDescription, "Request URL Error")
    }

    func test_error_invalidResponse() {

        // Given, When
        let error = SKError.invalidResponse

        // Then
        XCTAssertEqual(error.localizedDescription, "Invalid response to the request.")
    }

    func test_error_invalidURL() {

        // Given, When
        let error = SKError.invalidURL(url: "WERTYUIOPASDFGHJKLZXCVBNM")

        // Then
        XCTAssertEqual(error.localizedDescription, "URL is not valid: WERTYUIOPASDFGHJKLZXCVBNM")
    }

    func test_error_parameterEncodingFailed_missingURL() {

        // Given, When
        let error = SKError.parameterEncodingFailed(reason: .missingURL)

        // Then
        XCTAssertEqual(error.localizedDescription, "URL request to encode was missing a URL")
    }

    func test_error_parameterEncodingFailed_jsonEncodingFailed() {

        // Given, When
        let error = SKError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: SKError.ParameterEncodingFailureReason.missingURL))

        // Then
        XCTAssertTrue(error.localizedDescription.contains("JSON could not be encoded because of error: \n "))
    }

    func test_error_parameterEncodingFailed_customEncodingFailed() {

        // Given, When
        let error = SKError.parameterEncodingFailed(reason: .customEncodingFailed(error: SKError.invalidResponse))

        // Then
        XCTAssertTrue(error.localizedDescription.contains("Custom parameter encoder failed with error: \n "))
    }

    func test_error_JSONEncodingError_invalidJSONObject() {

        // Given
        let errorString = """
            Invalid JSON object provided for parameter or object encoding. \
            This is most likely due to a value which can't be represented in Objective-C.
            """
        // When
        let error = SKError.JSONEncodingError.invalidJSONObject

        // Then
        XCTAssertEqual(error.localizedDescription, errorString)
    }

}
