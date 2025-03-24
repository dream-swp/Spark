//
//  RequestView.swift
//  Example
//
//  Created by Dream on 2025/3/25.
//

import SwiftUI

import Spark

struct RequestView: View {
    
    let request = Request()
    
    var body: some View {
        VStack {
            Button {
                request.get()
            } label: {
                Text("post")
            }

        }
        .padding()
    }
}


extension RequestView {
    
    func post() -> Void {
        
    
    }
    
    
}
