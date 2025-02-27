//
//  URLRequest+Extension.swift
//  Spark
//
//  Created by Dream on 2025/2/26.
//

import Foundation

extension URLRequest: SparkCompatible { }

public extension SP where SP == URLRequest {
    var headers: Spark.Headers {
        set { sp.allHTTPHeaderFields = newValue.dictionary }
        get { sp.allHTTPHeaderFields.map(Spark.Headers.init) ?? Spark.Headers() }
    }
}
