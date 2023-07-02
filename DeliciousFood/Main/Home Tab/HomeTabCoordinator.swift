//
//  FirstTabCoordinator.swift
//  DeliciousFood
//
//  Created by Ruslan Ismailov on 01/07/23.
//

import UIKit
import Combine
import SwiftUI

class HomeTabCoordinator: Coordinator {
    
    let rootViewController = UINavigationController()
    
    let networkService = NetworkService()
    
    var homeTabModel = HomeSwiftUIViewModel()
    
    func start() {
        firstRequestApi()
    }
    
    private func firstRequestApi() {
        NetworkService.shared.request(mode: .home) {[weak self] homeList, category, error in
            guard let self = self else {return}
            if error != nil {
                print("error request \(String(describing: error?.localizedDescription))")
            } else {
                guard let homeList = homeList else {
                    print("error: HomeList items empty")
                    return
                }
                
                DispatchQueue.main.async {
                    self.homeTabModel.homeList = homeList
                }
            }
        }
    }
    
}
