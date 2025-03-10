//
//  Spark.swift
//  Spark
//
//  Created by Dream on 2025/2/22.
//

import Foundation
import Combine

// MARK: - Request Network Components
public struct Spark : @unchecked Sendable {
    
    /// `Request Modifier`
    public typealias RequestModifier = @Sendable (inout URLRequest) throws -> Void
    
    public static let `default` = Spark()
    
    private init() { }

}

// Get
public extension Spark {
    
    func get(url: any URLConvert,
             method: Spark.Method = .get,
             encoding: Spark.ParameterEncoding = URLEncoding.default,
             parameters: Spark.Parameters? = nil,
             headers: Spark.Headers? = nil,
             requestModifier: Spark.RequestModifier? = nil) -> AnyPublisher<Data, Swift.Error> {
          request(url: url, method: .get, encoding: encoding, parameters: parameters, headers: headers, requestModifier: requestModifier)
    }
    
    func get(_ request : Spark.Request) -> AnyPublisher<Data, Swift.Error> {
        self.request(request)
    }
    
    func get<Model>(url: any URLConvert,
             method: Spark.Method = .get,
             encoding: Spark.ParameterEncoding = URLEncoding.default,
             parameters: Spark.Parameters? = nil,
             headers: Spark.Headers? = nil,
             requestModifier: Spark.RequestModifier? = nil,
             model: Model.Type) -> AnyPublisher<Model, Swift.Error> where Model: Codable {
          request(url: url, method: .get, encoding: encoding, parameters: parameters, headers: headers, requestModifier: requestModifier)
            .decode(type: model, decoder: JSONDecoder.sk.decoder)
            .eraseToAnyPublisher()
    }
    
    func get<Model>(_ request : Spark.Request , model: Model.Type) -> AnyPublisher<Model, Swift.Error> where Model: Codable {
        self.request(request)
            .decode(type: model, decoder: JSONDecoder.sk.decoder)
            .eraseToAnyPublisher()
    }
}

public extension Spark {
    
    func request<Model>(url: any URLConvert,
                       method: Spark.Method,
                       encoding: Spark.ParameterEncoding,
                       parameters: Spark.Parameters? = nil,
                       headers: Spark.Headers? = nil,
                       requestModifier: Spark.RequestModifier? = nil,
                       model: Model.Type) -> AnyPublisher<Model, Swift.Error> where Model: Codable {
        return request(url: url, method: method, encoding: encoding, parameters: parameters, headers: headers, requestModifier: requestModifier)
            .decode(type: model, decoder: JSONDecoder.sk.decoder)
            .eraseToAnyPublisher()
    }
    
    func request<Model>(_ request : Spark.Request, model: Model.Type) -> AnyPublisher<Model, Swift.Error> where Model: Codable {
        return self.request(request).decode(type: model, decoder: JSONDecoder.sk.decoder).eraseToAnyPublisher()
    }
}

public extension Spark {
    
    func request(url: any URLConvert,
                 method: Spark.Method,
                 encoding: Spark.ParameterEncoding,
                 parameters: Spark.Parameters? = nil,
                 headers: Spark.Headers? = nil,
                 requestModifier: Spark.RequestModifier? = nil) -> AnyPublisher<Data, Swift.Error> {
        
        let convert: Request =
            .init(url: url)
            .method(method)
            .encoding(encoding)
            .parameters(parameters)
            .headers(headers)
            .requestModifier(requestModifier)
        return request(convert)
    }
    
    func request(_ request: Spark.Request) -> AnyPublisher<Data, Swift.Error> {
        
        guard let urlRequest = request.urlRequest else {
            return Fail(error: Spark.Error.urlError).eraseToAnyPublisher()
        }
        
        return URLSession
            .shared
            .dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    if let log = String(data: data, encoding: .utf8) {
                        debugPrint(log)
                    }
                    throw Spark.Error.invalidResponse
                }
                return data
            }
            .eraseToAnyPublisher()
    }
}
