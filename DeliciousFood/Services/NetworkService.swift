//
//  NetworkService.swift
//  DeliciousFood
//
//  Created by Ruslan Ismailov on 02/07/23.
//

import Foundation
import UIKit

enum UrlRequestMode {
    case home
    case category
}

final class NetworkService {
    
    static let shared = NetworkService()
    
    let url: String = "https://run.mocky.io/v3/"
    
    
    
    func request (mode: UrlRequestMode, completition: @escaping (HomeList?, Category?, Error?) -> Void) {
        
        var modeUrl: String = ""
        
        switch mode {
        case .home:
            modeUrl = "058729bd-1402-4578-88de-265481fd7d54"
        case .category:
            modeUrl = "aba7ecaa-0a70-453b-b62d-0e326c859b3b"
        }
        
        guard let componentsUrl: URL = URL(string: url + modeUrl) else {return}
        
        let task = URLSession.shared.dataTask(with: componentsUrl) { data, response, error in
            
            guard let unwrData = data,
                  (response as? HTTPURLResponse)?.statusCode == 200,
                  error == nil else {
                
                print("error http url response \(String(describing: error?.localizedDescription))")
                return
            }
            
            do {
                
                var decodeData: Any?
                
                switch mode {
                case .home:
                    decodeData = try JSONDecoder().decode(HomeList.self, from: unwrData)
                case .category:
                    decodeData = try JSONDecoder().decode(Category.self, from: unwrData)
                }
                
                if let result = decodeData {
                    
                    switch mode {
                    case .home:
                        completition(result as? HomeList, nil, nil)
                    case .category:
                        completition(nil, result as? Category, nil)
                    }
                    
                } else {
                    completition(nil, nil, error)
                }
                
            } catch let error {
                
                print("task error \(error)")
                completition(nil, nil, error)
            }
            
        }
        task.resume()
    }
    
}
