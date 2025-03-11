//
//  SparkTests.Header.ContentType.swift
//  Spark
//
//  Created by Dream on 2025/3/12.
//

import XCTest

@testable import Spark

final class SparkTestsHeaderContentType: SparkTests {}

// text
extension SparkTestsHeaderContentType {

    func test_HeaderContentType_text_plain() {

        // Given, When
        let header = Spark.Header.contentType(.text(.plain))

        // Then
        XCTAssertEqual(header.value, "text/plain")
    }

    func test_HeaderContentType_text_html() {

        // Given, When
        let header = Spark.Header.contentType(.text(.html))

        // Then
        XCTAssertEqual(header.value, "text/html")
    }

    func test_HeaderContentType_text_css() {

        // Given, When
        let header = Spark.Header.contentType(.text(.css))

        // Then
        XCTAssertEqual(header.value, "text/css")
    }

    func test_HeaderContentType_text_javascript() {

        // Given, When
        let header = Spark.Header.contentType(.text(.javascript))

        // Then
        XCTAssertEqual(header.value, "text/javascript")
    }

    func test_HeaderContentType_text_xml() {

        // Given, When
        let header = Spark.Header.contentType(.text(.xml))

        // Then
        XCTAssertEqual(header.value, "text/xml")
    }
}

// image
extension SparkTestsHeaderContentType {

    func test_HeaderContentType_image_jpeg() {
        // Given, When
        let header = Spark.Header.contentType(.image(.jpeg))

        // Then
        XCTAssertEqual(header.value, "image/jpeg")
    }

    func test_HeaderContentType_image_gif() {
        // Given, When
        let header = Spark.Header.contentType(.image(.gif))

        // Then
        XCTAssertEqual(header.value, "image/gif")
    }

    func test_HeaderContentType_image_png() {
        // Given, When
        let header = Spark.Header.contentType(.image(.png))

        // Then
        XCTAssertEqual(header.value, "image/png")
    }
}

// audio
extension SparkTestsHeaderContentType {

    func test_HeaderContentType_audio_mpeg() {
        // Given, When
        let header = Spark.Header.contentType(.audio(.mpeg))

        // Then
        XCTAssertEqual(header.value, "audio/mpeg")
    }
}

// video
extension SparkTestsHeaderContentType {

    func test_HeaderContentType_video_mp4() {
        // Given, When
        let header = Spark.Header.contentType(.video(.mp4))

        // Then
        XCTAssertEqual(header.value, "video/mp4")
    }
}

// application
extension SparkTestsHeaderContentType {

    func test_HeaderContentType_application_json() {
        // Given, When
        let header = Spark.Header.contentType(.application(.json))

        // Then
        XCTAssertEqual(header.value, "application/json")
    }

    func test_HeaderContentType_application_xml() {
        // Given, When
        let header = Spark.Header.contentType(.application(.xml))

        // Then
        XCTAssertEqual(header.value, "application/xml")
    }

    func test_HeaderContentType_application_pdf() {
        // Given, When
        let header = Spark.Header.contentType(.application(.pdf))

        // Then
        XCTAssertEqual(header.value, "application/pdf")
    }

    func test_HeaderContentType_application_msword() {
        // Given, When
        let header = Spark.Header.contentType(.application(.msword))

        // Then
        XCTAssertEqual(header.value, "application/msword")
    }

    func test_HeaderContentType_application_octet_stream() {
        // Given, When
        let header = Spark.Header.contentType(.application(.octetStream))

        // Then
        XCTAssertEqual(header.value, "application/octet-stream")
    }
}

// multipart
extension SparkTestsHeaderContentType {

    func test_HeaderContentType_multipart_form_data() {
        // Given, When
        let header = Spark.Header.contentType(.multipart(.formData))

        // Then
        XCTAssertEqual(header.value, "multipart/form-data")
    }
}
