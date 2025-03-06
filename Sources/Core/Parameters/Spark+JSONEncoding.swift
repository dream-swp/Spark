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
    
    /// URLRequest JSON encoding
    /// - Parameters:
    ///   - urlRequest: Coding `URLRequest`
    ///   - parameters: Coding `Parameters`, `Spark.Parameters = [String: Any]`
    /// - Returns: The encoding completed URLRequest
    public func encode(_ urlRequest: any Spark.URLRequestConvert, with parameters: Spark.Parameters? = nil) throws -> URLRequest {
        return try encode(urlRequest, jsonObject: parameters)
    }
    
    
    /// URLRequest JSON encoding
    /// - Parameters:
    ///   - urlRequest: Coding `URLRequest`
    ///   - jsonObject: Coding `jsonObject` = Any
    /// - Returns: The encoding completed URLRequest
    public func encode(_ urlRequest: any Spark.URLRequestConvert, jsonObject: Any? = nil) throws -> URLRequest {
         
        let urlRequest = try urlRequest.skURLRequest()
        
        guard let jsonObject = jsonObject else { return urlRequest }
        
        try isValidJSONObject(jsonObject)
        
        let jsonData = try jsonData(jsonObject, options: options)
        
        let request = requestConfig(urlRequest, jsonData: jsonData)
        
        return request
    }
    
}

internal extension Spark.JSONEncoding {
    
    /// Used to validate Can be converted to JSON data
    /// - Top level object is an NSArray or NSDictionary
    /// - All objects are NSString, NSNumber, NSArray, NSDictionary, or NSNull
    /// - All dictionary keys are NSStrings
    /// - NSNumbers are not NaN or infinity
    /// - Parameter jsonObject: validate parameters
    /// - Returns: throws Invalid JSON object provided for parameter or object encoding. \
    /// This is most likely due to a value which can't be represented in Objective-C.
    func isValidJSONObject(_ jsonObject: Any) throws -> Void {
        guard JSONSerialization.isValidJSONObject(jsonObject) else {
            throw Spark.Error.parameterEncodingFailed(reason: .jsonEncodingFailed(error: Spark.Error.JSONEncodingError.invalidJSONObject))
        }
    }

    ///  Returns JSON data from a Foundation object.
    /// - Parameters:
    ///   - jsonObject: The object from which to generate JSON data. Must not be nil.
    ///   - opt: Options for creating the JSON data.
    /// - Returns: JSON data for obj, or nil if an internal error occurs. The resulting data is encoded in UTF-8.
    func jsonData(_ jsonObject: Any, options opt: JSONSerialization.WritingOptions = []) throws -> Data {
        do {
            return try JSONSerialization.data(withJSONObject: jsonObject, options: opt)
        } catch {
            throw Spark.Error.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
        }
    }
    
    /// URLRequest Config
    /// - Parameters:
    ///   - urlRequest: Coding `URLRequest`
    ///   - jsonData: JSON data.
    /// - Returns: URLRequest
    func requestConfig(_ urlRequest: URLRequest, jsonData: Data) -> URLRequest {
        var request = urlRequest
        
        if request.headers[Spark.Header.Key.ContentType] == nil {
            request.headers.update(.contentType("application/json"))
        }
        request.httpBody = jsonData
        
        return request
    }
}

// MARK: -

