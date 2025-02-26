//
//  URLRequest+Extension.swift
//  Spark
//
//  Created by Dream on 2025/2/26.
//

import Foundation

extension URLRequest: SparkCompatible { }

public extension DS where DS == URLRequest {
    var headers: Spark.Headers {
        set { spark.allHTTPHeaderFields = newValue.dictionary }
        get { spark.allHTTPHeaderFields.map(Spark.Headers.init) ?? Spark.Headers() }
    }
}
