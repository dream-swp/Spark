//
//  Spark+Request.swift
//  Spark
//
//  Created by Dream on 2025/3/9.
//

import Foundation

// MARK: - RequestConvert

/// Request Convert
public class RequestConvert<Model: Codable>: @unchecked Sendable {

    public typealias Convert = (_ convert: () -> any URLConvert) -> RequestConvert

    var convert: any URLConvert
    var method: Method = .get
    var encoding: any ParameterEncoding = URLEncoding.default
    var parameters: Parameters?
    var headers: Headers?
    var requestModifier: RequestModifier?
    var model: Model.Type?
    var decoder = JSONDecoder.sk.decoder

    /// Returns a default `URLRequest`
    public var urlRequest: URLRequest? {
        guard let urlRequest = try? skURLRequest() else { return nil }
        return urlRequest
    }

    /// Initialization `RequestConvert`
    /// - Parameters:
    ///   - convert:            `URLConvert` value to be used as the `URLRequest`'s `URL`.
    ///   - method:             `Method` for the `URLRequest`. `.get` by default.
    ///   - encoding:           `ParameterEncoder` to be used to encode the `parameters` value into the `URLRequest`,
    ///   - parameters:         `Encodable` value to be encoded into the `URLRequest`. `nil` by default.
    ///   - headers:            `Headers` value to be added to the `URLRequest`. `nil` by default.
    ///   - requestModifier:    `RequestModifier` which will be applied to the `URLRequest` created from
    public init(convert: any URLConvert, method: Method = .get, encoding: any ParameterEncoding = URLEncoding.default, parameters: Parameters? = nil, headers: Headers? = nil, requestModifier: RequestModifier? = nil) {
        self.convert = convert
        self.method = method
        self.encoding = encoding
        self.parameters = parameters
        self.headers = headers
        self.requestModifier = requestModifier
    }

    /// Returns a default `RequestConvert` instance with a `post` RequestConvert  destination.
    public static var post: Convert {
        { .init(convert: $0()).method(.post).encoding(JSONEncoding.default) }
    }

    /// Returns a default `RequestConvert` instance with a `get` RequestConvert  destination.
    public static var get: Convert {
        return { .init(convert: $0()).method(.get).encoding(URLEncoding.default) }
    }
}

// MARK: - RequestConvert Extension
extension RequestConvert {

    /// Update method
    /// - Parameter convert: URLConvert
    /// - Returns: the current calling object
    @discardableResult
    func convert(_ convert: any URLConvert) -> Self {
        self.convert = convert
        return self
    }

    /// Update method
    /// - Parameter method: Method
    /// - Returns: the current calling object
    @discardableResult
    func method(_ method: Method) -> Self {
        self.method = method
        return self
    }

    /// Update parameters
    /// - Parameter parameters: Parameters
    /// - Returns: the current calling object
    @discardableResult
    func parameters(_ parameters: Parameters?) -> Self {
        self.parameters = parameters
        return self
    }

    /// Update encoding
    /// - Parameter encoding: ParameterEncoding
    /// - Returns: the current calling object
    @discardableResult
    func encoding(_ encoding: ParameterEncoding) -> Self {
        self.encoding = encoding
        return self
    }

    /// Update headers
    /// - Parameter headers: Headers
    /// - Returns: the current calling object
    @discardableResult
    func headers(_ headers: Headers?) -> Self {
        self.headers = headers
        return self
    }

    /// Update requestModifier
    /// - Parameter requestModifier: RequestModifier
    /// - Returns: the current calling object
    @discardableResult
    func requestModifier(_ requestModifier: RequestModifier?) -> Self {
        self.requestModifier = requestModifier
        return self
    }
    
    /// Update model
    /// - Parameter model: model
    /// - Returns: the current calling object
    @discardableResult
    func model(_ model: Model.Type?) -> Self {
        self.model = model
        return self
    }
    
    func decoder(_ decoder: JSONDecoder) -> Self {
        self.decoder = decoder
    }

}

extension RequestConvert: URLRequestConvert {

    /// Returns a `URLRequest` or throws if an `Error` was encountered.
    ///
    /// - Returns: A `URLRequest`.
    /// - Throws:  Any error thrown while constructing the `URLRequest`.
    public func skURLRequest() throws -> URLRequest {
        var request = try URLRequest(url: convert, method: method, headers: headers)
        try requestModifier?(&request)
        return try encoding.encode(request, with: parameters)
    }
}

// MARK: -
