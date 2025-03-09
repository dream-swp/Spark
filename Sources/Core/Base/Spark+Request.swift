//
//  Spark+Request.swift
//  Spark
//
//  Created by Dream on 2025/3/9.
//

import Foundation

public extension Spark {
    
    
    class Request: @unchecked Sendable {
        
        var host: Host
        var method: Spark.Method = .get
        var path: Path = .custom("")
        var scheme: Scheme = .https
        var port: Port? = nil
        var headers: Spark.Headers = .init()
        var encoding: Spark.ParameterEncoding = URLEncoding.default
        var parameters: Spark.Parameters? = nil
        var requestModifier: Spark.RequestModifier? = nil
        var timeout: TimeInterval = 60
        var queryItems: [URLQueryItem] = []
        var cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
        
//        var urlRequest: URLRequest { try! skURLRequest() }

        init(host: Host, method: Spark.Method, path: Path, scheme: Scheme, port: Port? = nil, headers: Spark.Headers, encoding: Spark.ParameterEncoding, parameters: Spark.Parameters? = nil, requestModifier: Spark.RequestModifier? = nil, timeout: TimeInterval, queryItems: [URLQueryItem], cachePolicy: URLRequest.CachePolicy) {
            self.host = host
            self.method = method
            self.path = path
            self.scheme = scheme
            self.port = port
            self.headers = headers
            self.encoding = encoding
            self.parameters = parameters
            self.requestModifier = requestModifier
            self.timeout = timeout
            self.queryItems = queryItems
            self.cachePolicy = cachePolicy
        }
        
    }
    
}


public extension Spark.Request {
    
    @discardableResult
    func scheme(_ scheme: Scheme) -> Self {
        self.scheme = scheme
        return self
    }
    
    @discardableResult
    func port(_ port: Port) -> Self {
        self.port = port
        return self
    }
    
    @discardableResult
    func host(_ host: Host) -> Self {
        self.host = host
        return self
    }
    
    @discardableResult
    func path(_ path: Path) -> Self {
        self.path = path
        return self
    }
    
    @discardableResult
    func method(_ method: Spark.Method) -> Self {
        self.method = method
        return self
    }
    
    @discardableResult
    func headers(_ headers: Spark.Headers) -> Self {
        self.headers = headers
        return self
    }
    
    @discardableResult
    func timeout(_ timeout: TimeInterval) -> Self {
        self.timeout = timeout
        return self
    }
    
    @discardableResult
    func queryItems(_ queryItems: [URLQueryItem]) -> Self {
        self.queryItems = queryItems
        return self
    }
    
    @discardableResult
    func cachePolicy(_ cachePolicy: URLRequest.CachePolicy) -> Self {
        self.cachePolicy = cachePolicy
        return self
    }
    
    @discardableResult
    func parameters(_ parameters: Spark.Parameters?) -> Self {
        self.parameters = parameters
        return self
    }
    
    @discardableResult
    func parameters(_ requestModifier: Spark.RequestModifier?) -> Self {
        self.requestModifier = requestModifier
        return self
    }
}


public extension Spark.Request {
    
    enum Scheme: String, Sendable {
        case http
        case https

        var port: Int {
            switch self {
            case .http: 80
            case .https: 443
            }
        }
    }
    
    
    enum Host: Sendable {
        
        case localhost
        case custom(_ host: String)
        
        var rawValue: String {
            switch self {
            case .localhost: "127.0.0.1"
            case .custom(let value): value
            }
        }
        
        func port(for scheme: Scheme) -> Int {
            switch self {
            case .localhost: 8080
            case .custom: scheme.port
            }
        }
    }
    
    enum Path: Sendable {
        
        case xml
        case method(Spark.Method)
        case custom(String)
        
        var string: String {
            switch self {
            case .xml: "/xml"
            case .method(let method): "/\(method.rawValue.lowercased())"
            case .custom(let value): value
            }
        }
    }
    
    enum Port: Sendable {
        case scheme(Scheme)
        case custom(Int)
        
        var value: Int {
            switch self {
            case .scheme(let scheme): scheme.port
            case .custom(let value): value
            }
        }
    }
    
}

extension Spark.Request: Spark.URLConvert {
    
    public func skURL() throws -> URL {
        
        var components = URLComponents()
        components.scheme = scheme.rawValue
        components.port = port?.value
        components.host = host.rawValue
        components.path = path.string
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        return try components.skURL()
    }
    
}

extension Spark.Request: Spark.URLRequestConvert {
    
    public func skURLRequest() throws -> URLRequest {
        var request = try URLRequest(url: skURL())
        request.method = method
        request.headers = headers
        request.timeoutInterval = timeout
        request.cachePolicy = cachePolicy
        try requestModifier?(&request)
        return try encoding.encode(request, with: parameters)
    }
    
}
