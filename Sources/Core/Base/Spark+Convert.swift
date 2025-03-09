//
//  Spark+Convert.swift
//  Spark
//
//  Created by Dream on 2025/3/2.
//

import Foundation

// MARK: - URLConvert
extension Spark  {
    
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
    
    /// Request Convert
    class RequestConvert: @unchecked Sendable, URLRequestConvert {
     
        var url: any Spark.URLConvert
        var method: Spark.Method = .get
        var encoding: any Spark.ParameterEncoding = Spark.URLEncoding.default
        var parameters: Spark.Parameters?
        var headers: Spark.Headers?
        var requestModifier: Spark.RequestModifier?
        
        var urlRequest: URLRequest? {
            guard let urlRequest = try? skURLRequest() else { return nil }
            return urlRequest
        }
        
        func skURLRequest() throws -> URLRequest {
            var request = try URLRequest(url: url, method: method, headers: headers)
            try requestModifier?(&request)
            return try encoding.encode(request, with: parameters)
        }
    
        init(url: any Spark.URLConvert, method: Spark.Method = .get, encoding: any Spark.ParameterEncoding = Spark.URLEncoding.default, parameters: Spark.Parameters? = nil, headers: Spark.Headers? = nil, requestModifier: Spark.RequestModifier? = nil) {
            self.url = url
            self.method = method
            self.encoding = encoding
            self.parameters = parameters
            self.headers = headers
            self.requestModifier = requestModifier
        }

        
    }
    
}

extension Spark.RequestConvert {
    
    func url(_ url: Spark.URLConvert) -> Self {
        self.url = url
        return self
    }
    
    func method(_ method: Spark.Method) -> Self {
        self.method = method
        return self
    }
    
    func parameters(_ parameters: Spark.Parameters?) -> Self {
        self.parameters = parameters
        return self
    }
    
    func encoding(_ encoding: Spark.ParameterEncoding) -> Self {
        self.encoding = encoding
        return self
    }
    
     
    func headers(_ headers: Spark.Headers?) -> Self {
        self.headers = headers
        return self
    }
    
    func requestModifier(_ requestModifier: Spark.RequestModifier?) -> Self {
        self.requestModifier = requestModifier
        return self
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
public extension Spark.URLRequestConvert {
    
    /// The `URLRequest` returned by discarding any `Error` encountered.
    var urlRequest: URLRequest? { try? skURLRequest() }
}

// MARK: - URLRequest: Spark.URLRequestConvert
extension URLRequest: Spark.URLRequestConvert {

    /// Returns `self`.
    public func skURLRequest() throws -> URLRequest { self }
}

// MARK: - URLRequest Extension
public extension URLRequest {
    
    /// Creates an instance with the specified `url`, `method`, and `headers`.
    ///
    /// - Parameters:
    ///   - url:     The `Spark.URLConvert` value.
    ///   - method:  The `Spark.Method`.
    ///   - headers: The `Spark.Headers`, `nil` by default.
    /// - Throws:    Any error thrown while converting the `URLRequest` to a `URL`.
    init(url: any Spark.URLConvert, method: Spark.Method, headers: Spark.Headers? = nil) throws {
        let url = try url.skURL()
        self.init(url: url)
        httpMethod = method.rawValue
        allHTTPHeaderFields = headers?.dictionary
    }

    /// Returns the `Method` as `Spark.Method` type.
    var method: Spark.Method? {
        set { httpMethod = newValue?.rawValue }
        get { httpMethod.map(Spark.Method.init)  }
    }

    /// Returns the `Headers` as `Spark.Headers`
    var headers: Spark.Headers {
        set { allHTTPHeaderFields = newValue.dictionary }
        get { allHTTPHeaderFields.map(Spark.Headers.init) ?? Spark.Headers() }
    }
    
}

// MARK: -
