//
//  SearchTabSwiftUIView.swift
//  DeliciousFood
//
//  Created by Ruslan Ismailov on 01/07/23.
//

import SwiftUI

struct SearchTabSwiftUIView: View {
    
    @ObservedObject var model: SearchTabSwiftUIViewModel
    
    @State var searchText: String = ""
    @State var openCard: Bool = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        NavigationView {
            CustomNavigationBar(locations: false, navigationTitle: "Поиск блюда", locationsTitle: "Санкт Петербург", currentDate: "12 марта, 2023") {
                ZStack {
                    
                    if let dishModel = model.choosedDish, openCard {
                        ZStack(alignment: .center) {
                            
                            DishCard(dish: Dish(id: dishModel.id, name: dishModel.name, price: dishModel.price, weight: dishModel.weight, description: dishModel.description, imageURL: dishModel.imageURL, tegs: dishModel.tegs), inBasket: model.checkLikedDish(dishModel.id), closeCard: $openCard, delegate: model)
                                .zIndex(120)
                            
                            Rectangle()
                                .ignoresSafeArea()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .foregroundColor(Color.black
                                    .opacity(0.6))
                            
                                .onTapGesture {
                                    openCard.toggle()
                                }
                        }
                        .zIndex(100)
                    }
                    
                    VStack {
                        
                        SearchBar(text: $searchText, completition: {newValue in
                            model.searchDish(newValue)
                        })
                       
                        
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            
                            LazyVGrid(columns: columns, spacing: 5) {
                                
                                ForEach(model.searchArray, id: \.self) { dish in
                                    
                                    CategoryPageCell(dish: dish, sizeOfImage: dishCellSize, openCard: $openCard, delegate: model)
                                    
                                }
                                
                            }
                            .padding(.bottom, 30)
                        }
                        .clipped()
                        
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.horizontal, 8)
                        
                        .zIndex(5)
                        
                        Spacer()
                        
                    }
                }
                
            }
            .onAppear {
                model.getAllData()
                
                model.dataRecieceStoreRecieveValue()
                
            }
            .onDisappear {
                model.dataStroreSharedValue()
            }
            
        }
        
        
        
    }
    
    private var dishCellSize: CGFloat {
        
        let spacing: CGFloat = 170
        
        let columnCount: CGFloat = 3
        
        let totalSpacing = spacing * (columnCount - 1)
        
        let availableWidth = UIScreen.main.bounds.width - 16 - totalSpacing
        
        let cellWidth = availableWidth / columnCount
        
        return cellWidth
    }
}

struct SearchTabSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SearchTabSwiftUIView(model: SearchTabSwiftUIViewModel())
    }
}
