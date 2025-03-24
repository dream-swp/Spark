//
//  Request.swift
//  Example
//
//  Created by Dream on 2025/3/25.
//

import Spark
import Combine
import Foundation

struct Request {
    
//    typealias Model = type
//    public static let `default` = Spark()
    
    
    var text: String = ""
    
    private let sk = Spark.default
    
    func get() {
        // Given, When
        let token: Token = .init()
        
        
        let request = getParameter { .get(.rand) }
        
        // Then
        sk.get(request.url.value, encoding: request.encoding, parameters: request.parameters, headers: request.headers)
            .receive(on: DispatchQueue.main)
            .sink { complete in
                if case .failure(let error) = complete {
                    print(error.localizedDescription)
                }
                token.unseal()
            } receiveValue: { data in
                print("\r\(#function) -> \(request.url.value) : ")
                print(data.sk.string)
            }.sk.seal(token)
    }
    
    func getModel() {
        // Given, When
        let token: Token = .init()
        
        
//        let request = request { .get(.dongman) }
        
        // Then
//        sk.get(request., model: <#T##Item#>)
    }

}

extension Request {

    typealias Parameter = (_  url: () -> RequestURL) -> RequestParameter
    
    private var getParameter: Parameter {
        {
            let parameters: [String : Any] = ["type" : "json"]
            let headers: Headers = [.contentType(.application(.json))]
            return .init(url: $0(), method: .get, encoding: URLEncoding.default).headers(headers).parameters(parameters)
        }
    }
    
}
