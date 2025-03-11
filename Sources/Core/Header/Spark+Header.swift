//
//  Spark+Header.swift
//  Spark
//
//  Created by Dream on 2025/2/24.
//

import Foundation

// MARK: - Spark.Header
extension Spark {
    /// HTTP Header
    public struct Header {

        /// Request Header name
        let name: String

        /// Request Header value
        let value: String

        /// `Spark.Header` Initialization method
        /// - Parameters:
        ///   - name:   Request Header name
        ///   - value:  Request Header value
        public init(name: String, value: String) {
            self.name = name
            self.value = value
        }

        /// `Spark.Header` Initialization method
        /// - Parameters:
        ///   - key:    Request Spark.Header.Key
        ///   - value:  Request Header value
        public init(key: Spark.Header.Key, value: String) {
            self.init(name: key.rawValue, value: value)
        }

    }
}

// MARK: - Spark.Headers: Equatable, Hashable, Sendable
extension Spark.Header: Equatable, Hashable, Sendable {}

// MARK: - Spark.Header: CustomStringConvertible
extension Spark.Header: CustomStringConvertible {
    /// Print information format,
    /// Example: `name: value`, `Content-Type: application/json"`
    public var description: String { "\(name) : \(value)" }
}

// MARK: - Spark.Header.Key
extension Spark.Header {

    /// Spark Header Key
    public enum Key: (String), Sendable {
        case Accept
        case AcceptCharset = "Accept-Charset"
        case AcceptLanguage = "Accept-Language"
        case AcceptEncoding = "Accept-Encoding"
        case Authorization
        case Basic
        case Bearer
        case ContentDisposition = "Content-Disposition"
        case ContentEncoding = "Content-Encoding"
        case ContentType = "Content-Type"
        case UserAgent = "User-Agent"
    }
}
extension Spark.Header.ContentTypeValue {
 
    
    /// Content-Type: text/ plain, html, css, javascript, xml
    public enum Text: String {
        case plain, html, css, javascript, xml
    }

    /// Content-Type: image/ jpeg, gif, png
    public enum Image: String {
        case jpeg, gif, png
    }

    /// Content-Type: audio/ mpeg
    public enum Audio: String {
        case mpeg
    }

    /// Content-Type: video/ mp4
    public enum Video: String {
        case mp4
    }

    /// Content-Type: application/ json, xml, pdf, msword, octetStream
    public enum Application: String {
        case json, xml, pdf, msword
        case octetStream = "octet-stream"
    }

    /// Content-Type: multipart/ form-data
    public enum Multipart: String {
        case formData = "form-data"
    }
}

extension Spark.Header {

    public enum ContentTypeValue {
        case text(Text)
        case image(Image)
        case audio(Audio)
        case video(Video)
        case application(Application)
        case multipart(Multipart)

        var value: String {
            switch self {
            case .text(let value): "text/\(value.rawValue)"
            case .image(let value): "image/\(value.rawValue)"
            case .audio(let value): "audio/\(value.rawValue)"
            case .video(let value): "video/\(value.rawValue)"
            case .application(let value): "application/\(value.rawValue)"
            case .multipart(let value): "multipart/\(value.rawValue)"
            }
        }
    }

}

// MARK: - Spark.Header
// Packaging name set key
extension Spark.Header {

    /// Returns an `Accept` header.
    /// - Parameter value: `Accept` value.
    /// - Returns: Spark.Header
    public static func accept(_ value: String) -> Self {
        Spark.Header(key: .Accept, value: value)
    }

    /// Returns an `Accept-Charset` header.
    /// - Parameter value:  `Accept-Charset` value.
    /// - Returns: Spark.Header
    public static func acceptCharset(_ value: String) -> Self {
        Spark.Header(key: .AcceptCharset, value: value)
    }

    /// Returns an `Accept-Language` header.
    /// - Parameter value: `Accept-Language` value.
    /// - Returns:  Spark.Header
    public static func acceptLanguage(_ value: String) -> Self {
        Spark.Header(key: .AcceptLanguage, value: value)
    }

    /// Returns an `Accept-Encoding` header.
    /// - Parameter value: `Accept-Encoding` value.
    /// - Returns: Spark.Header
    public static func acceptEncoding(_ value: String) -> Self {
        Spark.Header(key: .AcceptEncoding, value: value)
    }

    /// Returns an `Authorization` header.
    /// - Parameter value: The `Authorization` value.
    /// - Returns: Spark.Header
    public static func authorization(_ value: String) -> Self {
        Spark.Header(key: .Authorization, value: value)
    }

    ///  Returns a `Basic` `Authorization` header using the `username` and `password` provided.
    /// - Parameters:
    ///   - username: The username of the header.
    ///   - password: The password of the header.
    /// - Returns: Spark.Header
    public static func authorization(username: String, password: String) -> Self {
        let credential = Data("\(username):\(password)".utf8).base64EncodedString()
        return authorization("\(Spark.Header.Key.Basic) \(credential)")
    }

    /// Returns a `Bearer` `Authorization` header using the `bearerToken` provided
    /// - Parameter bearerToken: The bearer token.
    /// - Returns: Spark.Header
    public static func authorization(bearerToken: String) -> Self {
        authorization("\(Spark.Header.Key.Bearer) \(bearerToken)")
    }

    ///  Returns a `Content-Disposition` header.
    /// - Parameter value: The `Content-Disposition` value.
    /// - Returns: Spark.Header
    public static func contentDisposition(_ value: String) -> Self {
        Spark.Header(key: .ContentDisposition, value: value)
    }

    /// Returns a `Content-Encoding` header.
    /// - Parameter value: The `Content-Encoding`.
    /// - Returns: Spark.Header
    public static func contentEncoding(_ value: String) -> Self {
        Spark.Header(key: .ContentEncoding, value: value)
    }

    /// Returns a `Content-Type` header.
    /// - Parameter value: `Content-Type` value.
    /// - Returns: Spark.Header
    public static func contentType(_ value: String) -> Self {
        Spark.Header(key: .ContentType, value: value)
    }

    /// Returns a `Content-Type` header.
    /// - Parameter value: `ContentTypeValue` value.
    /// - Returns: Spark.Header
    public static func contentType(_ value: ContentTypeValue) -> Self {
        Spark.Header(key: .ContentType, value: value.value)
    }

    /// Returns a `User-Agent` header.
    /// - Parameter value: The `User-Agent` value.
    /// - Returns: Spark.Header
    public static func userAgent(_ value: String) -> Self {
        Spark.Header(key: .UserAgent, value: value)
    }

}
// MARK: -
