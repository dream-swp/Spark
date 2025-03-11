//
//  Spark+Convert.swift
//  Spark
//
//  Created by Dream on 2025/3/2.
//

import Foundation

// MARK: - URLConvert
extension Spark {

    /// Types adopting the `URLConvert` protocol can be used to construct `URL`s, which can then be used to construct
    public protocol URLConvert: Sendable {

        /// Returns a `URL` from the conforming instance or throws.
        ///
        /// - Returns: The `URL` created from the instance.
        /// - Throws:  Any error thrown while creating the `URL`.
        func skURL() throws -> URL
    }

    /// Types adopting the `URLRequestConvert` protocol can be used to safely construct `URLRequest`s.
    public protocol URLRequestConvert: Sendable {

        /// Returns a `URLRequest` or throws if an `Error` was encountered.
        ///
        /// - Returns: A `URLRequest`.
        /// - Throws:  Any error thrown while constructing the `URLRequest`.
        func skURLRequest() throws -> URLRequest
    }

}

// MARK: - String: Spark.URLConvert Extension
extension String: Spark.URLConvert {

    /// Returns a `URL` if `self` can be used to initialize a `URL` instance, otherwise throws.
    ///
    /// - Returns: The `URL` initialized with `self`.
    /// - Throws:  An `Spark.Error.invalidURL` instance.
    public func skURL() throws -> URL {
        guard let url = URL(string: self) else { throw Spark.Error.invalidURL(url: self) }
        return url
    }
}

// MARK: - URL: Spark.URLConvert
extension URL: Spark.URLConvert {

    /// Returns `self`.
    public func skURL() throws -> URL { self }
}

// MARK: - URLComponents: Spark.URLConvert
extension URLComponents: Spark.URLConvert {

    /// Returns a `URL` if the `self`'s `url` is not nil, otherwise throws.
    ///
    /// - Returns: The `URL` from the `url` property.
    /// - Throws:  An `Spark.Error.invalidURL` instance.
    public func skURL() throws -> URL {
        guard let url else { throw Spark.Error.invalidURL(url: self) }
        return url
    }
}

// MARK: - Spark.URLRequestConvert Extension
extension Spark.URLRequestConvert {

    /// The `URLRequest` returned by discarding any `Error` encountered.
    public var urlRequest: URLRequest? { try? skURLRequest() }
}

// MARK: - URLRequest: Spark.URLRequestConvert
extension URLRequest: Spark.URLRequestConvert {

    /// Returns `self`.
    public func skURLRequest() throws -> URLRequest { self }
}

// MARK: - URLRequest Extension
extension URLRequest {

    /// Creates an instance with the specified `url`, `method`, and `headers`.
    ///
    /// - Parameters:
    ///   - url:     The `Spark.URLConvert` value.
    ///   - method:  The `Spark.Method`.
    ///   - headers: The `Spark.Headers`, `nil` by default.
    /// - Throws:    Any error thrown while converting the `URLRequest` to a `URL`.
    public init(url: any Spark.URLConvert, method: Spark.Method, headers: Spark.Headers? = nil) throws {
        let url = try url.skURL()
        self.init(url: url)
        httpMethod = method.rawValue
        allHTTPHeaderFields = headers?.dictionary
    }

    /// Returns the `Method` as `Spark.Method` type.
    public var method: Spark.Method? {
        set { httpMethod = newValue?.rawValue }
        get { httpMethod.map(Spark.Method.init) }
    }

    /// Returns the `Headers` as `Spark.Headers`
    public var headers: Spark.Headers {
        set { allHTTPHeaderFields = newValue.dictionary }
        get { allHTTPHeaderFields.map(Spark.Headers.init) ?? Spark.Headers() }
    }

}

// MARK: -
