//
//  CustomStepper.swift
//  DeliciousFood
//
//  Created by Ruslan Ismailov on 06/07/23.
//

import SwiftUI

struct CustomStepper: View {
    @Binding var count: Int
    @State var min: Int = 0
    @State var max: Int = 5
    @State var step: Int = 1
    
    var minCount: () -> Void
    var forSum: () -> Void
    
    var body: some View {
        HStack(alignment: .center, spacing: 5) {
            
            Button {
                if count < max {
                    count += step
                    forSum()
                }
            } label: {
                Image(systemName: "plus")
                    .foregroundColor((count == max) ? Color.gray : Color.black)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 5)
            }
            
            Spacer()
            
            Text("\(count.description)")
                .font(Resurses.Fonts.sfProDisplay_Medium(with: 16))
            
            Spacer()
            
            Button {
                
                if count > min{
                    count -= step
                    forSum()
                    
                } else {
                    self.minCount()
                }
                
            } label: {
                Image(systemName: "minus")
                    .foregroundColor((count == min) ? Color.gray : Color.black)
                    .padding(.vertical, 15)
                    .padding(.horizontal, 5)
            }
            

        }
        .background(Resurses.Colors.lightGray)
        .cornerRadius(10)
        .frame(maxWidth: 120)
    }
}

struct CustomStepper_Previews: PreviewProvider {
    static var previews: some View {
        CustomStepper(count: .constant(1), minCount: {}, forSum: {})
    }
}
