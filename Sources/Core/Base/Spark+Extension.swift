//
//  Spark+Extension.swift
//  Spark
//
//  Created by Dream on 2025/3/7.
//

import Combine
import Foundation

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
    
    public var jsonObject: Any? {
        try? JSONSerialization.jsonObject(with: sk, options: .allowFragments)
    }
    
//    func JSONObject() throws -> Any {
//        try JSONSerialization.jsonObject(with: sk, options: .allowFragments)
//    }

}
// MARK: -
