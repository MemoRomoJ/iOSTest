//
//  EnvironmentValues+ImageCache.swift
//  AsyncImage
//
//  Created by Vadim Bulavin on 3/24/20.
//  Copyright © 2020 Vadym Bulavin. All rights reserved.
//

import SwiftUI

#if !os(macOS)
struct ImageCacheKey: EnvironmentKey {
    static let defaultValue: ImageCache = TemporaryImageCache()
}

extension EnvironmentValues {
    var imageCache: ImageCache {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}
#endif
