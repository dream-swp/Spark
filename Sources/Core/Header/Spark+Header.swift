//
//  Spark+Header.swift
//  Spark
//
//  Created by Dream on 2025/2/24.
//

import Foundation

// MARK: - Header
/// HTTP Header
public struct Header {

    /// Request Header name
    let name: String

    /// Request Header value
    let value: String

    /// `Header` Initialization method
    /// - Parameters:
    ///   - name:   Request Header name
    ///   - value:  Request Header value
    public init(name: String, value: String) {
        self.name = name
        self.value = value
    }

    /// `Header` Initialization method
    /// - Parameters:
    ///   - key:    Request Header.Key
    ///   - value:  Request Header value
    public init(key: Header.Key, value: String) {
        self.init(name: key.rawValue, value: value)
    }

}

// MARK: - Headers: Equatable, Hashable, Sendable
extension Header: Equatable, Hashable, Sendable {}

// MARK: - Header: CustomStringConvertible
extension Header: CustomStringConvertible {
    /// Print information format,
    /// Example: `name: value`, `Content-Type: application/json"`
    public var description: String { "\(name) : \(value)" }
}

// MARK: - Header.Key
extension Header {

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

// MARK: - Header Content-Type Value
extension Header.ContentTypeValue {

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

extension Header {

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

// MARK: - Header
// Packaging name set key
extension Header {

    /// Returns an `Accept` header.
    /// - Parameter value: `Accept` value.
    /// - Returns: Header
    public static func accept(_ value: String) -> Self {
        Header(key: .Accept, value: value)
    }

    /// Returns an `Accept-Charset` header.
    /// - Parameter value:  `Accept-Charset` value.
    /// - Returns: Header
    public static func acceptCharset(_ value: String) -> Self {
        Header(key: .AcceptCharset, value: value)
    }

    /// Returns an `Accept-Language` header.
    /// - Parameter value: `Accept-Language` value.
    /// - Returns:  Header
    public static func acceptLanguage(_ value: String) -> Self {
        Header(key: .AcceptLanguage, value: value)
    }

    /// Returns an `Accept-Encoding` header.
    /// - Parameter value: `Accept-Encoding` value.
    /// - Returns: Header
    public static func acceptEncoding(_ value: String) -> Self {
        Header(key: .AcceptEncoding, value: value)
    }

    /// Returns an `Authorization` header.
    /// - Parameter value: The `Authorization` value.
    /// - Returns: Header
    public static func authorization(_ value: String) -> Self {
        Header(key: .Authorization, value: value)
    }

    ///  Returns a `Basic` `Authorization` header using the `username` and `password` provided.
    /// - Parameters:
    ///   - username: The username of the header.
    ///   - password: The password of the header.
    /// - Returns: Header
    public static func authorization(username: String, password: String) -> Self {
        let credential = Data("\(username):\(password)".utf8).base64EncodedString()
        return authorization("\(Header.Key.Basic) \(credential)")
    }

    /// Returns a `Bearer` `Authorization` header using the `bearerToken` provided
    /// - Parameter bearerToken: The bearer token.
    /// - Returns: Header
    public static func authorization(bearerToken: String) -> Self {
        authorization("\(Header.Key.Bearer) \(bearerToken)")
    }

    ///  Returns a `Content-Disposition` header.
    /// - Parameter value: The `Content-Disposition` value.
    /// - Returns: Header
    public static func contentDisposition(_ value: String) -> Self {
        Header(key: .ContentDisposition, value: value)
    }

    /// Returns a `Content-Encoding` header.
    /// - Parameter value: The `Content-Encoding`.
    /// - Returns: Header
    public static func contentEncoding(_ value: String) -> Self {
        Header(key: .ContentEncoding, value: value)
    }

    /// Returns a `Content-Type` header.
    /// - Parameter value: `Content-Type` value.
    /// - Returns: Header
    public static func contentType(_ value: String) -> Self {
        Header(key: .ContentType, value: value)
    }

    /// Returns a `Content-Type` header.
    /// - Parameter value: `ContentTypeValue` value.
    /// - Returns: Header
    public static func contentType(_ value: ContentTypeValue) -> Self {
        Header(key: .ContentType, value: value.value)
    }

    /// Returns a `User-Agent` header.
    /// - Parameter value: The `User-Agent` value.
    /// - Returns: Header
    public static func userAgent(_ value: String) -> Self {
        Header(key: .UserAgent, value: value)
    }

}
// MARK: -
