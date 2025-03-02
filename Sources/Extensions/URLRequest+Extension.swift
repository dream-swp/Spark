//
//  URLRequest+Extension.swift
//  Spark
//
//  Created by Dream on 2025/2/26.
//

import Foundation


public extension URLRequest {
    
    init(url: any Spark.URLConvert, method: Spark.Method, headers: Spark.Headers? = nil) throws {
        let url = try url.skURL()
        self.init(url: url)
        httpMethod = method.rawValue
        allHTTPHeaderFields = headers?.dictionary
    }

    
    var method: Spark.Method? {
        set { httpMethod = newValue?.rawValue }
        get { httpMethod.map(Spark.Method.init)  }
    }

    
    var headers: Spark.Headers {
        set { allHTTPHeaderFields = newValue.dictionary }
        get { allHTTPHeaderFields.map(Spark.Headers.init) ?? Spark.Headers() }
    }

    
}
