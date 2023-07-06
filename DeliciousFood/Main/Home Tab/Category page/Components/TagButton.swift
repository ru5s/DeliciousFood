//
//  TagButton.swift
//  DeliciousFood
//
//  Created by Ruslan Ismailov on 05/07/23.
//

import SwiftUI

struct TagButton: View {
    @Binding var isClicked: Bool
    @State var tagRawValue: String
    var resetOtherButtons: () -> Void
    
    var body: some View {
        Button {
            self.isClicked.toggle()
            self.resetOtherButtons()
        } label: {
            Text(tagRawValue)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
            
        }
        .background(isClicked ? Color.blue : Resurses.Colors.lightGray)
        .foregroundColor(isClicked ? Color.white : Color.black)
        .cornerRadius(10)

    }
}

struct TagButton_Previews: PreviewProvider {
    static var previews: some View {
        TagButton(isClicked: .constant(false), tagRawValue: "С Рисом", resetOtherButtons: {})
    }
}
