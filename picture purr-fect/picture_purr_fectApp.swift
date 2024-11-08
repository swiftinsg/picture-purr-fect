//
//  picture_purr_fectApp.swift
//  picture purr-fect
//
//  Created by Jia Chen Yee on 11/8/24.
//

import SwiftUI

@main
struct picture_purr_fectApp: App {
    
    @Environment(\.supportsImagePlayground) var supportsImagePlayground
    
    var body: some Scene {
        WindowGroup {
            if supportsImagePlayground {
                ContentView()
            } else {
                Text("Image Playground is not supported on this device.")
                    .multilineTextAlignment(.center)
            }
        }
    }
}
