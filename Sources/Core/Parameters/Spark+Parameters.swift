//
//  Spark+Parameters.swift
//  Spark
//
//  Created by Dream on 2025/2/22.
//

import Foundation

// MARK: - Spark.Parameters, ParameterEncoding
extension Spark {

    public typealias Parameters = [String: any Any & Sendable]

    /// Request parameter coding protocol
    public protocol ParameterEncoding: Sendable {

        /// - Parameters:
        ///   - urlRequest: `URLRequest` value onto which parameters will be encoded.
        ///   - parameters: `Parameters` to encode onto the request.
        /// - Returns: The encoding completed URLRequest
        func encode(_ urlRequest: any URLRequestConvert, with parameters: Parameters?) throws -> URLRequest
    }

}
// MARK: -
