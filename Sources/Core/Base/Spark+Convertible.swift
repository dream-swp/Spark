//
//  Spark+Convertible.swift
//  Spark
//
//  Created by Dream on 2025/3/9.
//

import Foundation

// MARK: - ConvertibleConvenience
/// ConvertibleConvenience
public protocol ConvertibleConvenience: Sendable {

    /// ConvertibleConvenience closure
    typealias Convert = (_ convert: () -> any URLConvert) -> Self

    /// convenience, init
    /// - Parameters:
    ///   - convert:    `URLConvert` value to be used as the `URLRequest`'s `URL`.
    ///   - method:     `Method` for the `URLRequest`. `.get` by default.
    ///   - encoding:   `ParameterEncoder` to be used to encode the `parameters` value into the `URLRequest
    init(convert: any URLConvert, method: Method, encoding: any ParameterEncoding)

}

// MARK: - ConvertibleConvenience Extension
extension ConvertibleConvenience {

    /// convenience: GET Request
    public static var get: Convert {
        return { self.init(convert: $0(), method: .get, encoding: URLEncoding.default) }
    }

    /// convenience: POST Request
    public static var post: Convert {
        return { self.init(convert: $0(), method: .post, encoding: JSONEncoding.default) }
    }
}

// MARK: - Convertible
///// Convertible
public protocol Convertible: URLRequestConvert, Sendable, AnyObject {}

// MARK: - ConvertibleData
/// ConvertibleData
public protocol ConvertibleData: Convertible, Sendable, AnyObject {

    ///  `URLConvert` value to be used as the `URLRequest`'s `URL`.
    var convert: any URLConvert { get set }

    ///  method: `Method` for the `URLRequest`.
    var method: Method { get set }

    /// encoding: `ParameterEncoder` to be used to encode the `parameters` value into the `URLRequest`, `URLEncoding.default` by default.
    var encoding: any ParameterEncoding { get set }

    /// parameters: `Encodable` value to be encoded into the `URLRequest`. `nil` by default.
    var parameters: Parameters? { get set }

    /// headers: `Headers` value to be added to the `URLRequest`. `nil` by default.
    var headers: Headers? { get set }

    /// requestModifier: `RequestModifier` which will be applied to the `URLRequest` created from
    var requestModifier: RequestModifier? { get set }

}

// MARK: - ConvertibleData: URLRequestConvert
extension ConvertibleData {
    public func urlRequestConvert() throws -> URLRequest {
        var request = try URLRequest(url: convert, method: method, headers: headers)
        try requestModifier?(&request)
        return try encoding.encode(request, with: parameters)
    }
}

// MARK: - ConvertibleData Extension
extension ConvertibleData {

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
}

// MARK: - ConvertibleModel
/// ConvertibleModel
public protocol ConvertibleModel: ConvertibleData, Sendable, AnyObject {
    associatedtype Model: Codable

    /// decoder: `JSONDecoder`, Model JSON parsing format
    var decoder: JSONDecoder { get set }

    /// model: `Model` Convert to model data
    var model: Model.Type { get }
}

// MARK: - ConvertibleModel Extension
/// ConvertibleModel
extension ConvertibleModel {

    /// Update model
    /// - Parameter decoder: decoder
    /// - Returns: the current calling object
    @discardableResult
    public func decoder(_ decoder: JSONDecoder) -> Self {
        self.decoder = decoder
        return self
    }
}

// MARK: - RequestConvertible
/// RequestConvertible
public class RequestConvertible: ConvertibleData, ConvertibleConvenience, @unchecked Sendable {
    
    ///  `URLConvert` value to be used as the `URLRequest`'s `URL`.
    public var convert: any URLConvert

    ///  method: `Method` for the `URLRequest`.
    public var method: Method

    /// encoding: `ParameterEncoder` to be used to encode the `parameters` value into the `URLRequest`
    public var encoding: any ParameterEncoding

    /// parameters: `Encodable` value to be encoded into the `URLRequest`. `nil` by default.
    public var parameters: Parameters?

    /// headers: `Headers` value to be added to the `URLRequest`. `nil` by default.
    public var headers: Headers?

    /// requestModifier: `RequestModifier` which will be applied to the `URLRequest` created from
    public var requestModifier: RequestModifier?

    /// decoder: `JSONDecoder`, Model JSON parsing format
    public var decoder: JSONDecoder = JSONDecoder.sk.decoder


