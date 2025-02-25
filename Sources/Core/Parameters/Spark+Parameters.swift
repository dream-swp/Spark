//
//  Spark+Parameters.swift
//  Spark
//
//  Created by Dream on 2025/2/22.
//


import Foundation

// MARK: - Spark.Parameters, ParameterEncoding
public extension Spark {
    
    /// Request Parameters
    typealias Parameters = [String: any Any & Sendable]
    
    /// Request parameter coding protocol
    protocol ParameterEncoding: Sendable {
        
        /// - Parameters:
        ///   - urlRequest: Coding `URLRequest`
        ///   - parameters: Coding `Parameters`, `Parameters = [String: Any]`
        /// - Returns: The encoding completed URLRequest
        func encode(_ urlRequest: URLRequest, with parameters: Parameters?) throws -> URLRequest
        
    }
}
// MARK: -
