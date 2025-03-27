//
//  ResponseGetModel.swift
//  Example
//
//  Created by Dream on 2025/3/25.
//

private protocol ResponseGetResult: Codable {
    var success: Bool { get set }
    var type: String { get set }
}

private protocol ResponseGetData: Codable {
    var `id`: Int { get set }
    var content: String { get set }
}

//  rand | dongman | wenxue | shici
struct ResponseGetModel1: ResponseGetResult {
    var success: Bool
    var type: String
    var data: Data
    
    struct Data: ResponseGetData {
        var id: Int
        var content: String
        var form: String
        var creator: String
    }
}

// sexy | dog | love | dog
struct ResponseGetModel2: ResponseGetResult {

    var success: Bool
    var type: String
    var data: Data

    struct Data: ResponseGetData {
        var id: Int
        var content: String
    }

}

// joke
struct ResponseGetModel3: ResponseGetResult {

    var success: Bool
    var type: String
    var data: Data

    struct Data: ResponseGetData {
        var id: Int
        var content: String
        var title: String
    }
}
