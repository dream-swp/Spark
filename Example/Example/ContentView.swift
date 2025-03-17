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
                post()
            } label: {
                Text("GET")
            }

        }
        .padding()
    }
}

extension ContentView {
    
    var parameters: [String: Any] { ["type": "json"] }
    var headers: Headers { [.contentType(.application(.json))] }
    func test()  {
        let token: Token = .init()
        let request: RequestConvertible = .init(convert: "https://api.vvhan.com/api/ian/rand", method: .get, encoding: URLEncoding.default).parameters(parameters).headers(headers)
        
        
        Spark.default.request(at:request)
            .receive(on: DispatchQueue.main)
            .sink { complete in
                if case .failure(let error) = complete {
                    print(error.localizedDescription)
                }
                token.unseal()
            } receiveValue: { data in
                print(data.sk.string)
            }.sk.seal(token)
    }
    
    func test1()  {
        let token: Token = .init()
//        let request: RequestConvertible = .init(convert: "https://api.vvhan.com/api/ian/rand", method: .get, encoding: URLEncoding.default).parameters(parameters).headers(headers)
        
        let request: RequestConvertibleModel<Model1> = .init(convert: "https://api.vvhan.com/api/ian/rand", method: .get, encoding: URLEncoding.default).headers(headers).parameters(parameters)
        
        
        Spark.default.request(at: request)
            .receive(on: DispatchQueue.main)
            .sink { complete in
                if case .failure(let error) = complete {
                    print(error.localizedDescription)
                }
                token.unseal()
            } receiveValue: { data in
                print(data)
            }.sk.seal(token)
    }
    
    func post() {
        // Given
        let token: Token = .init()
        let url = "https://echo.apifox.com/post"
        
        var parameters: [String : Any] = ["name" : "Dream", "age" : 18, "acction" : "dream1213"]
        
        
        Spark.default.post(url, parameters: parameters, headers: [.contentType(.application(.json))])
            .receive(on: DispatchQueue.main)
            .sink { complete in
                if case .failure(let error) = complete {
                    print(error.localizedDescription)
                }
                token.unseal()
            } receiveValue: { data in
                print("\r\(#function) -> \(url) : ")
                print(data.sk.string)
                let a = data.sk.jsonObjectOptions { .fragmentsAllowed }!
                if let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    print(jsonObject)
                    print(jsonObject["headers"]!)
                }
            }.sk.seal(token)
    }
    
}

extension ContentView {
    
    protocol Result: Codable {
        var success: Bool { get set }
        var type: String { get set }
    }

    protocol Data: Codable {
        var `id`: Int { get set }
        var content: String { get set }
    }
    
    //  rand | dongman | wenxue | shici
    struct Model1: ContentView.Result {
        var success: Bool
        var type: String
        var data: Data

        struct Data: ContentView.Data {
            var id: Int
            var form: String
            var creator: String
            var content: String
        }
    }
}




#Preview {
    ContentView()
}
