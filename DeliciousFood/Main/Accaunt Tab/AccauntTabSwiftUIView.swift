//
//  AccauntTabSwiftUIView.swift
//  DeliciousFood
//
//  Created by Ruslan Ismailov on 01/07/23.
//

import SwiftUI

struct AccauntTabSwiftUIView: View {
    
    @ObservedObject var model: AccauntTabSwiftUIViewModel
    
    var body: some View {
        NavigationView {
            CustomNavigationBar(locations: true, navigationTitle: "", locationsTitle: "Санкт Петербург", currentDate: "12 марта, 2023") {
                
                Text("\(model.name) page")
                
            }
        }
    }
}

struct AccauntTabSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        AccauntTabSwiftUIView(model: AccauntTabSwiftUIViewModel())
    }
}
