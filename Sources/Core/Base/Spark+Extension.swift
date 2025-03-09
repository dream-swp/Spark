//
//  Spark+Extension.swift
//  Spark
//
//  Created by Dream on 2025/3/7.
//

import Combine

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
