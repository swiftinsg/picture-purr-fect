//
//  EmptyStateView.swift
//  picture purr-fect
//
//  Created by Jia Chen Yee on 11/8/24.
//

import Foundation
import SwiftUI

struct EmptyStateView: View {
    
    @Binding var isImagePlaygroundPresented: Bool
    
    var body: some View {
        ContentUnavailableView {
            Label("picture purr-fect", systemImage: "cat.fill")
        } description: {
            Text("get started and turn anyone into a cat!!")
        } actions: {
            Button("create", systemImage: "apple.image.playground") {
                isImagePlaygroundPresented = true
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    @Previewable @State var isImagePlaygroundPresented: Bool = false
    EmptyStateView(isImagePlaygroundPresented: $isImagePlaygroundPresented)
}
