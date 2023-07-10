//
//  FirstSwitrUIView.swift
//  DeliciousFood
//
//  Created by Ruslan Ismailov on 01/07/23.
//

import SwiftUI
import Kingfisher

struct HomeSwiftUIView: View {
    @ObservedObject var model: HomeSwiftUIViewModel
    @State private var selectedCategory: Category? = nil
    @State var isActive: Bool = false
    
    @State var titleName: String = ""
    
    @ObservedObject var coordinator: HomeTabCoordinator = HomeTabCoordinator()
    
    var body: some View {
        NavigationView {
            CustomNavigationBar(locations: true, navigationTitle: "", locationsTitle: "Санкт Петербург", currentDate: "12 марта, 2023") {
                VStack {
                    
                    ScrollView(.vertical, showsIndicators: true) {
                        
                        LazyVStack {
                            
                            ForEach((model.homeList?.сategories) ?? []) { value in
                                let name = value.name
                                
                                NavigationLink(
                                    destination: CategoryPage(titleName: self.$titleName),
                                    isActive: $isActive,
                                    label: {})
                                
                                Button(action: {
                                    isActive = true
                                    titleName = value.name
                                }) {
                                    KFImage(URL(string: value.imageURL))
                                        .resizable()
                                        .scaledToFill()
                                        .overlay(alignment: .topLeading) {
                                            
                                            GeometryReader { geometry in
                                                
                                                Text(name)
                                                    .multilineTextAlignment(.leading)
                                                    .padding(.leading, 16)
                                                    .padding(.top, 12)
                                                    .font(Resurses.Fonts.sfProDisplay_Medium(with: 20))
                                                    .lineSpacing(5)
                                                    .foregroundColor(.black)
                                                    .frame(width: geometry.size.width * 0.51, alignment: .leading)
                                                    .fixedSize(horizontal: false, vertical: true)
                                                
                                            }
                                            .frame(alignment: .leading)
                                            
                                        }
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                    
                                }
                            }
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
