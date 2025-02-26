//
//  Spark+Space.swift
//  Spark
//
//  Created by Dream on 2025/2/26.
//

import Foundation

/// SparkCompatible, Isolation Agreement
public protocol SparkCompatible { }

/// Isolation
public struct DS<DS> {
    
    /// Prefix property
    public var spark: DS
    
    /// Initialization method
    /// - Parameter ds: DS
    public init(_ spark : DS) {
        self.spark = spark
    }
}

public extension SparkCompatible {
    
    /// Instance property
    var spark: DS<Self> {
        set { }
        get { DS(self) }
    }
    
    /// Static property
    static var spark: DS<Self>.Type {
        set { }
        get { DS<Self>.self }
    }
}
