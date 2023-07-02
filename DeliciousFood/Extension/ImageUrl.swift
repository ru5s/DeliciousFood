//
//  ImageUrl.swift
//  DeliciousFood
//
//  Created by Ruslan Ismailov on 02/07/23.
//

import SwiftUI

extension View {
    
    func imageByUrl(url: String) -> Image {
        if let url = URL(string: url), let imageData = try? Data(contentsOf: url), let uiImage = UIImage(data: imageData) {
                    return Image(uiImage: uiImage)
                }
        return Image(systemName: "scribble.variable")
    }
    
}
