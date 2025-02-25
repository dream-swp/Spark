//
//  Spark+Error.swift
//  Spark
//
//  Created by Dream on 2025/2/25.
//

import Foundation

// MARK: - Spark.Error
public extension Spark {
    
    /// `Error` is the error type returned by Spark.
    enum Error: Swift.Error {
        /// Request URL Error
        case urlError
        
        /// Invalid response to the request.
        case invalidResponse
        
        /// Request Parameters Encoding Failed
        case parameterEncodingFailed(reason: ParameterEncodingFailureReason)
    }
}

// MARK: - Spark.Error: Sendable
extension Spark.Error: Sendable { }

// MARK: - Spark.Error: LocalizedError
extension Spark.Error: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .urlError:
            return "Request URL Error"
        case .invalidResponse:
            return "Invalid response to the request."
        case .parameterEncodingFailed(let error):
            return error.localizedDescription

        }
    }
}

// MARK: - Spark.Error.ParameterEncodingFailureReason
public extension Spark.Error {
    
    /// The underlying reason the `.parameterEncodingFailed` error occurred.
    enum ParameterEncodingFailureReason: Sendable {
        /// The `URLRequest` did not have a `URL` to encode.
        case missingURL
        /// JSON serialization failed with an underlying system error during the encoding process.
        case jsonEncodingFailed(error: any Error)
        /// Custom parameter encoding failed due to the associated `Error`.
        case customEncodingFailed(error: any Error)
    }
}

// MARK: - Spark.Error.ParameterEncodingFailureReason: LocalizedError
extension Spark.Error.ParameterEncodingFailureReason: LocalizedError {
    
    var localizedDescription: String {
        switch self {
        case .missingURL:
            return "URL request to encode was missing a URL"
        case let .jsonEncodingFailed(error):
            return "JSON could not be encoded because of error:\n\(error.localizedDescription)"
        case let .customEncodingFailed(error):
            return "Custom parameter encoder failed with error: \(error.localizedDescription)"
        }
    }
}

// MARK: - Spark.Error.JSONEncodingError
public extension Spark.Error {
    enum JSONEncodingError {
        case invalidJSONObject
    }
}

// MARK: - Spark.Error.JSONEncodingError: LocalizedError
extension Spark.Error.JSONEncodingError: LocalizedError {
    var localizedDescription: String {
       """
       Invalid JSON object provided for parameter or object encoding. \
       This is most likely due to a value which can't be represented in Objective-C.
       """
   }
}
// MARK: -
