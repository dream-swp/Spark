//
//  Spark+Request.swift
//  Spark
//
//  Created by Dream on 2025/3/9.
//

import Foundation

extension Spark {

    /// Request Convert
    public class Request: @unchecked Sendable {

        public typealias Convert = (_ convert: () -> any Spark.URLConvert) -> Request

        var url: any Spark.URLConvert
        var method: Spark.Method = .get
        var encoding: any Spark.ParameterEncoding = Spark.URLEncoding.default
        var parameters: Spark.Parameters?
        var headers: Spark.Headers?
        var requestModifier: Spark.RequestModifier?

        var urlRequest: URLRequest? {
            guard let urlRequest = try? skURLRequest() else { return nil }
            return urlRequest
        }

        init(url: any Spark.URLConvert, method: Spark.Method = .get,
             encoding: any Spark.ParameterEncoding = Spark.URLEncoding.default,
             parameters: Spark.Parameters? = nil, headers: Spark.Headers? = nil,
             requestModifier: Spark.RequestModifier? = nil) {
            self.url = url
            self.method = method
            self.encoding = encoding
            self.parameters = parameters
            self.headers = headers
            self.requestModifier = requestModifier
        }

        public static var post: Convert {
            { .init(url: $0()).method(.post).encoding(Spark.JSONEncoding.default) }
        }

        public static var get: Convert {
            return { .init(url: $0()).method(.get).encoding(Spark.URLEncoding.default) }
        }
    }
}

extension Spark.Request {

    func method(_ method: Spark.Method) -> Self {
        self.method = method
        return self
    }

    func parameters(_ parameters: Spark.Parameters?) -> Self {
        self.parameters = parameters
        return self
    }

    func encoding(_ encoding: Spark.ParameterEncoding) -> Self {
        self.encoding = encoding
        return self
    }

    func headers(_ headers: Spark.Headers?) -> Self {
        self.headers = headers
        return self
    }

    func requestModifier(_ requestModifier: Spark.RequestModifier?) -> Self {
        self.requestModifier = requestModifier
        return self
    }

}

extension Spark.Request: Spark.URLRequestConvert {

    public func skURLRequest() throws -> URLRequest {
        var request = try URLRequest(url: url, method: method, headers: headers)
        try requestModifier?(&request)
        return try encoding.encode(request, with: parameters)
    }
}
