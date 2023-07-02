//
//  Category.swift
//  DeliciousFood
//
//  Created by Ruslan Ismailov on 02/07/23.
//

import Foundation

struct Category: Codable {
    let dishes: [Dish]
}

struct Dish: Codable, Identifiable {
    let id: Int
    let name: String
    let price, weight: Int
    let description: String
    let imageURL: String
    let tegs: [Teg]

    enum CodingKeys: String, CodingKey {
        case id, name, price, weight, description
        case imageURL = "image_url"
        case tegs
    }
}

enum Teg: String, Codable {
    case allMenu = "Все меню"
    case withRice = "С рисом"
    case withFish = "С рыбой"
    case salads = "Салаты"
}
