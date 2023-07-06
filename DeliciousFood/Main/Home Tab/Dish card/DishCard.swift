//
//  DishCard.swift
//  DeliciousFood
//
//  Created by Ruslan Ismailov on 05/07/23.
//

import SwiftUI
import Kingfisher

protocol CategoryPageFromDishDelegate {
    func addOrRemoveLikedDish(_ dish: Dish)
    func checkLikedDish(_ id: Int) -> Bool
    func addToShopping(_ dish: Dish)
    func checkShopping(_ id: Int) -> Bool
    func sendShoppingBascet() -> [Dish]
}

struct DishCard: View {
    
    @State var dish: Dish?
    @State var isLiked: Bool = false
    @State var inBasket: Bool = false
    @Binding var closeCard: Bool
    let delegate: CategoryPageFromDishDelegate
    
    var body: some View {
        if let dish = dish {
         
        VStack(alignment: .leading) {
            KFImage(URL(string: dish.imageURL))
                .resizable()
                .scaledToFit()
                .padding(.vertical, 30)
                .frame(height: 230)
                .frame(maxWidth: .infinity)
                .background(Color(red: 0.97, green: 0.97, blue: 0.96))
                .cornerRadius(10)
                .overlay(alignment: .topTrailing) {
                    HStack(alignment: .center, spacing: 0) {
                        Group {
                            Button {
                                delegate.addOrRemoveLikedDish(dish)
                                isLiked = delegate.checkLikedDish(dish.id)
                            } label: {
                                if isLiked {
                                    Image(systemName: "heart.fill")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(Color.red)
                                    
                                } else {
                                    Image(systemName: "heart")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                }
                                
                            }
                            
                            Button {
                                DispatchQueue.main.async {
                                    withAnimation(.linear) {
                                        closeCard = false
                                    }
                                }
                                
                            } label: {
                                Image(systemName: "xmark")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                            }
                            
                        }
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(5)
                    }
                    
                }
                .padding(.top, 16)
                .padding(.horizontal, 16)
            
            Group {
                
                Text(dish.name)
                    .font(Resurses.Fonts.sfProDisplay_Medium(with: 18).bold())
                    
                
                HStack(alignment: .bottom) {
                    
                
                    Text("\(dish.price.description) \(Image("rouble"))")
                        .font(Resurses.Fonts.sfProDisplay_Regular(with: 18))
                        .lineSpacing(5)
                    
                    Text("· \(dish.weight.description)Г")
                        .font(Resurses.Fonts.sfProDisplay_Medium(with: 16))
                        .foregroundColor(Color.gray)
                }
                
                
                Text(dish.description)
                    .font(Resurses.Fonts.sfProDisplay_Medium(with: 16))
                    .foregroundColor(Color.black
                        .opacity(0.6))
                
                Button {
                    delegate.addToShopping(dish)
                    inBasket.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
                        withAnimation {
                            self.closeCard.toggle()
                        }
                    })
                } label: {
                    Text(inBasket ? "В корзине" : "Добавить в корзину")
                        .font(Resurses.Fonts.sfProDisplay_Medium(with: 20))
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .padding(.horizontal, 16)
                        .background(inBasket ? Color.green : Color.blue)
                        .cornerRadius(10)
                }
                .padding(.bottom, 16)
            }
            .padding(.vertical, 1)
            .padding(.horizontal, 16)
            
        }
        .frame(maxWidth: .infinity)
        .frame(alignment: .center)
        .background(Color.white)
        .cornerRadius(10)
        .padding(.horizontal, 16)
        .onAppear {
            inBasket = delegate.checkShopping(dish.id)
            isLiked = delegate.checkLikedDish(dish.id)
        }
        .onDisappear {
            DataStore.shared.value.send(delegate.sendShoppingBascet())
            
            
        }
    }
        
    }
}

