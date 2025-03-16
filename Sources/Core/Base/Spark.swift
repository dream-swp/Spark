//
//  swift
//  Spark
//
//  Created by Dream on 2025/2/22.
//

import Combine
import Foundation




// Request Modifier
public typealias RequestModifier = @Sendable (inout URLRequest) throws -> Void
// Response Data
public typealias ResponseData = AnyPublisher<Data, Swift.Error>
// Response Model
public typealias ResponseModel<Model> = AnyPublisher<Model, Swift.Error> where Model: Codable

// MARK: - Request Network Components
public struct Spark: @unchecked Sendable {

    public static let `default` = Spark()

    private init() {}

}

// MARK: - Spark Get Request
extension Spark {

    /// Creates a `Get Request` Convenient Method
    /// - Parameters:
    ///   - convert:            `URLConvert` value to be used as the `URLRequest`'s `URL`.
    ///   - encoding:           `ParameterEncoder` to be used to encode the `parameters` value into the `URLRequest`,
    ///                         `URLEncoding.default` by default.
    ///   - parameters:         `Encodable` value to be encoded into the `URLRequest`. `nil` by default.
    ///   - headers:            `Headers` value to be added to the `URLRequest`. `nil` by default.
    /// - Returns:              `ResponseData` Return request data
    public func get(_ convert: any URLConvert, encoding: ParameterEncoding = URLEncoding.default, parameters: Parameters? = nil, headers: Headers? = nil) -> ResponseData {
        request(convert, method: .get, encoding: encoding, parameters: parameters, headers: headers, requestModifier: nil)
    }
    
    /// Creates a `Request` from a `URLRequest` created using the passed components, `Convertible` parameters
    /// - Parameter config:     `Convertible` Request parameter configuration
    /// - Returns:              `ResponseData` Return request data
    public func get<Request: Convertible>(in config: Request) -> ResponseData {
        request(in: config.method(.get).requestModifier(nil))
    }
    
    /// Creates a `Get Request` Convenient Method
    /// - Parameters:
    ///   - convert:            `URLConvert` value to be used as the `URLRequest`'s `URL`.
    ///   - encoding:           `ParameterEncoder` to be used to encode the `parameters` value into the `URLRequest`,
    ///                         `URLEncoding.default` by default.
    ///   - parameters:         `Encodable` value to be encoded into the `URLRequest`. `nil` by default.
    ///   - headers:            `Headers` value to be added to the `URLRequest`. `nil` by default.
    ///   - model:              `Model` Convert to model data
    ///   - decoder:            `JSONDecoder`, Model JSON parsing format
    /// - Returns:              `ResponseModel` Return request data `ResponseModel<Model>`
    public func get<Item>(_ convert: any URLConvert, encoding: ParameterEncoding = URLEncoding.default, parameters: Parameters? = nil, headers: Headers? = nil, model: Item.Type, decoder: JSONDecoder = JSONDecoder.sk.decoder) -> ResponseModel<Item> {
        request(convert, method: .get, encoding: encoding, parameters: parameters, headers: headers, requestModifier: nil, model: model, decoder: decoder)
    }
            
    
    /// Creates a `Get Request` Convenient Method
    /// - Parameter config: `Convertible` Request parameter configuration
    /// - Returns:          `ResponseModel` Return request data `ResponseModel<Model>`
    public func get<Request: Convertible>(at config: Request) -> ResponseModel<Request.Model> {
        request(at:  config.method(.get).requestModifier(nil))
    }
    
}

// MARK: - Spark POST Request
extension Spark {

    // TODO: - POST Request
//    public func post(convert: any URLConvert, method: Method = .post, encoding: ParameterEncoding = JSONEncoding.default, parameters: Parameters? = nil, headers: Headers? = nil, requestModifier: RequestModifier? = nil) -> ResponseData {
//        request(convert: convert, method: method, encoding: encoding, parameters: parameters, headers: headers, requestModifier: requestModifier)
//    }
//
//    var post: ResponseData {
//        return {
//            var post: RequestConvert = .get { "" }
//            post = $0(post)
//            return self.request(post)
//        }
//    }

}

