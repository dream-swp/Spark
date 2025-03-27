//
//  RequestView.swift
//  Example
//
//  Created by Dream on 2025/3/25.
//

import Combine
import Spark
import SwiftUI

struct RequestView: View {

    var request: Request = .init()

    @State var text = ""

    var body: some View {

        Form {
            ForEach(RequestViewModel.allCases, id: \.self) {
                section($0)
            }
        }
        .formStyle(.grouped)
    }
}

extension RequestView {

    var sendRequest: (_ request: () -> (index: Int, data: RequestViewModel)) -> Self {
        return {
            let result = $0()
            let buttonModel = result.data.model { (result.index, result.data.datas) }
            
            // Get
            if result.data == .Get {
                switch buttonModel.mode {
                case .data: _ = request.getData { text = $0 }
                case .model: _ = request.getModel { text = $0 }
                }
                
            } else {
                switch buttonModel.mode {
                case .data: _ = request.postData { text = $0 }
                case .model: _ = request.postModel { text = $0 }
                }
                
            }
            return self
        }
    }

    func section(_ model: RequestViewModel) -> some View {
        Section(model.rawValue) {
            if model == .Response {
                Text(text)
            } else {
                RequestCell(model.datas) { index in
                    _ = sendRequest { (index, model) }
                }
            }
        }
    }

}

#Preview {
    RequestView()
}
