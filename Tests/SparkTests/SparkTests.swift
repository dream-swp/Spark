//
//  SparkTests.swift
//  Spark
//
//  Created by Dream on 2025/2/22.
//

import XCTest
@testable import Spark

class SparkTests: XCTestCase {
    
    
    func test_request() throws {
        
        
        let token: Spark.Token = .init()
        
        let parameters = ["type" : "json"]
        Spark.default
            .request(url: "https://api.vvhan.com/api/ian/rand", method: .get, parameters: parameters)
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
    
    
    func test_A() {

//        let parameters : [String : Any] = ["question" : "Favourite programming language?", "choices" : ["Swift", "Python", "Python", "Objective-C", "Ruby"]]
//        
//        let request: Spark.Request = .init()
//            .scheme(.https)
//            .port(.scheme(.https))
//            .host(.custom("https://polls.apiblueprint.org/"))
//            .path(.custom("questions"))
//            .method(.post)
//            .headers([.contentType("application/json")])
//            .timeout(60)
//            .cachePolicy(.useProtocolCachePolicy)
//        
//        let token: Spark.Token = .init()
//        Spark.default
//            .request(url: request, parameters: parameters)
//            .receive(on: DispatchQueue.main)
//            .sink { complete in
//                if case .failure(let error) = complete {
//                    print(error.localizedDescription)
//                }
//                token.unseal()
//            } receiveValue: {  data in
//                print(String(data: data, encoding: .utf8)!)
//            }.sk.seal(token)
//        request.urlRequest
        
//        let parameters : [String : Any] = ["wd" : "aa"]
//        request.headers = [.contentType("application/json")]
        
        //        url --include \
        //             --request POST \
        //             --header "Content-Type: application/json" \
        //             --data-binary "{
        //            \"question\": \"Favourite programming language?\",
        //            \"choices\": [
        //                \"Swift\",
        //                \"Python\",
        //                \"Objective-C\",
        //                \"Ruby\"
        //            ]
        //        }" \
        //        'https://polls.apiblueprint.org/questions'
        //        request.urlRequest
//        let token: Spark.Token = .init()
//        Spark.default
//            .request(url: "https://www.baidu.com/s?", method: .get, parameters: parameters)
//            .receive(on: DispatchQueue.main)
//            .sink { complete in
//                if case .failure(let error) = complete {
//                    print(error.localizedDescription)
//                }
//                token.unseal()
//            } receiveValue: {  data in
//                print(String(data: data, encoding: .utf8)!)
//            }.sk.seal(token)
    }

    
}
