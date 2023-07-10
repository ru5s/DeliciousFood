//
//  CategoryPageModel.swift
//  DeliciousFood
//
//  Created by Ruslan Ismailov on 02/07/23.
//

import Foundation
import Combine

class CategoryPageModel: ObservableObject, CategoryPageDelegate {
    
    @Published var cards: Category?
    @Published var choosedDish: Dish?
    @Published var likedDishes: [Dish] = []
    @Published var shoppingDishes: [Dish] = []
    @Published var filterArray: [Dish] = []
    
    @Published var tags: [Teg] = [.allMenu, .withRice, .withFish, .salads]
    @Published var isTagClicked = [true, false, false, false]
    
    var cancellables = Set<AnyCancellable>()
    
    var receivedValue: [Dish] = []
    
    //get data from api
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
    
    //reset other filter button when touch one of this
    func resetButtons(except index: Int) {
        for i in 0..<isTagClicked.count {
            if i != index {
                isTagClicked[i] = false
            }
        }
    }
    
    //delegate from cell
    func getChoosedDish(dish: Dish) {
        choosedDish = dish
    }
    
    //use filter
    func filterDishes(tag: String) {
        if let dishes = cards?.dishes {
            filterArray = dishes.filter({$0.tegs.contains(where: {$0.rawValue == tag})})
        } else {
            return
        }
    }
    
}

extension CategoryPageModel: Combine {
    //send data to shopping tab
    func dataStroreSharedValue() {
        DataStore.shared.value.send(shoppingDishes)
    }
    
    //recieve data from shopping tab
    func dataRecieceStoreRecieveValue() {
        DataRecieceStore.shared.recieveValue
            .sink { recieveValue in
                self.shoppingDishes = recieveValue
            }
            .store(in: &cancellables)
    }
    
    //cancellables all subscribers
    func dataCancellable(){
        cancellables.removeAll()
    }
}

//delegate from custom card with description about dish and button to add it to shopping list
extension CategoryPageModel: CategoryPageFromDishDelegate {
    
    //send shopping list when closed card
    func sendShoppingBascet() -> [Dish] {
        return shoppingDishes
    }
    
    //like of dislike dish
    func addOrRemoveLikedDish(_ dish: Dish){
        
        if let dish = likedDishes.firstIndex(where: {$0.id == dish.id}) {
            likedDishes.remove(at: dish)
        } else {
            likedDishes.append(dish)
        }
    }
    
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
    
    //add to shop list
    func addToShopping(_ dish: Dish){
        if let dish = shoppingDishes.firstIndex(where: {$0.id == dish.id}) {
            shoppingDishes.remove(at: dish)
        } else {
            shoppingDishes.append(dish)
        }
    }
    
    //checking from shoping list
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
