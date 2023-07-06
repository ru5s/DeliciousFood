//
//  MainCoordinator.swift
//  DeliciousFood
//
//  Created by Ruslan Ismailov on 01/07/23.
//

import SwiftUI
import UIKit

class MainCoordinator: Coordinator {
    var rootViewController: UITabBarController
    
    var childCoordinator = [Coordinator]()
    
    let homeTabModel = HomeSwiftUIViewModel()
    let searchTabModel = SearchTabSwiftUIViewModel()
    let shoppingTabModel = ShoppingTabSwiftUIViewModel()
    let accauntTabModel = AccauntTabSwiftUIViewModel()
    let categoryModel = CategoryPageModel()
    
    init() {
        self.rootViewController = UITabBarController()
        
        rootViewController.tabBar.isTranslucent = true
        rootViewController.tabBar.backgroundColor = .white
        rootViewController.tabBar.tintColor = .blue
    }
    
    func start() {
        let homeCoordinator = HomeTabCoordinator()
        homeCoordinator.start()
        self.childCoordinator.append(homeCoordinator)
        let homeTabVC = UIHostingController(rootView: HomeSwiftUIView(model: homeTabModel))
        homeCoordinator.homeTabModel = homeTabModel
        setupViewControllers(vc: homeTabVC,
                             title: "Главная",
                             imageName: "home default",
                             selectedImageName: "home selected")
        
        let searchTabVC = UIHostingController(rootView: SearchTabSwiftUIView(model: searchTabModel))
        setupViewControllers(vc: searchTabVC,
                             title: "Поиск",
                             imageName: "search default",
                             selectedImageName: "search selected")
        
        let shoppingCoordinator = ShoppingTabCoordinator()
        shoppingCoordinator.start()
        self.childCoordinator.append(shoppingCoordinator)
        shoppingCoordinator.shoppingModel = shoppingTabModel
        let shoppingTabVC = UIHostingController(rootView: ShoppingTabSwiftUIView(model: shoppingTabModel))
        setupViewControllers(vc: shoppingTabVC,
                             title: "Корзина",
                             imageName: "shopping default",
                             selectedImageName: "shopping selected")
        
        let accauntTabVC = UIHostingController(rootView: AccauntTabSwiftUIView(model: accauntTabModel))
        setupViewControllers(vc: accauntTabVC,
                             title: "Аккаунт",
                             imageName: "cart accaunt default",
                             selectedImageName: "cart accaunt selected")
        
        rootViewController.viewControllers = [homeTabVC, searchTabVC, shoppingTabVC, accauntTabVC]
    }
    
    func setupViewControllers(vc: UIViewController, title: String, imageName: String, selectedImageName: String) {
        
        let defaultImage = UIImage(named: imageName)
        let selectedImage = UIImage(named: selectedImageName)
        let tabBarItem = UITabBarItem(title: title, image: defaultImage, selectedImage: selectedImage)

        vc.tabBarItem = tabBarItem
        
    }
    
}
