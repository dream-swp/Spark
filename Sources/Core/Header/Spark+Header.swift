//
//  Spark+Header.swift
//  Spark
//
//  Created by Dream on 2025/2/24.
//

import Foundation


public extension Spark {
    /// HTTP Header
    struct Header {
        /// Request Header name
        let name: String
        
        /// Request Header value
        let value : String
        
        
        /// `Spark.Header` Initialization method
        /// - Parameters:
        ///   - name: Request Header name
        ///   - value: Request Header value
        public init(name: String, value: String) {
            self.name = name
            self.value = value
        }
    }
    
}

extension Spark.Header: Hashable { }

extension Spark.Header: CustomStringConvertible {
    public var description: String { "\(name): \(value)" }
}

// MARK: - Spark.Header Packaging name set key
public extension Spark.Header {
    
    /// Returns an `Accept` header.
    /// - Parameter value: `Accept` value.
    /// - Returns: Spark.Header
    static func accept(_ value: String) -> Self {
        Spark.Header(name: "Accept", value: value)
    }
    
    /// Returns an `Accept-Charset` header.
    /// - Parameter value:  `Accept-Charset` value.
    /// - Returns: Spark.Header
    static func acceptCharset(_ value: String) -> Self {
       Spark.Header(name: "Accept-Charset", value: value)
    }
    
    /// Returns an `Accept-Language` header.
    /// - Parameter value: `Accept-Language` value.
    /// - Returns:  Spark.Header
    static func acceptLanguage(_ value: String) -> Self {
       Spark.Header(name: "Accept-Language", value: value)
    }
    
    /// Returns an `Accept-Encoding` header.
    /// - Parameter value: `Accept-Encoding` value.
    /// - Returns: Spark.Header
    static func acceptEncoding(_ value: String) -> Self {
       Spark.Header(name: "Accept-Encoding", value: value)
    }
    
    ///  Returns a `Basic` `Authorization` header using the `username` and `password` provided.
    /// - Parameters:
    ///   - username: The username of the header.
    ///   - password: The password of the header.
    /// - Returns: Spark.Header
    static func authorization(username: String, password: String) -> Self {
        let credential = Data("\(username):\(password)".utf8).base64EncodedString()

        return authorization("Basic \(credential)")
    }
    
    /// Returns a `Bearer` `Authorization` header using the `bearerToken` provided
    /// - Parameter bearerToken: The bearer token.
    /// - Returns: Spark.Header
    static func authorization(bearerToken: String) -> Self {
        authorization("Bearer \(bearerToken)")
    }

    
    /// Returns an `Authorization` header.
    /// - Parameter value: The `Authorization` value.
    /// - Returns: Spark.Header
    static func authorization(_ value: String) -> Self {
       Spark.Header(name: "Authorization", value: value)
    }
    
    ///  Returns a `Content-Disposition` header.
    /// - Parameter value: The `Content-Disposition` value.
    /// - Returns: Spark.Header
    static func contentDisposition(_ value: String) -> Self {
       Spark.Header(name: "Content-Disposition", value: value)
    }
    
    /// Returns a `Content-Encoding` header.
    /// - Parameter value: The `Content-Encoding`.
    /// - Returns: Spark.Header
    static func contentEncoding(_ value: String) -> Self {
       Spark.Header(name: "Content-Encoding", value: value)
    }
    
    /// Returns a `Content-Type` header.
    /// - Parameter value: `Content-Type` value.
    /// - Returns: Spark.Header
    static func contentType(_ value: String) -> Self {
       Spark.Header(name: "Content-Type", value: value)
    }
  
    /// Returns a `User-Agent` header.
    /// - Parameter value: The `User-Agent` value.
    /// - Returns: Spark.Header
    static func userAgent(_ value: String) -> Self {
       Spark.Header(name: "User-Agent", value: value)
    }
    
}
// MARK: -