struct DishCard_Previews: PreviewProvider {
    static var previews: some View {
        DishCard(dish:
                    Dish(id: 0,
                         name: "Borsch",
                         price: 220,
                         weight: 300,
                         description: "Рыба маринованная со специями, лимонным соком, соевым соусом и запечeнная в духовке с лучком, томатами и картошечкой под золотистой майонезно-сырной шубкой",
                         imageURL: "https://lh3.googleusercontent.com/fife/APg5EOb3-gGunBAb_3E7L5qZLGIx0Wm8kh4UjNn2yow-7Kvf50D7eFb9Iw5g_7W7TQLGKF29-G6VNa7dHS_zEWY8VaSMh9EqUql8UEFISB_WWgiO8nf_mt0YtUhsWFB5uzw-Bfi_eS9Cs-0vLUMiqaqTGgGFDvVhUvak4AypPMEbt2-3mEkxeZNcClEy29x8gEmUU6e9G8s5GDyCxR404OIsgnGHqtIaGIGD7afRoz7PtgtmZdlXC5v7dHujDNh5l28v249qxjpa1rqxoorBb-ywkRsu1bzqDEHGbRDnFNLXHwEGlHoLS1krz9KcD3opkmQckg7-m7PXzEhnQlayqMPiNGP-WpnFYrthFVfJ0TY4zsYFx1azSJZTLa59Xuqr32eagNn9xF6mCPpGqRbunBKrbD-oWidQ_iAXZRRrgjZrv280Joe8z73AluN0A-mXcqRkpVwQo1n3szZ00wX7sD44PriRwHGUfEenTC5IyLVv3MBsYMNXJ9ALa6FZgTrnUhO_ePGoPftELYGNp4yn-xkzfM_GvnQR8A6od0bR8AqqpNketd0kBavJTkaJXBwsfvxinTdLfOTfWsZAhF97XYNEA_9SmTgnnOjt3N8YUxmUeWcor174r7bNdDuDQqq7vWRgFZNorh5v6LANRk0CVsq6B9tVxP2R1zTCc1yXgpu4kNGJsEvNyxMRy-yM3cBvhu01ZUFSalvwAqcS2M9_eBoPCu00KVtcEvyFPoqm_QNHBEkDLjUdtJC7BGcmv7SPa-rV6oH_3zeIYstyKLrgN-Dzewe816A6J7IN4YxSvCIOWbNV9Q6O3hxua_ZrGSk6ijSoBKE0XHUC04cr1O6BzRxL9lwVUhzvBzYfzmBzMPb84Pq-WwBtfCxN2j34NReGu5iABuA1iDNgz0r8WE2Dvvz0XsD6Uc8neX57A7_19J6vyJEhuARJREXGs4tFWHMmjqg-xwYOOPJhxF1BkCaQrUEKtFYBq1pT2N7_h9fMV8JOLP92grJFHRP6TmNrEjPAf9HjfYRFouBAqFMRy614VrJu5hyweBcy-4WbJNYqrvKZH_bXIQyZ6qlv4omHhGTSMMT9cAYTyiMm12bEH5ccThAygPaXlfx6ydA3towLnMpoq0ieByM2-Nql2uh4xPxgAHcmzipRgEqlYDflDKNSfeTVFKKQ4vtTWa43wR505BTjdO3mk5CVoK4sOzwcF1mQA2joVXdW63wbUWtw4wtfa3e9EP1TV01b5M02KKPcr2yxZpNQCo8-Igp6M8t_vqWSKlkq-Z7NaRswW-xQyuFWjCufwgpd1m8i5Z4tnL72DhelmIiI2cXufJb70_eobyMV5VsMUab1nLKWoKwggolnEjl2A1PLrv6T0aRTYmjt3JqFDEV58aIjZhhyrcX6h6Bb_AJzc-OFvFPw1uAuswJaimihZUfYoVuwtNRI27BD7KGnXzMHKthOM4fArK3ICIt61g91DNHAu9qhpWxsj0FrcmujdWE2vJpBf7XoOcgxiRlRKpljQ2c3M6ULTdS1nuypZleouOtwIHOUoxGtT5HJeC8ZcsgI3przMt97iGmSv5Us7xL0j42wVNZbQnyQ6EsIyIG1ZOo2ah9CyA7RqixQUevdzbPhSnJk2w6weuuRCDkdC4H97doLyAV_=w1366-h617",
                         tegs: [.allMenu, .withRice]), inBasket: false, closeCard: .constant(false), delegate: CategoryPageModel())
    }
}
