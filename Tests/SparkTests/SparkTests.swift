//
//  SparkTests.swift
//  Spark
//
//  Created by Dream on 2025/2/22.
//

import XCTest
@testable import Spark

class SparkTests: XCTestCase {
    
    func test_request1() throws {
        
        let token: Spark.Token = .init()
        let parameters = ["type" : "json"]
        Spark.default
            .request(url: "https://api.vvhan.com/api/ian/rand",
                     method: .get,
                     encoding: Spark.URLEncoding.default,
                     parameters: parameters,
                     headers: [.contentType("application/json")])
            .receive(on: DispatchQueue.main)
            .sink { complete in
                if case .failure(let error) = complete {
                    print(error.localizedDescription)
                }
                token.unseal()
            } receiveValue: {  data in
                print(String(data: data, encoding: .utf8)!)
            }.sk.seal(token)

    }
    
    func test_request2() {
        
        let token: Spark.Token = .init()
        
        let request: Spark.Request =
            .get.url("https://api.vvhan.com/api/ian/shici")
            .parameters(["type" : "json"])
            .headers([.contentType("application/json")])
        
        Spark.default
            .request(request)
            .receive(on: DispatchQueue.main)
            .sink { complete in
                if case .failure(let error) = complete {
                    print(error.localizedDescription)
                }
                token.unseal()
            } receiveValue: {  data in
                print(String(data: data, encoding: .utf8)!)
            }.sk.seal(token)
    }
    
    func test_get1() {
        let token: Spark.Token = .init()
        let parameters = ["type" : "json"]
        Spark.default
            .get(url: "https://api.vvhan.com/api/text/dog", parameters: parameters)
            .receive(on: DispatchQueue.main)
            .sink { complete in
                if case .failure(let error) = complete {
                    print(error.localizedDescription)
                }
                token.unseal()
            } receiveValue: {  data in
                print(String(data: data, encoding: .utf8)!)
            }.sk.seal(token)
        
    }
    
    func test_get2() {
        let token: Spark.Token = .init()
        let parameters = ["type" : "json"]
        Spark.default
            .get(url: "https://api.vvhan.com/api/text/dog", parameters: parameters, model: DogResult.self)
            .receive(on: DispatchQueue.main)
            .sink { complete in
                if case .failure(let error) = complete {
                    print(error.localizedDescription)
                }
                token.unseal()
            } receiveValue: { model in
                print(model)
            }.sk.seal(token)
    }

}

fileprivate extension SparkTests {
    
    struct DogResult: Codable  {
        let success: Bool
        let type: String
        let data: DogResult.Data
        
        struct Data: Codable {
            let `id`: Int
            let content: String
        }
    }
}

