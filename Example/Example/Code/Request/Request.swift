//
//  Request.swift
//  Example
//
//  Created by Dream on 2025/3/25.
//

import Combine
import Foundation
import Spark

struct Request {

    typealias Response = (_ result: @escaping (_ data: String) -> Void) -> Self

    private let sk = Spark.default
}

extension Request {
    
    var getData: Response {

        return { result in

            let token: Token = .init()
            let request = getRequest { .get(.rand) }
            sk.get(request.url.value, encoding: request.encoding, parameters: request.parameters, headers: request.headers)
                .receive(on: DispatchQueue.main)
                .sink { complete in
                    if case .failure(let error) = complete {
                        result(error.localizedDescription)
                    }

                    token.unseal()
                } receiveValue: {
                    let temp =
                        """
                        \(#function):
                        \($0.sk.string)
                        """
                    result(temp)
                }.sk.seal(token)
            return self
        }
    }

    var getModel: Response {

        return { result in

            let token: Token = .init()
            let url = RequestURL.get(.love).value
            let convertible: RequestConvertibleModel<ResponseGetModel2> = .get { url }.parameters(parameters { .get }).headers(headers)
            sk.get(at: convertible)
                .receive(on: DispatchQueue.main)
                .sink { complete in
                    if case .failure(let error) = complete {
                        result(error.localizedDescription)
                    }

                    token.unseal()
                } receiveValue: {
                    let temp =
                        """
                        \(#function):
                        \($0)
                        """
                    result(temp)
                }.sk.seal(token)
            return self
        }

    }

}

extension Request {
    
    var postData: Response {
        return { result in
            let token: Token = .init()
            let request = postRequest { .post(.apifox) }
            
            sk.post(request.url.value, encoding: request.encoding, parameters: request.parameters, headers: request.headers)
                .receive(on: DispatchQueue.main)
                .sink { complete in
                    if case .failure(let error) = complete {
                        result(error.localizedDescription)
                    }

                    token.unseal()
                } receiveValue: {
                    let temp =
                        """
                        \(#function):
                        \($0.sk.string)
                        """
                    result(temp)
                }.sk.seal(token)
            
            
            return self
        }
    }
    
    
    var postModel: Response {
        return { result in
            let token: Token = .init()
            let request = postRequest { .post(.apifox) }
            
            let url = RequestURL.post(.apifox).value
            
            let convertible: RequestConvertibleModel<ResponsePostModel> = .post { url }.parameters(parameters { .post }).headers(headers)
            sk.post(at: convertible)
                .receive(on: DispatchQueue.main)
                .sink { complete in
                    if case .failure(let error) = complete {
                        result(error.localizedDescription)
                    }

                    token.unseal()
                } receiveValue: {
                    let temp =
                        """
                        \(#function):
                        \($0)
                        """
                    result(temp)
                }.sk.seal(token)
            
            
            return self
        }
    }
}

extension Request {

    var getRequest: (_ url: () -> RequestURL) -> RequestParameter {
        {
            let parameters = parameters { .get }
            return .init(url: $0(), method: .get, encoding: URLEncoding.default).headers(headers).parameters(parameters)
        }
    }
    
    var postRequest: (_ url: () -> RequestURL) -> RequestParameter {
        {
            let parameters = parameters { .post }
            return .init(url: $0(), method: .post, encoding: JSONEncoding.default).headers(headers).parameters(parameters)
        }
    }

    var parameters: (_ method: () -> SKMethod) -> [String: Any] {

        return {
            switch $0() {
            case .post: ["d": "deserunt", "dd": "adipisicing enim deserunt Duis", "q1": "v1", "q2": "v2"]
            case .get: ["type": "json"]
            default:
                [:]
            }
        }
    }

    var headers: Headers {
        [.contentType(.application(.json))]
    }

}
