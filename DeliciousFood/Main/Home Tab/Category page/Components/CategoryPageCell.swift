//
//  CategoryPageCell.swift
//  DeliciousFood
//
//  Created by Ruslan Ismailov on 03/07/23.
//

import SwiftUI
import Kingfisher

protocol CategoryPageDelegate: AnyObject {
    func getChoosedDish(dish: Dish)
    func bindingOpenCard(bool: Bool)
}

struct CategoryPageCell: View {
    
    @State var dish: Dish
    @State var sizeOfImage: CGFloat
    @Binding var openCard: Bool
    @State private var opacity: CGFloat = 0.0
    @Binding var updateCell: Bool
    
    var delegate: CategoryPageDelegate
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Resurses.Colors.lightGray)
                .clipped()
                .overlay(alignment: .center) {
                    
                    KFImage(URL(string: dish.imageURL))
                        .resizable()
                        .scaledToFit()
                        .padding(8)
                    
                }
                .aspectRatio(1, contentMode: .fill)
                .frame(alignment: .center)
            
            Text(dish.name)
                .font(Resurses.Fonts.sfProDisplay_Regular(with: 16))
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
                .frame(height: 50, alignment: .top)
            
        }
        .onTapGesture {
            
            openCard = true
            
            delegate.getChoosedDish(dish: dish)
        }
        .opacity(opacity)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + (0.02 * Double(dish.id)), execute: {
                withAnimation(.spring(response: 1.0, dampingFraction: 0.5, blendDuration: 0.5)) {
                    self.opacity = 1.0
                }
            })
        }
    }
}

struct CategoryPageCell_Previews: PreviewProvider {
    static var previews: some View {
        CategoryPageCell(dish:
                            Dish(id: 0,
                                 name: "Borsch",
                                 price: 220,
                                 weight: 300,
                                 description: "Great soup with vegetables",
                                 imageURL: "https://lh3.googleusercontent.com/fife/APg5EOb3-gGunBAb_3E7L5qZLGIx0Wm8kh4UjNn2yow-7Kvf50D7eFb9Iw5g_7W7TQLGKF29-G6VNa7dHS_zEWY8VaSMh9EqUql8UEFISB_WWgiO8nf_mt0YtUhsWFB5uzw-Bfi_eS9Cs-0vLUMiqaqTGgGFDvVhUvak4AypPMEbt2-3mEkxeZNcClEy29x8gEmUU6e9G8s5GDyCxR404OIsgnGHqtIaGIGD7afRoz7PtgtmZdlXC5v7dHujDNh5l28v249qxjpa1rqxoorBb-ywkRsu1bzqDEHGbRDnFNLXHwEGlHoLS1krz9KcD3opkmQckg7-m7PXzEhnQlayqMPiNGP-WpnFYrthFVfJ0TY4zsYFx1azSJZTLa59Xuqr32eagNn9xF6mCPpGqRbunBKrbD-oWidQ_iAXZRRrgjZrv280Joe8z73AluN0A-mXcqRkpVwQo1n3szZ00wX7sD44PriRwHGUfEenTC5IyLVv3MBsYMNXJ9ALa6FZgTrnUhO_ePGoPftELYGNp4yn-xkzfM_GvnQR8A6od0bR8AqqpNketd0kBavJTkaJXBwsfvxinTdLfOTfWsZAhF97XYNEA_9SmTgnnOjt3N8YUxmUeWcor174r7bNdDuDQqq7vWRgFZNorh5v6LANRk0CVsq6B9tVxP2R1zTCc1yXgpu4kNGJsEvNyxMRy-yM3cBvhu01ZUFSalvwAqcS2M9_eBoPCu00KVtcEvyFPoqm_QNHBEkDLjUdtJC7BGcmv7SPa-rV6oH_3zeIYstyKLrgN-Dzewe816A6J7IN4YxSvCIOWbNV9Q6O3hxua_ZrGSk6ijSoBKE0XHUC04cr1O6BzRxL9lwVUhzvBzYfzmBzMPb84Pq-WwBtfCxN2j34NReGu5iABuA1iDNgz0r8WE2Dvvz0XsD6Uc8neX57A7_19J6vyJEhuARJREXGs4tFWHMmjqg-xwYOOPJhxF1BkCaQrUEKtFYBq1pT2N7_h9fMV8JOLP92grJFHRP6TmNrEjPAf9HjfYRFouBAqFMRy614VrJu5hyweBcy-4WbJNYqrvKZH_bXIQyZ6qlv4omHhGTSMMT9cAYTyiMm12bEH5ccThAygPaXlfx6ydA3towLnMpoq0ieByM2-Nql2uh4xPxgAHcmzipRgEqlYDflDKNSfeTVFKKQ4vtTWa43wR505BTjdO3mk5CVoK4sOzwcF1mQA2joVXdW63wbUWtw4wtfa3e9EP1TV01b5M02KKPcr2yxZpNQCo8-Igp6M8t_vqWSKlkq-Z7NaRswW-xQyuFWjCufwgpd1m8i5Z4tnL72DhelmIiI2cXufJb70_eobyMV5VsMUab1nLKWoKwggolnEjl2A1PLrv6T0aRTYmjt3JqFDEV58aIjZhhyrcX6h6Bb_AJzc-OFvFPw1uAuswJaimihZUfYoVuwtNRI27BD7KGnXzMHKthOM4fArK3ICIt61g91DNHAu9qhpWxsj0FrcmujdWE2vJpBf7XoOcgxiRlRKpljQ2c3M6ULTdS1nuypZleouOtwIHOUoxGtT5HJeC8ZcsgI3przMt97iGmSv5Us7xL0j42wVNZbQnyQ6EsIyIG1ZOo2ah9CyA7RqixQUevdzbPhSnJk2w6weuuRCDkdC4H97doLyAV_=w1366-h617",
                                 tegs: [.allMenu, .withRice]), sizeOfImage: 100, openCard: .constant(false), updateCell: .constant(false), delegate: CategoryPageModel())
    }
}
