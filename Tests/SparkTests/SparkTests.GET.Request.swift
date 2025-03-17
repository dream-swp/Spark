//
//  SparkTests.GET.Request.swift
//  Spark
//
//  Created by Dream on 2025/2/24.
//

import XCTest

@testable import Spark

final class SparkTestsGETRequest: SparkTests {

    private let sk = Spark.default

    @MainActor
    func test_request1() throws {

        // Given
        let token: Token = .init()

        // Then
        let convertible: RequestConvertible = .init(convert: SchemeGet.rand, method: .get, encoding: URLEncoding.default).parameters(parameters).headers(headers)

        // When
        sk.request(convertible)
            .receive(on: DispatchQueue.main)
            .sink { complete in
                if case .failure(let error) = complete {
                    print(error.localizedDescription)
                    XCTAssertThrowsError(error)
                }
                token.unseal()
            } receiveValue: { data in
                print("\r\(#function) -> \(SchemeGet.rand.rawValue) : ")
                print(data.sk.string)
                XCTAssertNotNil(data)
            }.sk.seal(token)
    }

    @MainActor
    func test_request2() throws {

        // Given, When
        let token: Token = .init()

        // Then
        sk.request(SchemeGet.dongman, method: .get, encoding: URLEncoding.default, parameters: parameters, headers: headers)
            .receive(on: DispatchQueue.main)
            .sink { complete in
                if case .failure(let error) = complete {
                    print(error.localizedDescription)
                    XCTAssertThrowsError(error)
                }
                token.unseal()
            } receiveValue: { data in
                print("\r\(#function) -> \(SchemeGet.dongman.rawValue) : ")
                print(data.sk.string)
                XCTAssertNotNil(data)
            }.sk.seal(token)
    }

    @MainActor
    func test_request3() throws {

        // Given
        let token: Token = .init()

        // When
        let convertible: RequestConvertibleModel<Model1> = .init(convert: SchemeGet.wenxue, method: .get, encoding: URLEncoding.default).headers(headers).parameters(parameters)

        // Then
        sk.request(at: convertible)
            .receive(on: DispatchQueue.main)
            .sink { complete in
                if case .failure(let error) = complete {
                    print(error.localizedDescription)
                    XCTAssertThrowsError(error)
                }
                token.unseal()
            } receiveValue: { model in
                print("\r\(#function) -> \(SchemeGet.wenxue.rawValue) : ")
                print(model)
                XCTAssertNotNil(model)
            }.sk.seal(token)

    }

    @MainActor
    func test_request4() throws {

        // Given, When
        let token: Token = .init()

        // Then
        sk.request(SchemeGet.shici, method: .get, encoding: URLEncoding.default, parameters: parameters, headers: headers, model: Model1.self)
            .receive(on: DispatchQueue.main)
            .sink { complete in
                if case .failure(let error) = complete {
                    print(error.localizedDescription)
                    XCTAssertThrowsError(error)
                }
                token.unseal()
            } receiveValue: { model in
                print("\r\(#function) -> \(SchemeGet.shici.rawValue) : ")
                print(model)
                XCTAssertNotNil(model)
            }.sk.seal(token)
    }

    func test_get1() throws {

        // Given, When
        let token: Token = .init()

        // Then
        sk.get(SchemeGet.sexy, parameters: parameters, headers: headers)
            .receive(on: DispatchQueue.main)
            .sink { complete in
                if case .failure(let error) = complete {
                    print(error.localizedDescription)
                    XCTAssertThrowsError(error)
                }
                token.unseal()
            } receiveValue: { data in
                print("\r\(#function) -> \(SchemeGet.sexy.rawValue) : ")
                print(data.sk.string)
                XCTAssertNotNil(data)
            }.sk.seal(token)

    }

    func test_get2() throws {

        // Given, When
        let token: Token = .init()
        let convertible: RequestConvertible = .get { SchemeGet.love }.parameters(parameters).headers(headers)

        // Then
        sk.get(in: convertible)
            .receive(on: DispatchQueue.main)
            .sink { complete in
                if case .failure(let error) = complete {
                    print(error.localizedDescription)
                }
                token.unseal()
            } receiveValue: { data in
                print("\r\(#function) -> \(SchemeGet.love.rawValue) : ")
                print(data.sk.string)
                XCTAssertNotNil(data)
            }.sk.seal(token)
    }

    func test_get3() throws {

        // Given, When
        let token: Token = .init()

        // Then
        sk.get(SchemeGet.joke, parameters: parameters, headers: headers, model: Model3.self)
            .receive(on: DispatchQueue.main)
            .sink { complete in
                if case .failure(let error) = complete {
                    print(error.localizedDescription)
                    XCTAssertThrowsError(error)
                }
                token.unseal()
            } receiveValue: { model in
                print("\r\(#function) -> \(SchemeGet.joke.rawValue) : ")
                print(model)
                XCTAssertNotNil(model)
            }.sk.seal(token)
    }

