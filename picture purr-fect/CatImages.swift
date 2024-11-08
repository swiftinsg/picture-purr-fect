//
//  CatImages.swift
//  picture purr-fect
//
//  Created by Jia Chen Yee on 11/8/24.
//

import Foundation
import SwiftUI

@MainActor
@Observable
class CatImages {
    var state: AppState = .fetchingCats
    
    var savedDirectory: URL {
        URL.documentsDirectory.appendingPathComponent("cats")
    }
    
    init() {
        if !FileManager.default.fileExists(atPath: savedDirectory.path()) {
            try? FileManager.default.createDirectory(at: savedDirectory, withIntermediateDirectories: true)
        }
        
        Task {
            await fetchImages()
        }
    }
    
    func saveImage(from url: URL) {
        try? FileManager.default.moveItem(at: url, to: savedDirectory.appendingPathComponent("\(UUID().uuidString).png"))
        
        Task {
            await fetchImages()
        }
    }
    
    func fetchImages() async {
        do {
            let contents = try FileManager.default.contentsOfDirectory(at: savedDirectory,
                                                                       includingPropertiesForKeys: [])
            
            let images = contents.filter { url in
                url.pathExtension == "png"
            }
            
            withAnimation {
                state = .retrievedCats(images)
            }
        } catch {
            withAnimation {
                state = .retrievedCats([])
            }
        }
    }
    
    func deleteImage(url: URL) {
        try? FileManager.default.removeItem(at: url)
        
        Task {
            await fetchImages()
        }
    }
}

enum AppState {
    case fetchingCats
    case retrievedCats([URL])
}
