//
//  ContentView.swift
//  picture purr-fect
//
//  Created by Jia Chen Yee on 11/8/24.
//

import SwiftUI
import ImagePlayground

struct ContentView: View {
    
    @State private var isImagePlaygroundPresented = false
    @State private var catImages = CatImages()
    
    @Namespace var namespace
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationStack {
            switch catImages.state {
            case .fetchingCats:
                ProgressView()
            case .retrievedCats(let imageURLs):
                if imageURLs.isEmpty {
                    EmptyStateView(isImagePlaygroundPresented: $isImagePlaygroundPresented)
                } else {
                    ZStack {
                        ScrollView {
                            LazyVGrid(columns: columns) {
                                ForEach(imageURLs, id: \.self) { imageURL in
                                    GridImageView(namespace: namespace, url: imageURL)
                                        .contextMenu {
                                            ShareLink("Share", item: imageURL)
                                            Button("Delete", systemImage: "trash", role: .destructive) {
                                                catImages.deleteImage(url: imageURL)
                                            }
                                        }
                                }
                            }
                        }
                        Button("new", systemImage: "cat.fill") {
                            isImagePlaygroundPresented = true
                        }
                        .buttonBorderShape(.roundedRectangle)
                        .buttonStyle(.borderedProminent)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                        .padding()
                    }
                    .navigationTitle("picture purr-fect")
                }
            }
        }
        .imagePlaygroundSheet(isPresented: $isImagePlaygroundPresented, concepts: [
            .text("whiskers"),
            .text("with cat ears"),
            .text("person")
        ]) { url in
            catImages.saveImage(from: url)
        }
    }
}

#Preview {
    ContentView()
}
