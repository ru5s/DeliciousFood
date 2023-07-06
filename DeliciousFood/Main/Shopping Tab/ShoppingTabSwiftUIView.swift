//
//  ShoppingTabSwiftUIView.swift
//  DeliciousFood
//
//  Created by Ruslan Ismailov on 01/07/23.
//

import SwiftUI
import Combine

struct ShoppingTabSwiftUIView: View {
    
    @ObservedObject var model: ShoppingTabSwiftUIViewModel
    
    @State private var receivedValue: [Dish] = []
    @State private var cancellables = Set<AnyCancellable>()
    
    var body: some View {
        
        NavigationView {
            CustomNavigationBar(locations: true, navigationTitle: "", locationsTitle: "Санкт Петербург", currentDate: "12 марта, 2023") {
                ZStack(alignment: .bottom) {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVStack {
                            
                            ForEach(model.dishes) { dish in
                                ShopingTabCell(dish: dish, shopDelegate: model)
                            }
                            
                        }
                        
                    }
                    .padding(.top, 10)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    Button {
                        
                    } label: {
                        Text("Оплатить \(model.calculateSum()) \(Image("rouble"))")
                            .font(Resurses.Fonts.sfProDisplay_Medium(with: 20))
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 0)

                }
                
                
            }
        }
        .onAppear {
            
            DataStore.shared.value
                .sink { value in
                    self.receivedValue = value
                    self.model.updateBasket(self.receivedValue)
                    self.model.toCalculateArray(dishes: self.receivedValue, stepper: 1)
                }
                .store(in: &cancellables)
        }
        .onDisappear {
            DataRecieceStore.shared.recieveValue.send(model.sendDishes())
            
            cancellables.removeAll()
        }
    }
}

struct ShoppingTabSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingTabSwiftUIView(model: ShoppingTabSwiftUIViewModel())
    }
}
