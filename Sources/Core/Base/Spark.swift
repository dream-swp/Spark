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

public extension Spark {
    
    func request(url: any URLConvert,
                 method: Spark.Method = .get,
                 encoding: Spark.ParameterEncoding = URLEncoding.default,
                 parameters: Spark.Parameters? = nil,
                 headers: Spark.Headers? = nil,
                 requestModifier: Spark.RequestModifier? = nil) -> AnyPublisher<Data, Swift.Error> {
        

        let convert: RequestConvert =
            .init(url: url)
            .method(method)
            .encoding(encoding)
            .parameters(parameters)
            .headers(headers)
            .requestModifier(requestModifier)
    
        guard let request = convert.urlRequest else {
            return Fail(error: Spark.Error.urlError).eraseToAnyPublisher()
        }

        return URLSession
            .shared
            .dataTaskPublisher(for: request)
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
    
//    func request(_ request: Spark.Request,
//                 requestModifier: Spark.RequestModifier? = nil) -> AnyPublisher<Data, Swift.Error> {
//        
////        request.requestModifier = requestModifier;
//        guard let urlRequest = try? request.skURLRequest() else {
//            return Fail(error: Spark.Error.urlError).eraseToAnyPublisher()
//
//        }
//        
//        
//        return URLSession
//            .shared
//            .dataTaskPublisher(for: urlRequest)
//            .tryMap { data, response in
//                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                    if let log = String(data: data, encoding: .utf8) {
//                        debugPrint(log)
//                    }
//                    throw Spark.Error.invalidResponse
//                }
//                return data
//            }
//            .eraseToAnyPublisher()
////        let convert = convert(urlRequest, method: request.method, parameters: request.parameters, encoding: request.encoding, requestModifier: requestModifier)
//        
//    }
}

extension Spark {
    
    func convert(_ url: any Spark.URLConvert,
                     method: Spark.Method,
                     parameters: Spark.Parameters?,
                     encoding: Spark.ParameterEncoding,
                     headers: Spark.Headers? = nil,
                     requestModifier: Spark.RequestModifier?) -> RequestConvert {
        
        return Spark.RequestConvert(url: url,
                                    method: method,
                                    encoding: encoding,
                                    parameters: parameters,
                                    headers: headers,
                                    requestModifier: requestModifier)
    }
}
