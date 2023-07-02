//
//  ApplicationCoordinator.swift
//  DeliciousFood
//
//  Created by Ruslan Ismailov on 01/07/23.
//

import SwiftUI
import UIKit
import Combine

class ApplicationCoordinator: Coordinator {
    
    let window: UIWindow
    
    var childCoordinator = [Coordinator]()
    
    init(window: UIWindow) {
        
        self.window = window
        
    }
    
    func start() {
        
        let mainCoordinator = MainCoordinator()
        mainCoordinator.start()
        self.childCoordinator = [mainCoordinator]
        self.window.rootViewController = mainCoordinator.rootViewController
        
    }
    
    
}
