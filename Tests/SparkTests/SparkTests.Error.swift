//
//  SparkTests.Error.swift
//  Spark
//
//  Created by Dream on 2025/2/28.
//

import XCTest
@testable import Spark

extension SparkTests {
    
    func testError() -> Void {
        let error1 = Spark.Error.urlError
        XCTAssertEqual(error1.localizedDescription, "Request URL Error")
        
        let error2 = Spark.Error.invalidResponse
        XCTAssertEqual(error2.localizedDescription, "Invalid response to the request.")
        
        let error3 = Spark.Error.parameterEncodingFailed(reason: .missingURL)
        XCTAssertEqual(error3.localizedDescription, "URL request to encode was missing a URL")
        
        let error4 = Spark.Error.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error1))
        XCTAssertTrue(error4.localizedDescription.contains("JSON could not be encoded because of error: \n "))
        
        let error5 = Spark.Error.parameterEncodingFailed(reason: .customEncodingFailed(error: error2))
        XCTAssertTrue(error5.localizedDescription.contains("Custom parameter encoder failed with error: \n "))
        
        let errorString = """
       Invalid JSON object provided for parameter or object encoding. \
       This is most likely due to a value which can't be represented in Objective-C.
       """
        let error6 = Spark.Error.JSONEncodingError.invalidJSONObject
        XCTAssertEqual(error6.localizedDescription, errorString)
        
    }
    
}
