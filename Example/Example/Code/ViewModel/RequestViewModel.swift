//
//  RequestViewModel.swift
//  Example
//
//  Created by Dream on 2025/3/26.
//

import Foundation

enum RequestViewModel: (String), CaseIterable {

    case Get
    case Post
    case Response

    var datas: [RequestButtonModel] {
        switch self {
        case .Get: getData
        case .Post: postData
        case .Response: []
        }
    }

    var getData: [RequestButtonModel] {
        [
            .init(title: "GET Data", sysIcon: "globe.americas"),
//            .init(title: "GET Data", sysIcon: "globe.europe.africa"),
            .init(title: "GET Model", sysIcon: "globe.central.south.asia.fill", mode: .model),
//            .init(title: "GET Model", sysIcon: "globe.asia.australia", mode: .model),
        ]
    }

    var postData: [RequestButtonModel] {
        [
            .init(title: "POST Data", sysIcon: "globe.asia.australia.fill"),
//            .init(title: "POST Data", sysIcon: "globe.europe.africa.fill"),
            .init(title: "POST Model", sysIcon: "globe.americas.fill" , mode: .model),
//            .init(title: "POST Model", sysIcon: "globe.central.south.asia" , mode: .model),
        ]
    }

    var model: (_ datas: () -> ( index: Int, datas: [RequestButtonModel])) -> RequestButtonModel {
        
        return {
            $0().datas[$0().index]
        }
    }

}




struct RequestButtonModel: Identifiable {

    let id = UUID()
    var title: String = ""
    var sysIcon: String = ""
    var mode: DataMode = .data


    init(title: String, sysIcon: String, mode: DataMode = .data) {
        self.title = title
        self.sysIcon = sysIcon
        self.mode = mode
    }
    
    
    enum DataMode {
        case data
        case model
    }

}
