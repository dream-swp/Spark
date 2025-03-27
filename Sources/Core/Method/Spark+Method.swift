//
//  Spark+Method.swift
//  Spark
//
//  Created by Dream on 2025/2/22.
//

// MARK: - Method
/// Request Method
public enum SKMethod: RawRepresentable, Equatable, Hashable, Sendable {

    /// `GET` method.
    case get

    /// `POST` method.
    case post

    /// `customize` method.
    case customize(String)

    /// `SKMethod` Initialization method
    /// - Parameter rawValue: Method String
    public init(rawValue: String) {
        switch rawValue {
        case "GET":
            self = .get
        case "POST":
            self = .post
        default:
            self = .customize(rawValue)
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .get: "GET"
        case .post: "POST"
        case .customize(let value): value
        }
    }
}
