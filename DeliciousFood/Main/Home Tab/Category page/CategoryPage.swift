//
//  CategoryPage.swift
//  DeliciousFood
//
//  Created by Ruslan Ismailov on 02/07/23.
//

import SwiftUI
import Kingfisher

struct CategoryPage: View {
    
    @ObservedObject var model: CategoryPageModel = CategoryPageModel()
    @Binding var titleName: String
    @State var openCard: Bool = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            
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
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                LazyHStack(alignment: .center, spacing: 5) {
                    
                    ForEach(model.isTagClicked.indices, id: \.self) { tag in
                        
                        TagButton(isClicked: $model.isTagClicked[tag], tagRawValue: model.tags[tag].rawValue, resetOtherButtons: {
                            
                            self.model.resetButtons(except: tag)
                            
                            self.model.filterDishes(tag: model.tags[tag].rawValue)
                        })
                        
                    }
                    
                    
                }
                
            }
            .padding(.horizontal, 8)
            .frame(height: 50)
            .zIndex(10)
            
            ScrollView(.vertical, showsIndicators: false) {
                
                LazyVGrid(columns: columns, spacing: 5) {
                    
                    ForEach(model.filterArray, id: \.self) { dish in
                        
                        CategoryPageCell(dish: dish, sizeOfImage: dishCellSize, openCard: $openCard, delegate: model)
                        
                        
                    }
                    
                }
                .offset(y: 55)
                .padding(.bottom, 30)
            }
            .clipped()
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 8)
            
            .zIndex(5)
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(titleName)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                
                Image("user icon")
                    .resizable()
                    .frame(width: 44, height: 44, alignment: .center)
            }
            
        }
        .onAppear {
            model.dataStroreSharedValue()
            model.dataRecieceStoreRecieveValue()
            model.getCategoryDish()
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

struct CategoryPage_Previews: PreviewProvider {
    static var previews: some View {
        CategoryPage(titleName: .constant("Кухня времени"))
    }
}
