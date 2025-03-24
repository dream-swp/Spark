//
//  RequestParameter.swift
//  Example
//
//  Created by Dream on 2025/3/25.
//

import Spark

class RequestParameter: ConvertibleData, @unchecked Sendable {

    var url: RequestURL

    var convert: any URLConvert

    var method: Method

    var encoding: any ParameterEncoding

    var parameters: Parameters?

    var headers: Headers?
    
    var requestModifier: RequestModifier?

    init(url: RequestURL, method: Method, encoding: any ParameterEncoding, parameters: Parameters? = nil, headers: Headers? = nil, requestModifier: RequestModifier? = nil) {
        self.url = url
        self.convert = url.value
        self.method = method
        self.encoding = encoding
        self.parameters = parameters
        self.headers = headers
        self.requestModifier = requestModifier
    }
    
}

enum RequestURL {

    case get(GETURL)
    case post(POSTURL)
    case customize(String)

    enum POSTURL: (String) {
        case apifox = "https://echo.apifox.com/post"
    }

    enum GETURL: (String) {
        case rand = "https://api.vvhan.com/api/ian/rand"
        case dongman = "https://api.vvhan.com/api/ian/dongman"
        case wenxue = "https://api.vvhan.com/api/ian/wenxue"
        case shici = "https://api.vvhan.com/api/ian/shici"
        case sexy = "https://api.vvhan.com/api/text/sexy"
        case love = "https://api.vvhan.com/api/text/love"
        case joke = "https://api.vvhan.com/api/text/joke"
        case dog = "https://api.vvhan.com/api/text/dog"

    }

    var value: String {
        switch self {
        case .get(let get): get.rawValue
        case .post(let post): post.rawValue
        case .customize(let customize): customize
        }
    }
}
