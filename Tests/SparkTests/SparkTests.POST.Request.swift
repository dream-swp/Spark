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
    func test_post() throws {
        // Given
        let token: Token = .init()
        let url = "https://echo.apifox.com/post"
        
        
        sk.post(url, parameters: ["d":"deserunt", "dd":"adipisicing enim deserunt Duis", "q1":"v1", "q2":"v2"], headers: [.contentType(.application(.json))])
            .receive(on: DispatchQueue.main)
            .sink { complete in
                if case .failure(let error) = complete {
                    print(error.localizedDescription)
                    XCTAssertThrowsError(error)
                }
                token.unseal()
            } receiveValue: { data in
                print("\r\(#function) -> \(url) : ")
                print(data.sk.string)
                if let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    print(jsonObject)
                }
                    
                XCTAssertNotNil(data)
            }.sk.seal(token)
        
    }
    
}
