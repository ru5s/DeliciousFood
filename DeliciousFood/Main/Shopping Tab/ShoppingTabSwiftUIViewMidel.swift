//
//  ShoppingTabSwiftUIViewMidel.swift
//  DeliciousFood
//
//  Created by Ruslan Ismailov on 01/07/23.
//

import Foundation
import Combine

struct Calulate {
    
    let dish: Dish
    var count: Int
    
}

class ShoppingTabSwiftUIViewModel: ObservableObject {
    
    @Published var name: String = "Shopping"
    @Published var dishes: [Dish] = []
    @Published var dishesToCalculate: [Calulate] = []
    
    func checkDishInBasket(_ dish: [Dish]){
        
        guard let dish = dish.first else {return}
        
        if let haveDish = dishes.firstIndex(where: {$0.id == dish.id}) {
            dishes.remove(at: haveDish)
        } else {
            dishes.append(dish)
        }
        
    }
    
    func updateBasket(_ dishes: [Dish]) {
        self.dishes = dishes
    }
    
    func calculateSum() -> String{
        var count: Int = 0
        
        for dish in dishesToCalculate {
            var tempInt = dish.dish.price * dish.count
            count += tempInt
            
        }
        
        return String(count)
    }
}

extension ShoppingTabSwiftUIViewModel: ShoppingTabDelegate {
    func removeFromBasket(_ id: Int) {

        if let dish = dishes.firstIndex(where: {$0.id == id}) {
            dishes.remove(at: dish)
        }

    }
    
    func sendDishes() -> [Dish] {
        return dishes
    }
    
    func toCalculate(dish: Dish, stepper: Int, remove: Bool) {
        if remove {
            
            if let checkDish = dishesToCalculate.firstIndex(where: {$0.dish.id == dish.id}) {
                dishesToCalculate.remove(at: checkDish)
            }
            
        } else {
            
            if let checkDish = dishesToCalculate.firstIndex(where: {$0.dish.id == dish.id}) {
                dishesToCalculate[checkDish].count = stepper
            } else {
                dishesToCalculate.append(Calulate(dish: dish, count: stepper))
            }
        }
    }
    
    func toCalculateArray(dishes: [Dish], stepper: Int) {
        
        for dish in dishes {
            
            if let _ = dishesToCalculate.firstIndex(where: {$0.dish.id == dish.id}) {

            } else {
                dishesToCalculate.append(Calulate(dish: dish, count: stepper))
            }
            
        }
         
    }
}
