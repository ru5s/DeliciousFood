//
//  SearchTabSwiftUIView.swift
//  DeliciousFood
//
//  Created by Ruslan Ismailov on 01/07/23.
//

import SwiftUI

struct SearchTabSwiftUIView: View {
    
    @ObservedObject var model: SearchTabSwiftUIViewModel
    
    var body: some View {
        
        NavigationView {
            CustomNavigationBar(locations: false, navigationTitle: "Поиск блюда", locationsTitle: "Санкт Петербург", currentDate: "12 марта, 2023") {
                
                Text("\(model.name) page")
                
            }
        }
        
        
    }
}

struct SearchTabSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SearchTabSwiftUIView(model: SearchTabSwiftUIViewModel())
    }
}
