//
//  Spark+Extension.swift
//  Spark
//
//  Created by Dream on 2025/3/7.
//

import Combine
import Foundation

extension Spark {

    public class Token {

        /// AnyCancellable
        fileprivate var cancellable: AnyCancellable? = nil

        /// Remove token
        public func unseal() { cancellable = nil }

        public init(cancellable: AnyCancellable? = nil) {
            self.cancellable = cancellable
        }
    }

}

extension SK where SK: AnyCancellable {

    public func seal(_ token: Spark.Token) {
        token.cancellable = sk
    }
}

extension SK where SK == JSONDecoder {

    /// JSON Decoder
    public static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}

extension SK where SK == JSONEncoder {

    /// JSON Encoder
    public static var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }
}

