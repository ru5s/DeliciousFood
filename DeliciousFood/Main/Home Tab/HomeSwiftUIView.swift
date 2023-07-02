//
//  FirstSwitrUIView.swift
//  DeliciousFood
//
//  Created by Ruslan Ismailov on 01/07/23.
//

import SwiftUI

struct HomeSwiftUIView: View {
    
    @ObservedObject var model: HomeSwiftUIViewModel
    
    var body: some View {
        NavigationView {
            CustomNavigationBar(locations: true, navigationTitle: "", locationsTitle: "Санкт Петербург", currentDate: "12 марта, 2023") {
                VStack {
                    
                    ScrollView(.vertical, showsIndicators: true) {
                        
                        ForEach((model.homeList?.сategories) ?? []) { value in
                            imageByUrl(url: value.imageURL)
                                .resizable()
                                .scaledToFill()
                                .overlay(alignment: .topLeading) {
                                    GeometryReader { geometry in
                                       
                                        Text(value.name)
                                            .padding(.leading, 16)
                                            .padding(.top, 12)
                                            .font(Fonts.sfProDisplay_Medium(with: 20))
                                            .lineSpacing(5)
                                            .frame(width: geometry.size.width * 0.51, alignment: .leading)
                                    }
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                        }
                    }
                    .padding(.top, 3)
                }
                
            }
        }
    }
}

struct HomeSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeSwiftUIView(model: HomeSwiftUIViewModel())
    }
}
