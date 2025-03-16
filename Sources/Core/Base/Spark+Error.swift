//
//  Spark+Error.swift
//  Spark
//
//  Created by Dream on 2025/2/25.
//

import Foundation

/// `Error` is the error type returned by
public enum Error: Swift.Error {
    /// Request URL Error
    case urlError

    /// Invalid response to the request.
    case invalidResponse

    /// Request Parameters Encoding Failed
    case parameterEncodingFailed(reason: ParameterEncodingFailureReason)

    /// `URLConvertible` type failed to create a valid `URL`.
    case invalidURL(url: any URLConvert)
    
//    case dataConversion
    
}

// MARK: - Error: Public
extension Error {

    /// Returns whether the instance is `.urlError`.
    public var isURLError: Bool {
        if case .urlError = self { return true }
        return false
    }

    /// Returns whether the instance is `.invalidResponse`.
    public var isInvalidResponse: Bool {
        if case .invalidResponse = self { return true }
        return false
    }

    /// Returns whether the instance is `.parameterEncodingFailed`. When `true`, the `underlyingError` property will
    /// contain the associated value.
    public var isParameterEncodingError: Bool {
        if case .parameterEncodingFailed = self { return true }
        return false
    }

    /// Returns whether the instance is `.invalidURL`.
    public var isInvalidURLError: Bool {
        if case .invalidURL = self { return true }
        return false
    }
}

// MARK: - Error: Sendable
extension Error: Sendable {}

// MARK: - Error: LocalizedError
extension Error: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .urlError: "Request URL Error"
        case .invalidResponse: "Invalid response to the request."
        case .parameterEncodingFailed(let error): error.localizedDescription
        case let .invalidURL(url): "URL is not valid: \(url)"
        }
    }
}

// MARK: - Error.ParameterEncodingFailureReason
extension Error {

    /// The underlying reason the `.parameterEncodingFailed` error occurred.
    public enum ParameterEncodingFailureReason: Sendable {
        /// The `URLRequest` did not have a `URL` to encode.
        case missingURL
        /// JSON serialization failed with an underlying system error during the encoding process.
        case jsonEncodingFailed(error: any Swift.Error)
        /// Custom parameter encoding failed due to the associated `Error`.
        case customEncodingFailed(error: any Swift.Error)
    }
}

// MARK: - Error.ParameterEncodingFailureReason: LocalizedError
extension Error.ParameterEncodingFailureReason: LocalizedError {

    var localizedDescription: String {
        switch self {
        case .missingURL: "URL request to encode was missing a URL"
        case let .jsonEncodingFailed(error): "JSON could not be encoded because of error: \n \(error.localizedDescription)"
        case let .customEncodingFailed(error): "Custom parameter encoder failed with error: \n \(error.localizedDescription)"
        }
    }
}

// MARK: - Error.JSONEncodingError
extension Error {
    public enum JSONEncodingError: Sendable {
        case invalidJSONObject
    }
}

// MARK: - Error.JSONEncodingError: LocalizedError
extension Error.JSONEncodingError: LocalizedError {
    var localizedDescription: String {
        """
        Invalid JSON object provided for parameter or object encoding. \
        This is most likely due to a value which can't be represented in Objective-C.
        """
    }
}

extension Error {
    
    public enum ModelConvert:String, Sendable {
    case empty
    }
    
}

extension Error.ModelConvert: LocalizedError {
    
    
}
// MARK: -