    /// Creates a `Request` from a `URLRequest` created using the passed components, `Encodable` parameters
    /// - Parameters:
    ///   - convert:            `URLConvert` value to be used as the `URLRequest`'s `URL`.
    ///   - method:             `Method` for the `URLRequest`. `.get` by default.
    ///   - encoding:           `ParameterEncoder` to be used to encode the `parameters` value into the `URLRequest`
    ///   - parameters:         `Encodable` value to be encoded into the `URLRequest`. `nil` by default.
    ///   - headers:            `Headers` value to be added to the `URLRequest`. `nil` by default.
    ///   - requestModifier:    `RequestModifier` which will be applied to the `URLRequest` created from
    ///   - decoder:            `JSONDecoder`, Model JSON parsing format
    public init(convert: any URLConvert, method: Method, encoding: any ParameterEncoding, parameters: Parameters? = nil, headers: Headers? = nil, requestModifier: RequestModifier? = nil) {
        self.convert = convert
        self.method = method
        self.encoding = encoding
        self.parameters = parameters
        self.headers = headers
        self.requestModifier = requestModifier
    }

    /// convenience, init.RequestConvertible
    /// - Parameters:
    ///   - convert:    `URLConvert` value to be used as the `URLRequest`'s `URL`.
    ///   - method:     `Method` for the `URLRequest`. `.get` by default.
    ///   - encoding:   `ParameterEncoder` to be used to encode the `parameters` value into the `URLRequest
    public required convenience init(convert: any URLConvert, method: Method, encoding: any ParameterEncoding) {
        self.init(convert: convert, method: method, encoding: encoding, parameters: nil, headers: nil, requestModifier: nil)
    }
}

// MARK: - RequestConvertibleModel
public class RequestConvertibleModel<Item: Codable>: ConvertibleModel, ConvertibleConvenience, @unchecked Sendable {

    /// Model `Convert` to model data
    public typealias Model = Item

    ///  `URLConvert` value to be used as the `URLRequest`'s `URL`.
    public var convert: any URLConvert

    ///  method: `Method` for the `URLRequest`.
    public var method: Method

    /// encoding: `ParameterEncoder` to be used to encode the `parameters` value into the `URLRequest`
    public var encoding: any ParameterEncoding

    /// parameters: `Encodable` value to be encoded into the `URLRequest`. `nil` by default.
    public var parameters: Parameters?

    /// headers: `Headers` value to be added to the `URLRequest`. `nil` by default.
    public var headers: Headers?

    /// requestModifier: `RequestModifier` which will be applied to the `URLRequest` created from
    public var requestModifier: RequestModifier?

    /// decoder: `JSONDecoder`, Model JSON parsing format
    public var decoder: JSONDecoder = JSONDecoder.sk.decoder

    /// model: `Model` Convert to model data
    public var model: Item.Type {
        Item.self
    }

    /// Creates a `Request` from a `URLRequest` created using the passed components, `Encodable` parameters
    /// - Parameters:
    ///   - convert:            `URLConvert` value to be used as the `URLRequest`'s `URL`.
    ///   - method:             `Method` for the `URLRequest`. `.get` by default.
    ///   - encoding:           `ParameterEncoder` to be used to encode the `parameters` value into the `URLRequest`
    ///   - parameters:         `Encodable` value to be encoded into the `URLRequest`. `nil` by default.
    ///   - headers:            `Headers` value to be added to the `URLRequest`. `nil` by default.
    ///   - requestModifier:    `RequestModifier` which will be applied to the `URLRequest` created from
    ///   - model:              `Model` Convert to model data
    ///   - decoder:            `JSONDecoder`, Model JSON parsing format
    public init(convert: any URLConvert, method: Method, encoding: any ParameterEncoding, parameters: Parameters? = nil, headers: Headers? = nil, requestModifier: RequestModifier? = nil, decoder: JSONDecoder = JSONDecoder.sk.decoder) {
        self.convert = convert
        self.method = method
        self.encoding = encoding
        self.parameters = parameters
        self.headers = headers
        self.requestModifier = requestModifier
        self.decoder = decoder
    }

    /// convenience, init.RequestConvertibleModel<Model>
    /// - Parameters:
    ///   - convert:    `URLConvert` value to be used as the `URLRequest`'s `URL`.
    ///   - method:     `Method` for the `URLRequest`. `.get` by default.
    ///   - encoding:   `ParameterEncoder` to be used to encode the `parameters` value into the `URLRequest
    public required convenience init(convert: any URLConvert, method: Method, encoding: any ParameterEncoding) {
        self.init(convert: convert, method: method, encoding: encoding, parameters: nil, headers: nil, requestModifier: nil, decoder: JSONDecoder.sk.decoder)
    }

}

// MARK: -
