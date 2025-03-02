//
//  Spark+URLEncodeing.swift
//  Spark
//
//  Created by Dream on 2025/2/22.
//

import Foundation


// MARK: - Spark.URLEncodeing
public extension Spark {
    
    struct URLEncodeing: Sendable {
        
        /// Returns a default `URLEncoding` instance with a `.methodDependent` destination.
        public static var `default`: URLEncodeing { URLEncodeing() }
        
        /// Returns a `URLEncoding` instance with a `.queryString` destination.
        public static var queryString: URLEncodeing { URLEncodeing(destination: .queryString) }
        
        /// Returns a `URLEncoding` instance with an `.httpBody` destination.
        public static var httpBody: URLEncodeing { URLEncodeing(destination: .httpBody) }
        
        
        /// The destination defining where the encoded query string is to be applied to the URL request.
        public var destination: Spark.URLEncodeing.Destination
        
        /// The encoding to use for `Array` parameters.
        public var arrayEncoding: Spark.URLEncodeing.ArrayEncoding
        
        /// The encoding to use for `Bool` parameters.
        public var boolEncoding: Spark.URLEncodeing.BoolEncoding
        
        
        /// `Spark.URLEncodeing` Initialization method
        /// - Parameters:
        ///   - destination:    The destination defining where the encoded query string is to be applied to the URL request.
        ///   - arrayEncoding:  The encoding to use for `Array` parameters.
        ///   - boolEncoding:   The encoding to use for `Bool` parameters.
        public init(destination: Spark.URLEncodeing.Destination = .methodDependent, arrayEncoding: ArrayEncoding = .brackets, boolEncoding: BoolEncoding = .numeric) {
            self.destination    = destination
            self.arrayEncoding  = arrayEncoding
            self.boolEncoding   = boolEncoding
        }
    }
}

// MARK: - Spark.URLEncodeing: Destination
public extension Spark.URLEncodeing {
    
    /// Defines whether the url-encoded query string is applied to the existing query string or HTTP body of the
    /// resulting URL request.
    enum Destination: Sendable {
        
        /// Applies encoded query string result to existing query string for `GET`, `HEAD` and `DELETE` requests and
        /// sets as the HTTP body for requests with any other HTTP method.
        case methodDependent
        
        /// Sets or appends encoded query string result to existing query string.
        case queryString
        
        /// Sets encoded query string result as the HTTP body of the URL request.
        case httpBody
        
        /// Method of Judging Request
        /// - Parameter method:`get`, `post` DSMethod
        /// - Returns: contains
        func encodesParametersInURL(for method: Spark.Method) -> Bool {
            switch self {
            case .methodDependent: [method].contains(.get)
            case .queryString: true
            case .httpBody: false
            }
        }
        
        
    }
}

// MARK: - Spark.URLEncodeing: ArrayEncoding
public extension Spark.URLEncodeing {
    
    /// Configures how `Array` parameters are encoded.
    enum ArrayEncoding: Sendable {
        
        /// An empty set of square brackets is appended to the key for every value. This is the default behavior.
        case brackets
        
        /// No brackets are appended. The key is encoded as is.
        case noBrackets
        
        /// Brackets containing the item index are appended. This matches the jQuery and Node.js behavior.
        case indexInBrackets
        
        /// Provide a custom array key encoding with the given closure.
        case custom(@Sendable (_ key: String, _ index: Int) -> String)
        
        /// Encodes the key according to the encoding.
        ///
        /// - Parameters:
        ///     - key:   The `key` to encode.
        ///     - index: When this enum instance is `.indexInBrackets`, the `index` to encode.
        ///
        /// - Returns:   The encoded key.
        func encode(key: String, atIndex index: Int) -> String {
            switch self {
            case .brackets: "\(key)[]"
            case .noBrackets: key
            case .indexInBrackets: "\(key)[\(index)]"
            case let .custom(encoding): encoding(key, index)
            }
        }
    }
}

// MARK: - Spark.URLEncodeing: BoolEncoding
public extension Spark.URLEncodeing {
    
    /// Configures how `Bool` parameters are encoded.
    enum BoolEncoding: Sendable {
        
        /// Encode `true` as `1` and `false` as `0`. This is the default behavior.
        case numeric
        
        /// Encode `true` and `false` as string literals.
        case literal
        
        /// Encodes the given `Bool` as a `String`.
        ///
        /// - Parameter value: The `Bool` to encode.
        ///
        /// - Returns:         The encoded `String`.
        func encode(_ value: Bool) -> String {
            switch self {
            case .numeric: value ?  "1" : "0"
            case .literal: value ? "true" : "false"
            }
        }
    }
    
    
}

extension Spark.URLEncodeing: Spark.ParameterEncoding {
    
    public func encode(_ urlRequest: URLRequest, with parameters: Spark.Parameters?) throws -> URLRequest {
        guard let parameters = parameters else { return urlRequest }
        
        var request = urlRequest
        
        if let method = request.method, destination.encodesParametersInURL(for: method) {
            
            guard let url = request.url else { throw Spark.Error.parameterEncodingFailed(reason: .missingURL) }
            
            if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
                let percentEncodedQuery = (urlComponents.percentEncodedQuery.map { $0 + "&" } ?? "") + query(parameters)
                urlComponents.percentEncodedQuery = percentEncodedQuery
                request.url = urlComponents.url
            }
            
        } else {
            if request.headers["Content-Type"] == nil {
                request.headers.update(.contentType("application/x-www-form-urlencoded; charset=utf-8"))
            }
            
//            request.httpBody = Data(query(parameters).utf8)
        }
        
        return request
    }

}

extension Spark.URLEncodeing {
    /// Create a group percent-escaped, URL encoded query string components from the given key-value pair recursively.
    /// - Parameter parameters: [String: Any]
    /// - Returns:
    private func query(_ parameters: [String: Any]) -> String {
        
        return ""
    }
    
    /// Creates a percent-escaped, URL encoded query string components from the given key-value pair recursively.
    ///
    /// - Parameters:
    ///   - key:   Key of the query component.
    ///   - value: Value of the query component.
    ///
    /// - Returns: The percent-escaped, URL encoded query string components.
    public func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
        var components: [(String, String)] = []
        switch value {
        case let dictionary as [String: Any]:
        case let array as [Any]:
        case let number as NSNumber:
        case let bool as Bool:
        default: break
        }
        return components
    }
}

// MARK: -
