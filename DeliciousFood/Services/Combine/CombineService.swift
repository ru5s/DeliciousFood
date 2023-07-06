//
//  CombineService.swift
//  DeliciousFood
//
//  Created by Ruslan Ismailov on 06/07/23.
//

import Combine

class DataStore {
    static let shared = DataStore()
    
    private init() {}
    
    var value = CurrentValueSubject<[Dish], Never>([])
    var recieveValue = CurrentValueSubject<[Dish], Never>([])
}

class DataRecieceStore {
    static let shared = DataRecieceStore()
    
    private init() {}
    
    var recieveValue = CurrentValueSubject<[Dish], Never>([])
}
