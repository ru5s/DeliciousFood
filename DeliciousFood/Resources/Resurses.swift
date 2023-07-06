//
//  Resurses.swift
//  DeliciousFood
//
//  Created by Ruslan Ismailov on 02/07/23.
//

import SwiftUI

enum Resurses {
    
    enum Fonts {
        static func sfProDisplay_Medium(with size: CGFloat) -> Font {
            Font.custom("SF Pro Display", size: size)
        }
        
        static func sfProDisplay_Regular(with size: CGFloat) -> Font {
            Font.custom("SF Pro Display", size: size).weight(.regular)
        }
    }

    enum Colors {
        static let lightGray = Color(red: 0.97, green: 0.97, blue: 0.96)
    }
}
