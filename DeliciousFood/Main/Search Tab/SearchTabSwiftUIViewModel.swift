//
//  SearchTabSwiftUIViewModel.swift
//  DeliciousFood
//
//  Created by Ruslan Ismailov on 01/07/23.
//

import Foundation
import Combine

class SearchTabSwiftUIViewModel: ObservableObject {
    
    @Published var name: String = "Search"
    @Published var choosedDish: Dish?
    @Published var likedDishes: [Dish] = []
    @Published var searchArray: [Dish] = []
    @Published var allDishes: [Dish] = []
    
    @Published var shoppingDishes: [Dish] = []
    
    var cancellables = Set<AnyCancellable>()
    
    //checking liked dish
    func checkLikedDish(_ id: Int) -> Bool {
        if likedDishes.isEmpty {
            return false
        } else {
            if (likedDishes.filter({$0.id == id}).first != nil) {
                return true
            } else {
                return false
            }
        }
    }
    
    func getAllData(){
        if searchArray.isEmpty {
            NetworkService.shared.request(mode: .category) {[weak self] homeList, category, error in
                guard let self = self else {return}
                if error != nil {
                    print("error request \(String(describing: error?.localizedDescription))")
                } else {
                    guard let category = category else {
                        print("error: HomeList items empty")
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.allDishes = category.dishes
                        self.searchArray = category.dishes
                    }
                }
            }
        }
    }
    
    func searchDish(_ text: String){
        text.isEmpty ? (searchArray = allDishes) : (searchArray = allDishes.filter({$0.name.contains(text)}))
    }
}

extension SearchTabSwiftUIViewModel: CategoryPageFromDishDelegate {
    
    func addOrRemoveLikedDish(_ dish: Dish) {
        if let dish = likedDishes.firstIndex(where: {$0.id == dish.id}) {
            likedDishes.remove(at: dish)
        } else {
            likedDishes.append(dish)
        }
    }
    
    func addToShopping(_ dish: Dish) {
        if let dish = shoppingDishes.firstIndex(where: {$0.id == dish.id}) {
            shoppingDishes.remove(at: dish)
        } else {
            shoppingDishes.append(dish)
        }
    }
    
    func checkShopping(_ id: Int) -> Bool {
        if shoppingDishes.isEmpty {
            return false
            
        } else {
            
            if (shoppingDishes.filter({$0.id == id}).first != nil) {
                return true
            } else {
                return false
            }
        }
    }
    
    func sendShoppingBascet() -> [Dish] {
        return shoppingDishes
    }
    
}

extension SearchTabSwiftUIViewModel: CategoryPageDelegate {
    func getChoosedDish(dish: Dish) {
        choosedDish = dish
    }
    
}

extension SearchTabSwiftUIViewModel: Combine {
    func dataStroreSharedValue() {
        DataStore.shared.value.send(shoppingDishes)
    }
    
    func dataRecieceStoreRecieveValue() {
        DataRecieceStore.shared.recieveValue
            .sink { recieveValue in
                self.shoppingDishes = recieveValue
            }
            .store(in: &cancellables)
    }
    
    func dataCancellable() {
        cancellables.removeAll()
    }
    
    
}
