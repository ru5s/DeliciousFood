//
//  ShoppingTabSwiftUIView.swift
//  DeliciousFood
//
//  Created by Ruslan Ismailov on 01/07/23.
//

import SwiftUI

struct ShoppingTabSwiftUIView: View {
    
    @ObservedObject var model: ShoppingTabSwiftUIViewModel
    
    var body: some View {
        
        NavigationView {
            CustomNavigationBar(locations: true, navigationTitle: "", locationsTitle: "Санкт Петербург", currentDate: "12 марта, 2023") {
                
                Text("\(model.name) page")
                
            }
        }
    }
}

struct ShoppingTabSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingTabSwiftUIView(model: ShoppingTabSwiftUIViewModel())
    }
}
