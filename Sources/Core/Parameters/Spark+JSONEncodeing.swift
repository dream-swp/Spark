//
//  Spark+JSONEncodeing.swift
//  Spark
//
//  Created by Dream on 2025/2/22.
//

import Foundation


public extension Spark {
     struct JSONEncodeing {
        
    }
}

extension Spark.JSONEncodeing: Spark.ParameterEncoding {
    public func encode(_ urlRequest: URLRequest, with parameters: Spark.Parameters?) throws -> URLRequest {
        urlRequest
    }
}

