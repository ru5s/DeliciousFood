//
//  FirstTabCoordinator.swift
//  DeliciousFood
//
//  Created by Ruslan Ismailov on 01/07/23.
//

import UIKit
import Combine
import SwiftUI

class HomeTabCoordinator: NSObject, Coordinator, ObservableObject, UINavigationControllerDelegate {
    
    var rootViewController = UINavigationController()
    
    let networkService = NetworkService()
    
    var homeTabModel = HomeSwiftUIViewModel()
    
    
    
    override init() {
        super.init()
        rootViewController = UINavigationController()
    }
    
    lazy var homeTab: HomeSwiftUIView = {
        var vc = HomeSwiftUIView(model: self.homeTabModel)
        vc.model = self.homeTabModel
        return vc
    }()
    
    func start() {
        
        homeTab.model = homeTabModel
        
        firstRequestApi()
        
        rootViewController.delegate = self
        
        let homeVC = UIHostingController(rootView: homeTab)
        rootViewController.setViewControllers([homeVC], animated: false)

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
    
    func goToCategoryPage(name: String) -> some View {
        
        let categoryPage = CategoryPage(categoryName: name, titleName: .constant(""))
        
        return categoryPage
        
    }
    
}
