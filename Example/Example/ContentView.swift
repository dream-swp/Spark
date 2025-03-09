//
//  ContentView.swift
//  Example
//
//  Created by Dream on 2025/3/10.
//

import SwiftUI

import Spark

struct ContentView: View {
    var body: some View {
        VStack {
            Button {
                test()
            } label: {
                Text("GET")
            }

        }
        .padding()
    }
}

extension ContentView {
    func test()  {
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
    
    func test1()  {
        let token: Spark.Token = .init()
        
        let parameters: [String : Any] = ["id" : 15,
                                          "userId": 21,
                                          "products" : [
                                            ["id":1, "title":"Dream1", "price": 2.0, "description": "AAAA", "category":"T", "image": "123123"],
                                            ["id":2, "title":"Dream2", "price": 3.0, "description": "BBBB", "category":"T", "image": "123123"]]]
        Spark.default
            .request(url: "https://fakestoreapi.com/carts",
                     method: .post,
                     encoding: Spark.JSONEncoding.default,
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
}
#Preview {
    ContentView()
}
