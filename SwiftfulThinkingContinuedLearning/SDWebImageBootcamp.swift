//
//  SDWebImageBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Griffin Baker on 5/17/24.
//

import SwiftUI
import SDWebImageSwiftUI

// in the app, only ever reference this
// will then only need to change that one line of code
// erase external dependency to some generic struct to something we have full control over
struct ImageLoader: View {
    let url: String
    let size: CGFloat
    var contentMode: ContentMode = .fill
    
    // constant by default, but lets you edit it now
    func testFn(_ x: inout Int) {
        x = 5
    }
    
    var body: some View {
        Rectangle()
            .opacity(0)
            .overlay(SDWebImageLoader(url: url).allowsHitTesting(false))
            .frame(width: size, height: size)
            .clipped()
    }
}

// put this in its own file to decouple files you use this package with the SDK itself (only have one file coupled, and then reference it elsewher if you want to change the SDK, for example)
// only ever access in this file
fileprivate struct SDWebImageLoader: View {
    let url: String
    var contentMode: ContentMode = .fill
    
    var body: some View {
        WebImage(url: URL(string: url)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: contentMode)
        } placeholder: {
            Rectangle().foregroundColor(.gray)
        }
    }
}

// MARK: - logical file break

// can't be subclassed, allowing the compiler to use static, as opposed to dynamic, dispatch
final class ImagePrefetcher {
    static let instance = ImagePrefetcher()
    private let prefetcher = SDWebImagePrefetcher()
    
    private init() {}
    
    func startPrefetching(urls: [URL]) {
        prefetcher.prefetchURLs(urls)
    }
    
    func stopPrefetching() {
        prefetcher.cancelPrefetching()
    }
}

// Saved and persisted the image automatically
// So things like the profile picture you may want to persist
struct SDWebImageBootcamp: View {
    var body: some View {
        ImageLoader(
            url: "https://picsum.photos/id/237/200/300",
            size: 300
        )
        .onAppear {
//            ImagePrefetcher.instance.startPrefetching(urls: <#T##[URL]#>)
        }
    }
}

#Preview {
    SDWebImageBootcamp()
}
