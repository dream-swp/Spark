//
//  swift
//  Spark
//
//  Created by Dream on 2025/2/22.
//

import Combine
import Foundation

/// `Request Modifier`
public typealias RequestModifier = @Sendable (inout URLRequest) throws -> Void
public typealias ResponseData = AnyPublisher<Data, Swift.Error>
public typealias ResponseModel<Model> = AnyPublisher<Model, Swift.Error> where Model: Codable

// MARK: - Request Network Components
public struct Spark: @unchecked Sendable {

    public static let `default` = Spark()

    private init() {}

}

// MARK: - Spark Get Request
extension Spark {

    /// Creates a `Get Request` from a `URLRequest` created using the passed components, `Encodable` parameters
    /// - Parameters:
    ///   - convert:            `URLConvert` value to be used as the `URLRequest`'s `URL`.
    ///   - encoding:           `ParameterEncoder` to be used to encode the `parameters` value into the `URLRequest`,
    ///                         `URLEncodedFormParameterEncoder.default` by default.
    ///   - parameters:         `Encodable` value to be encoded into the `URLRequest`. `nil` by default.
    ///   - headers:            `Headers` value to be added to the `URLRequest`. `nil` by default.
    ///   - requestModifier:    `RequestModifier` which will be applied to the `URLRequest` created from
    /// - Returns:              The created `ResponseData`
    public func get(convert: any URLConvert, encoding: ParameterEncoding = URLEncoding.default, parameters: Parameters? = nil, headers: Headers? = nil) -> ResponseData {
        request(convert: convert, method: .get, encoding: encoding, parameters: parameters, headers: headers, requestModifier: nil)
    }

    /// Creates a `Get Request` from a `URLRequest` created using the passed components, `RequestConvert` parameters
    /// - Parameter convert: `RequestConvert`
    /// - Returns:  The created `ResponseData`
    public func get(_ convert: RequestConvert) -> ResponseData {
        return self.request(convert)
    }


    /// Creates a `Get Request` from a `URLRequest` created using the passed components, `Encodable` parameters
    /// - Parameters:
    ///   - convert:            `URLConvert` value to be used as the `URLRequest`'s `URL`.
    ///   - method:             `Method` for the `URLRequest`. `.get` by default.
    ///   - encoding:           `ParameterEncoder` to be used to encode the `parameters` value into the `URLRequest`,
    ///                         `URLEncoding.default` by default.
    ///   - parameters:         `Encodable` value to be encoded into the `URLRequest`. `nil` by default.
    ///   - headers:            `Headers` value to be added to the `URLRequest`. `nil` by default.
    ///   - requestModifier:    `RequestModifier` which will be applied to the `URLRequest` created from
    ///                         the provided parameters. `nil` by default.
    ///   - model:              Convert to model data
    /// - Returns:              The created `AnyPublisher<Model, Swift.Error>`
    public func get<Model>(convert: any URLConvert, encoding: ParameterEncoding = URLEncoding.default, parameters: Parameters? = nil, headers: Headers? = nil, requestModifier: RequestModifier? = nil, model: Model.Type) -> ResponseModel<Model>{
        request(convert: convert, method: .get, encoding: encoding, parameters: parameters, headers: headers, requestModifier: requestModifier)
            .decode(type: model, decoder: JSONDecoder.sk.decoder)
            .eraseToAnyPublisher()
    }

    /// Creates a `Get Request` from a `URLRequest` created using the passed components, `Encodable` parameters
    /// - Parameters:
    ///   - convert:    `RequestConvert`
    ///   - model:      Convert to model data
    /// - Returns:      The created `AnyPublisher<Model, Swift.Error>`
    public func get<Model>(_ convert: RequestConvert<Model>, model: Model.Type) -> ResponseModel<Model>{
        self.request(convert)
            .decode(type: model, decoder: JSONDecoder.sk.decoder)
            .eraseToAnyPublisher()
    }
}

// MARK: - Spark POST Request
extension Spark {

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
    ///                         the provided parameters. `nil` by default.
    ///   - model:              Convert to model data
    /// - Returns:
    public func request<Model>(convert: any URLConvert, method: Method, encoding: ParameterEncoding, parameters: Parameters? = nil, headers: Headers? = nil, requestModifier: RequestModifier? = nil, model: Model.Type, decoder: JSONDecoder = JSONDecoder.sk.decoder) -> ResponseModel<Model> {
        return request(convert: convert, method: method, encoding: encoding, parameters: parameters, headers: headers, requestModifier: requestModifier)
            .decode(type: model, decoder: decoder)
            .eraseToAnyPublisher()
    }

    /// Creates a `Request` from a `URLRequest` created using the passed components, `Encodable` parameters
    /// - Parameters:
    ///   - convert:    `RequestConvert`
    ///   - model:      Convert to model data
    /// - Returns:      The created `ResponseData`
    public func request<Model>(_ convert: RequestConvert<Model>, model: Model.Type) -> ResponseModel<Model> {
        
        return self.request(convert).decode(type: model, decoder: convert.decoder).eraseToAnyPublisher()
    }

    /// Creates a `Request` from a `URLRequest` created using the passed components, `Encodable` parameters
    /// - Parameters:
    ///   - convert:            `URLConvert` value to be used as the `URLRequest`'s `URL`.
    ///   - method:             `Method` for the `URLRequest`. `.get` by default.
    ///   - encoding:           `ParameterEncoder` to be used to encode the `parameters` value into the `URLRequest`,
    ///                         `URLEncodedFormParameterEncoder.default` by default.
    ///   - parameters:         `Encodable` value to be encoded into the `URLRequest`. `nil` by default.
    ///   - headers:            `Headers` value to be added to the `URLRequest`. `nil` by default.
    ///   - requestModifier:    `RequestModifier` which will be applied to the `URLRequest` created from
    ///                         the provided parameters. `nil` by default.
    /// - Returns:              The created `ResponseData`.
    public func request(convert: any URLConvert, method: Method, encoding: ParameterEncoding, parameters: Parameters? = nil, headers: Headers? = nil, requestModifier: RequestModifier? = nil) -> ResponseData {

        let convert: RequestConvert<Data> = .init(convert: convert).method(method).encoding(encoding).parameters(parameters).headers(headers).requestModifier(requestModifier)

        return request(convert)
    }

    /// Creates a `Request` from a `URLRequest` created using the passed components, `Encodable` parameters
    /// - Parameter convert:    `RequestConvert`
    /// - Returns:              The created `ResponseData`.
    public func request<Model>(_ convert: RequestConvert<Model>) -> ResponseData {

        guard let urlRequest = convert.urlRequest else {
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
