//
//  ResponsePostModel.swift
//  Example
//
//  Created by Dream on 2025/3/25.
//

struct ResponsePostModel: Codable {

    let args: [String: String]
    let data: String
    let files: [String: String]
    let form: [String: String]
    let headers: Headers
    let json: Json
    let origin: String
    let url: String
    

    struct Headers: Codable {

        let accept: String
        let acceptEncoding: String
        let acceptLanguage: String
        let connection: String
        let contentLength: String
        let contentType: String
        let host: String
        let remoteip: String
        let userAgent: String

        enum CodingKeys: String, CodingKey {
            case accept = "Accept"
            case acceptEncoding = "Accept-Encoding"
            case acceptLanguage = "Accept-Language"
            case connection = "Connection"
            case contentLength = "Content-Length"
            case contentType = "Content-Type"
            case host = "Host"
            case remoteip = "Remoteip"
            case userAgent = "User-Agent"
        }
    }

    struct Json: Codable {
        let d: String
        let dd: String
        let q1: String
        let q2: String
    }
}
