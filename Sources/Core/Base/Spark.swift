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
                 method: Spark.Method,
                 parameters: Spark.Parameters? = nil,
                 encoding: Spark.ParameterEncoding = JSONEncoding.default,
                 headers: Spark.Headers? = nil,
                 requestModifier: Spark.RequestModifier? = nil) -> AnyPublisher<Data, Swift.Error> {
        
        guard let request = try? convert(url, method: method, parameters: parameters, encoding: encoding, requestModifier: requestModifier).skURLRequest() else {
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
                                         parameters: parameters,
                                         encoding: encoding,
                                         headers: headers,
                                         requestModifier: requestModifier)
    }
}



