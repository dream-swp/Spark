//
//  RequestButton.swift
//  Example
//
//  Created by Dream on 2025/3/26.
//

import SwiftUI

struct RequestButton: View {

    let model: RequestButtonModel
    let action: @MainActor () -> Void
    var body: some View {

        Button(action: self.action) {
            Label {
                Text(model.title).font(.title3)
            } icon: {
                Image(systemName: model.sysIcon).font(.title2)
            }
            
        }
        .buttonStyle(.plain)
        .frame(maxWidth: .infinity)

    }

    init(_ model: RequestButtonModel, action: @escaping () -> Void) {
        self.model = model
        self.action = action
    }
}

#Preview {

    let model: RequestButtonModel = .init(title: "Sun", sysIcon: "sun.max")
    RequestButton(model) {

    }
}

