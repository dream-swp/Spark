//
//  Spark+URLEncodeing.swift
//  Spark
//
//  Created by Dream on 2025/2/22.
//

import Foundation


// MARK: - Spark.URLEncodeing
public extension Spark {
    
    struct URLEncodeing {
        
    }
}

extension Spark.URLEncodeing: Spark.ParameterEncoding {
    
    public func encode(_ urlRequest: URLRequest, with parameters: Spark.Parameters?) throws -> URLRequest {
        urlRequest
    }

}
// MARK: -