    func test_get4() throws {

        // Given, When
        let token: Token = .init()
        let convertible: RequestConvertibleModel<Model2> = .get { SchemeGet.dog }.parameters(parameters).headers(headers)

        // Then
        sk.get(at: convertible)
            .sink { complete in
                if case .failure(let error) = complete {
                    print(error.localizedDescription)
                    XCTAssertThrowsError(error)
                }
                token.unseal()
            } receiveValue: { model in
                print("\r\(#function) -> \(SchemeGet.dog.rawValue) : ")
                print(model)
                XCTAssertNotNil(model)
            }.sk.seal(token)

    }

    func test_request_error() throws {

        // Given, When
        let token: Token = .init()
        let convertible: RequestConvertible = .get { "" }.parameters(parameters).headers(headers)

        // Then
        sk.get(in: convertible)
            .sink { complete in
                if case .failure(let error) = complete {
                    print(error.localizedDescription)
                    XCTAssertNotNil(error)
                    XCTAssertEqual((error as? Error)?.localizedDescription, Error.urlError.localizedDescription)
                    print("\r\(#function) -> \(error.localizedDescription) : ")
                }
                token.unseal()
            } receiveValue: { model in
                print(model)
                XCTAssertNotNil(model)
            }.sk.seal(token)
    }

}

extension SparkTests {

    fileprivate var parameters: [String: Any] { ["type": "json"] }
    fileprivate var headers: Headers { [.contentType(.application(.json))] }

    ///
    /// Domain Name, 请求方式: GET, 返回格式：TXT/JSON/JS
    /// - JSON: https://api.vvhan.com/api/text/path?type=json,
    /// - JS:   https://api.vvhan.com/api/text/sexy?type=js
    /// - TXT:  https://api.vvhan.com/api/text/sexy
    ///
    /// 请求参数：
    /// | 名称 | 必填 | 说明 |
    /// |:--------:|:--------:|:---------------:|
    /// | type | 否 | type否JSON输出:json，JS输出:js |
    ///------
    ///
    /// 返回状态：
    /// | 名称 | 必填 | 说明 |
    /// |:--------:|:--------:|:---------------:|
    /// | success | 是 | 成功：true，失败：false |
    /// | message | 是 | 是返回状态描述信息 |
    ///
    ///
    /// - rand | dongman | wenxue | shici ( type = 随机 | 动漫 | 文学 ｜诗词  )
    ///     - {"success":true,"type":"随机","data":{"id":6143,"content":"我喜欢同性的可能性只有百分之一，而你就是那百分之一，也是我的唯一。","form":"一叶知秋","creator":"残灯晓霜"}}
    /// - sexy: {"success":true,"type":"骚话","data":{"id":281,"content":"我爱你是真的想喂你吃春药也是真的"}}
    /// - dog:  {"success":true,"type":"舔狗日记","data":{"id":1,"content":"看到你和一个帅哥吃饭，看起来关系很亲密的样子，你从来没有告诉我你还有这么好的朋友，一定是怕我多想，你总是为我着想，你对我真好。"}}
    /// - love: {"success":true,"type":"情话","data":{"id":199,"content":"上一秒想问你牛奶糖果布丁巧克力果汁甜甜圈冰淇淋要哪一个，下一秒算了算了全都给你"}}
    /// - joke: {"success":true,"type":"笑话","data":{"id":64,"title":"沉默是金","content":"自习课班里特别乱，班长在黑板上写下了“沉默是金”四个大字。班里一逗比说：“沉默是金，都别跟我说话，我要攒钱。”"}}
    /// - dog:  {"success":true,"type":"舔狗日记","data":{"id":1,"content":"看到你和一个帅哥吃饭，看起来关系很亲密的样子，你从来没有告诉我你还有这么好的朋友，一定是怕我多想，你总是为我着想，你对我真好。"}}
    fileprivate enum SchemeGet: (String), URLConvert {

        case rand = "https://api.vvhan.com/api/ian/rand"
        case dongman = "https://api.vvhan.com/api/ian/dongman"
        case wenxue = "https://api.vvhan.com/api/ian/wenxue"
        case shici = "https://api.vvhan.com/api/ian/shici"

        case sexy = "https://api.vvhan.com/api/text/sexy"

        case love = "https://api.vvhan.com/api/text/love"

        case joke = "https://api.vvhan.com/api/text/joke"

        case dog = "https://api.vvhan.com/api/text/dog"

        func urlConvert() throws -> URL {
            try self.rawValue.urlConvert()
        }

    }

    fileprivate protocol Result: Codable {
        var success: Bool { get set }
        var type: String { get set }
    }

    fileprivate protocol Data: Codable {
        var `id`: Int { get set }
        var content: String { get set }
    }

    //  rand | dongman | wenxue | shici
    fileprivate struct Model1: SparkTests.Result {
        var success: Bool
        var type: String
        var data: Data

        struct Data: SparkTests.Data {
            var id: Int
            var form: String
            var creator: String
            var content: String
        }
    }

    // sexy | dog | love | dog
    fileprivate struct Model2: SparkTests.Result {

        var success: Bool
        var type: String

        var data: Data

        struct Data: SparkTests.Data {
            var id: Int
            var content: String
        }

    }

    // joke
    fileprivate struct Model3: SparkTests.Result {

        var success: Bool
        var type: String
        var data: Data

        struct Data: SparkTests.Data {
            var id: Int
            var content: String
            var title: String

        }
    }

}
