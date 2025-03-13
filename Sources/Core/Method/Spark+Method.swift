//
//  Spark+Method.swift
//  Spark
//
//  Created by Dream on 2025/2/22.
//

// MARK: - Method
/// Request Method
public enum Method: (String) {

    /// `GET` method.
    case get = "GET"

    /// `POST` method.
    case post = "POST"

    /// `Header` Initialization method
    /// - Parameter rawValue: Method String
    public init(_ rawValue: String) {
        switch rawValue {
        case "GET":
            self = .get
        case "POST":
            self = .post
        default:
            self = .get
        }
    }
}

// MARK: - Method: Sendable
extension Method: Sendable {}
// MARK: -
