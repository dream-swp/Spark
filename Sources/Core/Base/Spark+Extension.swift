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


public extension SK where SK: AnyCancellable {
    
    func seal(_ token: Spark.Token) -> Void {
        token.cancellable = sk
    }
}

public extension SK where SK == JSONDecoder {
    
    /// JSON Decoder
    static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}

public extension SK where SK == JSONEncoder {
    
    /// JSON Encoder
    static var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }
}
