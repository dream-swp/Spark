//
//  Spark+Convertible.swift
//  Spark
//
//  Created by Dream on 2025/3/9.
//

import Foundation

// MARK: - Convertible

/// Convertible
public protocol Convertible: URLRequestConvert, Sendable, AnyObject {

    associatedtype Model: Codable
    typealias Convert = (_ convert: () -> any URLConvert) -> Self
    
    var convert: any URLConvert { get set }
    var method: Method { get set }
    var encoding: any ParameterEncoding { get set }
    var parameters: Parameters? { get set }
    var headers: Headers? { get set }
    var requestModifier: RequestModifier? { get set }
    var decoder: JSONDecoder { get set }
    var model: Model.Type { get }
    static var post: Convert { get }

}

// MARK: - Convertible: URLRequestConvert
extension Convertible {
    public func urlRequestConvert() throws -> URLRequest {
        var request = try URLRequest(url: convert, method: method, headers: headers)
        try requestModifier?(&request)
        return try encoding.encode(request, with: parameters)
    }
}

// MARK: - Convertible Extension
extension Convertible {

    /// Update method
    /// - Parameter convert: URLConvert
    /// - Returns: the current calling object
    @discardableResult
    public func convert(_ convert: any URLConvert) -> Self {
        self.convert = convert
        return self
    }

    /// Update method
    /// - Parameter method: Method
    /// - Returns: the current calling object
    @discardableResult
    public func method(_ method: Method) -> Self {
        self.method = method
        return self
    }

    /// Update parameters
    /// - Parameter parameters: Parameters
    /// - Returns: the current calling object
    @discardableResult
    public func parameters(_ parameters: Parameters?) -> Self {
        self.parameters = parameters
        return self
    }

    /// Update encoding
    /// - Parameter encoding: ParameterEncoding
    /// - Returns: the current calling object
    @discardableResult
    public func encoding(_ encoding: ParameterEncoding) -> Self {
        self.encoding = encoding
        return self
    }

    /// Update headers
    /// - Parameter headers: Headers
    /// - Returns: the current calling object
    @discardableResult
    public func headers(_ headers: Headers?) -> Self {
        self.headers = headers
        return self
    }

    /// Update requestModifier
    /// - Parameter requestModifier: RequestModifier
    /// - Returns: the current calling object
    @discardableResult
    public func requestModifier(_ requestModifier: RequestModifier?) -> Self {
        self.requestModifier = requestModifier
        return self
    }

    /// Update model
    /// - Parameter model: model
    /// - Returns: the current calling object

    @discardableResult
    public func decoder(_ decoder: JSONDecoder) -> Self {
        self.decoder = decoder
        return self
    }

}

extension Convertible {

}

// MARK: - RequestConvertible
public class RequestConvertible: Convertible, @unchecked Sendable {
   

    public typealias Item = RequestConvertible

    public typealias Model = Data

    public var model: Data.Type { Data.self }

    public var convert: any URLConvert

    public var method: Method

    public var encoding: any ParameterEncoding

    public var parameters: Parameters?

    public var headers: Headers?

    public var requestModifier: RequestModifier?

    public var decoder: JSONDecoder = JSONDecoder.sk.decoder

    public init(convert: any URLConvert, method: Method, encoding: any ParameterEncoding, parameters: Parameters? = nil, headers: Headers? = nil, requestModifier: RequestModifier? = nil, decoder: JSONDecoder = JSONDecoder.sk.decoder) {
        self.convert = convert
        self.method = method
        self.encoding = encoding
        self.parameters = parameters
        self.headers = headers
        self.requestModifier = requestModifier
        self.decoder = decoder
    }
    
    public static var post: Convert {
        return { .init(convert: $0(), method: .post, encoding: URLEncoding.default) }
    }
}


// MARK: - RequestConvertibleModel
public class RequestConvertibleModel<Item: Codable>: Convertible, @unchecked Sendable {

    public typealias Model = Item

    public var model: Item.Type {
        Item.self
    }

    public var convert: any URLConvert

    public var method: Method

    public var encoding: any ParameterEncoding

    public var parameters: Parameters?

    public var headers: Headers?

    public var requestModifier: RequestModifier?

    public var decoder: JSONDecoder

    public init(convert: any URLConvert, method: Method, encoding: any ParameterEncoding, parameters: Parameters? = nil, headers: Headers? = nil, requestModifier: RequestModifier? = nil, decoder: JSONDecoder = JSONDecoder.sk.decoder) {
        self.convert = convert
        self.method = method
        self.encoding = encoding
        self.parameters = parameters
        self.headers = headers
        self.requestModifier = requestModifier
        self.decoder = decoder
    }

}


// MARK: -
