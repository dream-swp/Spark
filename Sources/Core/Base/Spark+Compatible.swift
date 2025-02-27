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
public struct SP<SP> {
    
    /// Prefix property
    public var sp: SP
    
    /// Initialization method
    /// - Parameter ds: DS
    public init(_ sp : SP) {
        self.sp = sp
    }
}

public extension SparkCompatible {
    
    /// Instance property
    var sp: SP<Self> {
        set { }
        get { SP(self) }
    }
    
    /// Static property
    static var sp: SP<Self>.Type {
        set { }
        get { SP<Self>.self }
    }
}