// MARK: - Spark Request
extension Spark {
    
    /// Creates a `Request` from a `URLRequest` created using the passed components, `Encodable` parameters
    /// - Parameters:
    ///   - convert:            `URLConvert` value to be used as the `URLRequest`'s `URL`.
    ///   - method:             `Method` for the `URLRequest`. `.get` by default.
    ///   - encoding:           `ParameterEncoder` to be used to encode the `parameters` value into the `URLRequest`,
    ///                         `URLEncoding.default` by default.
    ///   - parameters:         `Encodable` value to be encoded into the `URLRequest`. `nil` by default.
    ///   - headers:            `Headers` value to be added to the `URLRequest`. `nil` by default.
    ///   - requestModifier:    `RequestModifier` which will be applied to the `URLRequest` created from
    ///   - model:              `Model` Convert to model data
    ///   - decoder:            `JSONDecoder`, Model JSON parsing format
    /// - Returns:              `ResponseData` Return request data
    public func request<Item>(_ convert: any URLConvert, method: Method, encoding: ParameterEncoding, parameters: Parameters? = nil, headers: Headers? = nil, requestModifier: RequestModifier? = nil, model: Item.Type, decoder: JSONDecoder = JSONDecoder.sk.decoder) -> ResponseModel<Item> {
        let convertible: RequestConvertibleModel<Item> = .init(convert: convert, method: method, encoding: encoding, parameters: parameters, headers: headers, requestModifier: requestModifier, decoder: decoder)
        return request(at: convertible)
    }
    
    
    /// Creates a `Request` from a `URLRequest` created using the passed components, `Convertible` parameters
    /// - Parameter config:     `Convertible` Request parameter configuration
    /// - Returns:              `ResponseModel` Return request data `ResponseModel<Model>`
    public func request<Request: Convertible>(at config: Request) -> ResponseModel<Request.Model> {
        return self.request(config)
            .decode(type: config.model, decoder: config.decoder)
            .eraseToAnyPublisher()
    }
    
    
    /// Creates a `Request` from a `URLRequest` created using the passed components, `Encodable` parameters
    /// - Parameters:
    ///   - convert:            `URLConvert` value to be used as the `URLRequest`'s `URL`.
    ///   - method:             `Method` for the `URLRequest`. `.get` by default.
    ///   - encoding:           `ParameterEncoder` to be used to encode the `parameters` value into the `URLRequest`,
    ///                         `URLEncoding.default` by default.
    ///   - parameters:         `Encodable` value to be encoded into the `URLRequest`. `nil` by default.
    ///   - headers:            `Headers` value to be added to the `URLRequest`. `nil` by default.
    ///   - requestModifier:    `RequestModifier` which will be applied to the `URLRequest` created from
    /// - Returns:              `ResponseData` Return request data
    public func request(_ convert: any URLConvert, method: Method, encoding: ParameterEncoding, parameters: Parameters? = nil, headers: Headers? = nil, requestModifier: RequestModifier? = nil) -> ResponseData {
        let convertible: RequestConvertible = .init(convert: convert, method: method, encoding: encoding, parameters: parameters, headers: headers, requestModifier: requestModifier)
        return request(in: convertible)
    }
    
    
    /// Creates a `Request` from a `URLRequest` created using the passed components, `Convertible` parameters
    /// - Parameter config:      `Convertible` Request parameter configuration
    /// - Returns:              `ResponseData` Return request data
    public func request<Request: Convertible>(in config: Request) -> ResponseData {
        self.request(config)
    }
    
}

extension Spark {
    
    internal func request<Request: Convertible>(_ request: Request) -> ResponseData {
        
        guard let urlRequest = request.urlRequest else {
            return Fail(error: Error.urlError).eraseToAnyPublisher()
        }
        
        return URLSession
            .shared
            .dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    if let log = String(data: data, encoding: .utf8) {
                        debugPrint(log)
                    }
                    throw Error.invalidResponse
                }
                return data
            }
            .eraseToAnyPublisher()
    }
    
}
// MARK: -
