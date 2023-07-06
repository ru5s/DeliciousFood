//
//  CategoryPageModel.swift
//  DeliciousFood
//
//  Created by Ruslan Ismailov on 02/07/23.
//

import Foundation

class CategoryPageModel: ObservableObject, CategoryPageDelegate {
    
    @Published var cards: Category?
    @Published var choosedDish: Dish?
    @Published var bindCard: Bool?
    @Published var likedDishes: [Dish] = []
    @Published var shoppingDishes: [Dish] = []
    @Published var filterArray: [Dish] = []
    
    func getCategoryDish() {
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
                    self.cards = category
                    self.filterArray = category.dishes
                }
            }
        }
    }
    
    func getChoosedDish(dish: Dish) {
        choosedDish = dish
    }
    
    func bindingOpenCard(bool: Bool) {
        bindCard = bool
    }
    
    func filterDishes(tag: String) {
        if let dishes = cards?.dishes {
            filterArray = dishes.filter({$0.tegs.contains(where: {$0.rawValue == tag})})
        } else {
            return
        }
    }
    
    func updateShopList(_ dishes: [Dish]){
        shoppingDishes = dishes
    }
}

extension CategoryPageModel: CategoryPageFromDishDelegate {
    
    func sendShoppingBascet() -> [Dish] {
        return shoppingDishes
    }
    
    func addOrRemoveLikedDish(_ dish: Dish){
        
        if let dish = likedDishes.firstIndex(where: {$0.id == dish.id}) {
            likedDishes.remove(at: dish)
        } else {
            likedDishes.append(dish)
        }
    }
    
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
    
    func addToShopping(_ dish: Dish){
        if let dish = shoppingDishes.firstIndex(where: {$0.id == dish.id}) {
            shoppingDishes.remove(at: dish)
        } else {
            shoppingDishes.append(dish)
        }
    }
    
    func checkShopping(_ id: Int) -> Bool{

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
    
}
