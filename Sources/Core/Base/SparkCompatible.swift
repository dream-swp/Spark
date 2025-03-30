//
//  SparkCompatible.swift
//  Spark
//
//  Created by Dream on 2025/2/26.
//

import Combine
import Foundation

// MARK: - SparkCompatible
/// SparkCompatible, Isolation Agreement
public protocol SparkCompatible {}

// MARK: - SK
/// Isolation
public struct SK<SK> {

    /// Prefix property
    public let sk: SK

    /// Initialization method
    /// - Parameter sk: SK
    public init(_ sk: SK) {
        self.sk = sk
    }
}

// MARK: - SparkCompatible Extension
extension SparkCompatible {

    /// Instance property
    public var sk: SK<Self> {
        set {}
        get { SK(self) }
    }

    /// Static property
    public static var sk: SK<Self>.Type {
        set {}
        get { SK<Self>.self }
    }
}

// MARK: - Spark: SparkCompatible
extension Spark: SparkCompatible {}

// MARK: - String: SparkCompatible
extension String: SparkCompatible {}

// MARK: - CharacterSet: SparkCompatible
extension CharacterSet: SparkCompatible {}

// MARK: - NSNumber: SparkCompatible
extension NSNumber: SparkCompatible {}

// MARK: - AnyCancellable: SparkCompatible
extension AnyCancellable: SparkCompatible {}

// MARK: - JSONDecoder: SparkCompatible
extension JSONDecoder: SparkCompatible {}

// MARK: - JSONEncoder: SparkCompatible
extension JSONEncoder: SparkCompatible {}

// MARK: - Data: SparkCompatible
extension Data: SparkCompatible {}

// MARK: -
