//
//  CustomNavigationBar.swift
//  DeliciousFood
//
//  Created by Ruslan Ismailov on 01/07/23.
//

import SwiftUI

struct CustomNavigationBar<Content: View>: View {
    
    @State var locations: Bool = false
    @State var navigationTitle: String
    @State var locationsTitle: String
    @State var currentDate: String 
    var content: () -> Content
    
    init(locations: Bool = false,
         navigationTitle: String = "Current",
         locationsTitle: String = "Санкт Петербург",
         currentDate: String = "12 Августа, 2023",
         @ViewBuilder content: @escaping () -> Content = {Spacer() as? Content}) {
        self.locations = locations
        self.content = content
        self.navigationTitle = navigationTitle
        self.locationsTitle = locationsTitle
        self.currentDate = currentDate
    }
    
    var body: some View {
        
        ZStack {
            content()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle(!locations ? navigationTitle : "")
        .navigationBarTitleDisplayMode(.inline)
        .background(.white)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                
                Image("user icon")
                    .resizable()
                    .frame(width: 44, height: 44, alignment: .center)
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                if locations {
                    HStack(alignment: .top){
                        Image("location")
                            .padding(.top, 5)
                            .foregroundColor(.accentColor)
                        
                        VStack(alignment: .leading) {
                            Text(locationsTitle)
                                .font(Font.system(size: 18, weight: .medium))
                            Text(currentDate)
                                .font(Font.system(size: 14))
                                .foregroundColor(.accentColor.opacity(0.5))
                        }
                    }
                }
            }
        }
        
        
    }
}

struct CustomNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
            CustomNavigationBar(locations: true) {
        }
        
    }
}
