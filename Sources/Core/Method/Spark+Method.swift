//
//  Spark+Method.swift
//  Spark
//
//  Created by Dream on 2025/2/22.
//

// MARK: - Spark.Method
public extension Spark {
    
    /// Request Method
    enum Method: (String) {
        
        /// GET Request
        case get = "GET"
        
        /// POST Request
        case post = "POST"
        
        public init(_ rawValue: String) {
            switch rawValue {
            case "GET" :
                self = .get
            case "POST":
                self = .post
            default:
                self = .get
            }
        }
    }
}

// MARK: - Spark.Method: Sendable
extension Spark.Method: Sendable { }
// MARK: -
