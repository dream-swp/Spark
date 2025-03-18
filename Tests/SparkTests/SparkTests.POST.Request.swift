//
//  SparkTests.POST.Request.swift
//  Spark
//
//  Created by Dream on 2025/3/17.
//

import XCTest

@testable import Spark

final class SparkTestsPOSTRequest: SparkTests {

    private let sk = Spark.default

    func test_post1() throws {
        // Given
        let token: Token = .init()

        sk.post(url, parameters:parameters, headers: headers)
            .receive(on: DispatchQueue.main)
            .sink { complete in
                if case .failure(let error) = complete {
                    print(error.localizedDescription)
                    XCTAssertThrowsError(error)
                }
                token.unseal()
            } receiveValue: { data in
                print("\r\(#function) -> \(self.url) : ")
                print(data.sk.string)
                if let jsonObject = data.sk.jsonObject as? [String: Any] {
                    print(jsonObject)
                    //                    let a = self.sk.sk.jsonData { jsonObject }
                    //                    print("a?.sk.jsonObject = \(a?.sk.jsonObject as? [String : Any])")
                }

                XCTAssertNotNil(data)
            }.sk.seal(token)

    }
    
    func test_post2() throws {
        
        let token: Token = .init()
        
        sk.post(url, parameters: parameters, headers: headers, model: ApifoxPost.self)
            .receive(on: DispatchQueue.main)
            .sink { complete in
                if case .failure(let error) = complete {
                    print(error.localizedDescription)
                    XCTAssertThrowsError(error)
                }
                token.unseal()
            } receiveValue: {
                print($0)
                XCTAssertNotNil($0)
            }.sk.seal(token)
    }

}

extension SparkTestsPOSTRequest {

    fileprivate var url: String { "https://echo.apifox.com/post" }
    fileprivate var parameters: [String: Any] { ["d": "deserunt", "dd": "adipisicing enim deserunt Duis", "q1": "v1", "q2": "v2"] }
    fileprivate var headers: Headers { [.contentType(.application(.json))] }

    fileprivate struct ApifoxPost: Codable {
        
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
            let xFromAlb: String
            let xFromAlbIp: String

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
                case xFromAlb = "X-From-Alb"
                case xFromAlbIp = "X-From-Alb-Ip"
            }
        }

        struct Json: Codable {
            let d: String
            let dd: String
            let q1: String
            let q2: String
        }
    }
}
