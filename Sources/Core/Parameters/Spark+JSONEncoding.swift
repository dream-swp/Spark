//
//  Spark.JSONEncoding.swift
//  Spark
//
//  Created by Dream on 2025/2/22.
//

import Foundation

// MARK: - Spark.JSONEncoding
public extension Spark {
    
    struct JSONEncoding {
        
        /// Returns a `Spark.JSONEncoding` instance with default writing options.
        public static var `default`: Spark.JSONEncoding { Spark.JSONEncoding() }
        
        /// Returns a `JSONEncoding` instance with `.prettyPrinted` writing options.
        public static var prettyPrinted: Spark.JSONEncoding { Spark.JSONEncoding(options: .prettyPrinted) }
        
        /// The options for writing the parameters as JSON data.
        public let options: JSONSerialization.WritingOptions
        
        /// Creates an instance using the specified `WritingOptions`.
        /// - Parameter options: `JSONSerialization.WritingOptions` to use.
        public init(options: JSONSerialization.WritingOptions = []) {
            self.options = options
        }
        
        
    }
}
// MARK: - Encoding
extension Spark.JSONEncoding: Spark.ParameterEncoding {
    
    
    public func encode(_ urlRequest: URLRequest, with parameters: Spark.Parameters?) throws -> URLRequest {
        return urlRequest
    }
    
    public func encode(_ urlRequest: URLRequest,  with jsonObject: Any? = nil) throws -> URLRequest {
         
        guard let jsonObject = jsonObject else { return urlRequest }
        
        guard JSONSerialization.isValidJSONObject(jsonObject) else {
            throw Spark.Error.parameterEncodingFailed(reason: .jsonEncodingFailed(error: Spark.Error.JSONEncodingError.invalidJSONObject))
        }
        
        // TODO: - MARK: - 
        return urlRequest
    }
    
    
}
// MARK: -

