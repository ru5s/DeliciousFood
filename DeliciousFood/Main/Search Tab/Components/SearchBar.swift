//
//  SearchBar.swift
//  DeliciousFood
//
//  Created by Ruslan Ismailov on 10/07/23.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var text: String
    var completition: (String) -> Void
    
    var body: some View {
        HStack {
            
            TextField("Поиск продукта...", text: $text)
                .padding(.horizontal)
                .padding(.vertical, 7)
                .onChange(of: text) { newValue in
                    completition(newValue)
                }
            
            Button {
                text = ""
            } label: {
                Image(systemName: "xmark.circle")
                    .imageScale(.large)
                    .padding(.trailing, 8)
                    .foregroundColor(text.count > 0 ? Color.blue : Color.gray.opacity(0.5))
            }
            
        }
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.top, 10)
        .padding(.horizontal, 8)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""), completition: {_ in })
    }
}
