//
//  SparkTests+Helpers.swift
//  Spark
//
//  Created by Dream on 2025/3/7.
//

import XCTest
@testable import Spark


extension SparkTests: SparkCompatible { }

extension SK where SK: SparkTests {
    var defaultRequest: URLRequest { SKRequest.default.urlRequest }
}

extension Data: SparkCompatible { }

extension SK where SK == Data {
    
    var string: String {
        String(decoding: sk, as: UTF8.self)
    }
    
    func JSONObject() throws -> Any {
        try JSONSerialization.jsonObject(with: sk, options: .allowFragments)
    }
}


/// SKRequest
struct SKRequest {
    
    var scheme: Scheme
    var port: Port
    var host: Host
    var path: Path
    var method: Spark.Method
    var headers: Spark.Headers
    var timeout: TimeInterval
    var queryItems: [URLQueryItem]
    var cachePolicy: URLRequest.CachePolicy
    
    var urlRequest: URLRequest { try! skURLRequest() }

    init(scheme: SKRequest.Scheme = .https,
         port: SKRequest.Port = .scheme(.https),
         host: SKRequest.Host = .localhost,
         path: SKRequest.Path = .method(.get),
         method: Spark.Method = .get,
         headers: Spark.Headers = .init(),
         timeout: TimeInterval = 60,
         queryItems: [URLQueryItem] = [],
         cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy) {
        self.scheme = scheme
        self.port = port
        self.path = path
        self.host = host
        self.path = path
        self.method = method
        self.headers = headers
        self.timeout = timeout
        self.queryItems = queryItems
        self.cachePolicy = cachePolicy
    }
    
    mutating func scheme(_ scheme: Scheme) -> Self {
        self.scheme = scheme
        return self
    }
    
    mutating func port(_ port: Port) -> Self {
        self.port = port
        return self
    }
    
    mutating func port(_ host: Host) -> Self {
        self.host = host
        return self
    }
    
    mutating func path(_ path: Path) -> Self {
        self.path = path
        return self
    }
    
    mutating func method(_ method: Spark.Method) -> Self {
        self.method = method
        return self
    }
    
    mutating func headers(_ headers: Spark.Headers) -> Self {
        self.headers = headers
        return self
    }
    
    mutating func timeout(_ timeout: TimeInterval) -> Self {
        self.timeout = timeout
        return self
    }
    
    mutating func queryItems(_ queryItems: [URLQueryItem]) -> Self {
        self.queryItems = queryItems
        return self
    }
    
    mutating func cachePolicy(_ cachePolicy: URLRequest.CachePolicy) -> Self {
        self.cachePolicy = cachePolicy
        return self
    }
    
    
    static let `default`: Self = .init()
}

extension SKRequest {
    
    enum Scheme: String {
        case http
        case https

        var port: Int {
            switch self {
            case .http: 80
            case .https: 443
            }
        }
    }
    
    /// SKRequest.Host
    enum Host {
        
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
    
    enum Path {
        
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
    
    enum Port {
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

extension SKRequest: Spark.URLRequestConvert {
    
     func skURLRequest() throws -> URLRequest {
        var request = try URLRequest(url: skURL())
        request.method = method
        request.headers = headers
        request.timeoutInterval = timeout
        request.cachePolicy = cachePolicy
        return request
    }
    
}

extension SKRequest: Spark.URLConvert {
    
    func skURL() throws -> URL {
        
        var components = URLComponents()
        components.scheme = scheme.rawValue
        components.port = port.value
        components.host = host.rawValue
        components.path = path.string
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        
        return try components.skURL()
    }
    
    
}
