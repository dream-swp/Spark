//
//  Spark+Extension.swift
//  Spark
//
//  Created by Dream on 2025/3/7.
//

import Combine
import Foundation


// MARK: - SK.Spark
extension SK where SK == Spark {
    
    public typealias JSONData = (_ jsonObject: () -> Any) -> Data?
    
    /// Used to validate Can be converted to JSON data
    /// - Top level object is an NSArray or NSDictionary
    /// - All objects are NSString, NSNumber, NSArray, NSDictionary, or NSNull
    /// - All dictionary keys are NSStrings
    /// - NSNumbers are not NaN or infinity
    /// - Parameter jsonObject: validate parameters
    /// - Returns: throws Invalid JSON object provided for parameter or object encoding. \
    /// This is most likely due to a value which can't be represented in Objective-C.
    func isValidJSONObject(_ jsonObject: Any) throws {
        guard JSONSerialization.isValidJSONObject(jsonObject) else {
            throw Error.parameterEncodingFailed(reason: .jsonEncodingFailed(error: Error.JSONEncodingError.invalidJSONObject))
        }
    }
    
    ///  Returns JSON data from a Foundation object.
    /// - Parameters:
    ///   - jsonObject: The object from which to generate JSON data. Must not be nil.
    ///   - opt: Options for creating the JSON data.
    /// - Returns: JSON data for obj, or nil if an internal error occurs. The resulting data is encoded in UTF-8.
    func jsonData(_ jsonObject: Any, options opt: JSONSerialization.WritingOptions = []) throws -> Data {
        try isValidJSONObject(jsonObject)
        return try JSONSerialization.data(withJSONObject: jsonObject, options: opt)
    }
    
    ///  Returns JSON data from a Foundation object.
    var jsonData: JSONData {
        return {
            guard let data  = try? jsonData($0(), options: []) else {
                return nil
            }
            return data
        }
    }
}

// MARK: - Token
/// Combine Token
public class Token {

    /// AnyCancellable
    fileprivate var cancellable: AnyCancellable? = nil

    /// Remove token
    public func unseal() { cancellable = nil }

    /// `Token` Initialization method
    public init(cancellable: AnyCancellable? = nil) {
        self.cancellable = cancellable
    }
}

extension SK where SK: AnyCancellable {

    /// Add token
    /// - Parameter token: token
    public func seal(_ token: Token) {
        token.cancellable = sk
    }
}

// MARK: - JSONDecoder Extension
extension SK where SK == JSONDecoder {

    /// JSON Decoder
    public static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}

// MARK: - JSONEncoder Extension
extension SK where SK == JSONEncoder {

    /// JSON Encoder
    public static var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }
}

// MARK: - Data Extension
extension SK where SK == Data {

    public typealias SparkJSONOptions = (_ options: () -> JSONSerialization.ReadingOptions) -> Any?
    
    /// Data Convert to String
    public var string: String {
        String(data: sk, encoding: .utf8) ?? ""
    }

    /// Data Convert to String
    /// - Parameter encoding: String.Encoding
    /// - Returns: String
    public func string(_ encoding: String.Encoding) -> String {
        String(data: sk, encoding: encoding) ?? ""
    }

    ///
    public var jsonObjectOptions: SparkJSONOptions {
        { try? JSONSerialization.jsonObject(with: sk, options: $0()) }
    }

    ///
    public var jsonObject: Any? { jsonObjectOptions { .fragmentsAllowed } }

}
// MARK: -
