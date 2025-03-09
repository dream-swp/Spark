//
//  SparkCompatible.swift
//  Spark
//
//  Created by Dream on 2025/2/26.
//

import Foundation
import Combine

// MARK: - SparkCompatible
/// SparkCompatible, Isolation Agreement
public protocol SparkCompatible { }


// MARK: - SK
/// Isolation
public struct SK<SK> {
    
    /// Prefix property
    public let sk: SK
    
    /// Initialization method
    /// - Parameter ds: DS
    public init(_ sp : SK) {
        self.sk = sp
    }
}

// MARK: - SparkCompatible Extension
public extension SparkCompatible {
    
    /// Instance property
    var sk: SK<Self> {
        set { }
        get { SK(self) }
    }
    
    /// Static property
    static var sk: SK<Self>.Type {
        set { }
        get { SK<Self>.self }
    }
}

// MARK: - String: SparkCompatible
extension String: SparkCompatible {}

// MARK: - CharacterSet: SparkCompatible
extension CharacterSet: SparkCompatible {}

// MARK: - NSNumber: SparkCompatible
extension NSNumber: SparkCompatible {}

// MARK: - AnyCancellable: SparkCompatible
extension AnyCancellable: SparkCompatible {}
// MARK: -



