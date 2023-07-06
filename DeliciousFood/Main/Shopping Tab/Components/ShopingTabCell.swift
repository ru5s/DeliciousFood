//
//  ShopingTabCell.swift
//  DeliciousFood
//
//  Created by Ruslan Ismailov on 05/07/23.
//

import SwiftUI
import Kingfisher

protocol ShoppingTabDelegate {
    func removeFromBasket(_ id: Int)
    
    func sendDishes() -> [Dish]
    
    func toCalculate(dish: Dish, stepper: Int, remove: Bool)
}

struct ShopingTabCell: View {
    
    @State var dish: Dish
    @State var stepper = 1
    
    let shopDelegate: ShoppingTabDelegate
    
    var body: some View {
        HStack(alignment: .center, spacing: 5) {
            
            KFImage(URL(string: dish.imageURL))
                .resizable()
                .scaledToFit()
                .padding(10)
                .frame(width: 100, height: 100)
                .background(Resurses.Colors.lightGray)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 5) {
                
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
                
            }
            .padding(.leading, 10)
            
            Spacer()
            
            CustomStepper(count: $stepper, min: 1, max: 5, step: 1, minCount: {
                
                shopDelegate.toCalculate(dish: dish, stepper: stepper, remove: true)
                shopDelegate.removeFromBasket(dish.id)
                DataRecieceStore.shared.recieveValue.send(shopDelegate.sendDishes())
                
            }, forSum: {
                
                shopDelegate.toCalculate(dish: dish, stepper: stepper, remove: false)
                
            })
                .padding(.trailing, 10)
                
            
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
        
    }
}

struct ShopingTabCell_Previews: PreviewProvider {
    static var previews: some View {
        ShopingTabCell(dish:
                        Dish(id: 0,
                             name: "Borsch",
                             price: 220,
                             weight: 300,
                             description: "Great soup with vegetables",
                             imageURL: "https://lh3.googleusercontent.com/fife/APg5EOb3-gGunBAb_3E7L5qZLGIx0Wm8kh4UjNn2yow-7Kvf50D7eFb9Iw5g_7W7TQLGKF29-G6VNa7dHS_zEWY8VaSMh9EqUql8UEFISB_WWgiO8nf_mt0YtUhsWFB5uzw-Bfi_eS9Cs-0vLUMiqaqTGgGFDvVhUvak4AypPMEbt2-3mEkxeZNcClEy29x8gEmUU6e9G8s5GDyCxR404OIsgnGHqtIaGIGD7afRoz7PtgtmZdlXC5v7dHujDNh5l28v249qxjpa1rqxoorBb-ywkRsu1bzqDEHGbRDnFNLXHwEGlHoLS1krz9KcD3opkmQckg7-m7PXzEhnQlayqMPiNGP-WpnFYrthFVfJ0TY4zsYFx1azSJZTLa59Xuqr32eagNn9xF6mCPpGqRbunBKrbD-oWidQ_iAXZRRrgjZrv280Joe8z73AluN0A-mXcqRkpVwQo1n3szZ00wX7sD44PriRwHGUfEenTC5IyLVv3MBsYMNXJ9ALa6FZgTrnUhO_ePGoPftELYGNp4yn-xkzfM_GvnQR8A6od0bR8AqqpNketd0kBavJTkaJXBwsfvxinTdLfOTfWsZAhF97XYNEA_9SmTgnnOjt3N8YUxmUeWcor174r7bNdDuDQqq7vWRgFZNorh5v6LANRk0CVsq6B9tVxP2R1zTCc1yXgpu4kNGJsEvNyxMRy-yM3cBvhu01ZUFSalvwAqcS2M9_eBoPCu00KVtcEvyFPoqm_QNHBEkDLjUdtJC7BGcmv7SPa-rV6oH_3zeIYstyKLrgN-Dzewe816A6J7IN4YxSvCIOWbNV9Q6O3hxua_ZrGSk6ijSoBKE0XHUC04cr1O6BzRxL9lwVUhzvBzYfzmBzMPb84Pq-WwBtfCxN2j34NReGu5iABuA1iDNgz0r8WE2Dvvz0XsD6Uc8neX57A7_19J6vyJEhuARJREXGs4tFWHMmjqg-xwYOOPJhxF1BkCaQrUEKtFYBq1pT2N7_h9fMV8JOLP92grJFHRP6TmNrEjPAf9HjfYRFouBAqFMRy614VrJu5hyweBcy-4WbJNYqrvKZH_bXIQyZ6qlv4omHhGTSMMT9cAYTyiMm12bEH5ccThAygPaXlfx6ydA3towLnMpoq0ieByM2-Nql2uh4xPxgAHcmzipRgEqlYDflDKNSfeTVFKKQ4vtTWa43wR505BTjdO3mk5CVoK4sOzwcF1mQA2joVXdW63wbUWtw4wtfa3e9EP1TV01b5M02KKPcr2yxZpNQCo8-Igp6M8t_vqWSKlkq-Z7NaRswW-xQyuFWjCufwgpd1m8i5Z4tnL72DhelmIiI2cXufJb70_eobyMV5VsMUab1nLKWoKwggolnEjl2A1PLrv6T0aRTYmjt3JqFDEV58aIjZhhyrcX6h6Bb_AJzc-OFvFPw1uAuswJaimihZUfYoVuwtNRI27BD7KGnXzMHKthOM4fArK3ICIt61g91DNHAu9qhpWxsj0FrcmujdWE2vJpBf7XoOcgxiRlRKpljQ2c3M6ULTdS1nuypZleouOtwIHOUoxGtT5HJeC8ZcsgI3przMt97iGmSv5Us7xL0j42wVNZbQnyQ6EsIyIG1ZOo2ah9CyA7RqixQUevdzbPhSnJk2w6weuuRCDkdC4H97doLyAV_=w1366-h617",
                             tegs: [.allMenu, .withRice]), shopDelegate: ShoppingTabSwiftUIViewModel())
    }
}
