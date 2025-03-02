//
//  Spark+Protocol.swift
//  Spark
//
//  Created by Dream on 2025/2/26.
//

import Foundation

/// SparkCompatible, Isolation Agreement
public protocol SparkCompatible { }

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


