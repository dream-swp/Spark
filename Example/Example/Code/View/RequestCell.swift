//
//  RequestCell.swift
//  Example
//
//  Created by Dream on 2025/3/26.
//

import SwiftUI

struct RequestCell: View {

    
    let data: [RequestButtonModel]
    let action: @MainActor (_ index: Int) -> Void
    var body: some View {
        HStack {
            ForEach(data.indices, id: \.self) { index in
                let model = data[index]
                RequestButton(model) {
                    action(index)
                }
            }
        }
    }
    
    init(_ data: [RequestButtonModel], action: @escaping (_: Int) -> Void) {
        self.data = data
        self.action = action
    }
}


#Preview {
    RequestCell([.init(title: "", sysIcon: "")]) {
        print($0)
    }
}
