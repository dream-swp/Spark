//
//  Spark+URLConvert.swift
//  Spark
//
//  Created by Dream on 2025/3/2.
//

import Foundation

// MARK: - URLConvert
public extension Spark  {
    protocol URLConvert: Sendable {
        func skURL() throws -> URL
    }
}
// MARK: -

extension String: Spark.URLConvert {
    public func skURL() throws -> URL {
        guard let url = URL(string: self) else { throw Spark.Error.invalidURL(url: self) }
        return url
    }
}

extension URL: Spark.URLConvert {
    public func skURL() throws -> URL { self }
}

extension URLComponents: Spark.URLConvert {
    public func skURL() throws -> URL {
        guard let url else { throw Spark.Error.invalidURL(url: self) }
        return url
    }
}



