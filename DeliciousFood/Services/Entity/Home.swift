//
//  Home.swift
//  DeliciousFood
//
//  Created by Ruslan Ismailov on 02/07/23.
//

import Foundation

struct HomeList: Codable {
    let сategories: [HomeСategory]
}

struct HomeСategory: Codable, Identifiable {
    let id: Int
    let name: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "image_url"
    }
}
