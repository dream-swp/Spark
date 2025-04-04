//
//  SparkTests.swift
//  Spark
//
//  Created by Dream on 2025/2/22.
//

import XCTest

@testable import Spark

class SparkTests: XCTestCase {
    
    func test_version() {
        XCTAssertEqual(SparkInfo.version, "1.0.2")
    }
}
