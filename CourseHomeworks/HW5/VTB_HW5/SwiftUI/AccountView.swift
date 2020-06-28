//
//  AccountView.swift
//  VTB_HW5
//
//  Created by Anton Tolstov on 26.06.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import SwiftUI

struct AccountView: View {
    
    @State var person: Person
    
    private static let menuIconColor = Color(red: 0.384, green: 0.482, blue: 0.992)
    private static let menuIconMyDataColor = Color(red: 0.349, green: 0.655, blue: 0.843)
    private static let backgroundColor = Color(red: 0.929, green: 0.937, blue: 0.949)
    private static let borderColor = Color(red: 0.812, green: 0.808, blue: 0.824)
    private static let mailColor = Color(red: 0.646, green: 0.646, blue: 0.646)
    
    private let menuItems = [Menu(title: "Мои данные", iconColor: menuIconMyDataColor),
                             Menu(title: "Связанные соц.сети", iconColor: menuIconColor),
                             Menu(title: "Уведомления", iconColor: menuIconColor),
                             Menu(title: "Языки", iconColor: menuIconColor)]
    
    private let contactMenuItems = [Menu(title: "Обратная связь", hasIcon: false),
                                    Menu(title: "Вопросы о Followme", hasIcon: false)]
    
    var body: some View {
        //        ZStack {
        NavigationView {
            VStack (alignment: .center, spacing: 0) {
                Group { // Header
                    self.header
                    self.border
                    
                    Self.backgroundColor.frame(height: 15.5)
                }
                
                Group { // Menus
                    self.menu(with: menuItems, border: true)
                    Self.backgroundColor.frame(height: 41.5)
                    self.menu(with: contactMenuItems)
                }
                
                Spacer()
                
                ZStack (alignment: .bottom) { // Bottom menu
                    Self.backgroundColor
                    self.bottomMenu
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
        
        //        Image("example-layout").resizable().colorInvert().opacity(0.4).edgesIgnoringSafeArea(.all)
        //        }
    }
    
    private var header: some View {
        HStack {
            NavigationLink(destination: Text("Account Info")) {
                person.image
                    .resizable()
                    .clipShape(Circle())
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: 49)
            }
            .buttonStyle(PlainButtonStyle())
            
            Spacer().frame(width: 13)
            
            VStack (alignment: .leading) {
                Text("\(person.firstName) \(person.lastName)")
                    .bold()
                    .font(.system(size: 16))
                Text(person.mail)
                    .bold()
                    .font(.system(size: 10))
                    .foregroundColor(Self.mailColor)
            }
            Spacer()
            
            NavigationLink(destination: Text("Money Info")) {
                Text("\(person.money)")
                    .bold()
                    .font(.system(size: 16))
                Spacer().frame(width: 2.6)
                Image("sprites-coins")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 19)
                Spacer().frame(width: 8)
                self.arrow
            }
            .padding(.top, 3)
            .buttonStyle(PlainButtonStyle())
        }
        .padding(EdgeInsets(top: 47, leading: 20, bottom: 14, trailing: 20))
    }
    
    private func menu(with items: [Menu], border: Bool = false) -> some View {
        Group {
            if border {
                self.border
                Color.white.frame(height: 5)
            }
            
            ForEach (Array(items.enumerated()), id: \.element) { index, item in
                NavigationLink(destination: Text(item.title)) {
                    VStack (spacing: 0) {
                        self.menuRow(item)
                        
                        if index < items.count - 1 {
                            self.border
                                .padding(.leading, 59)
                        }
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            if border {
                Color.white.frame(height: 5)
                self.border
            }
        }
    }
    
    private func menuRow(_ menu: Menu) -> some View {
        HStack (spacing: 16) {
            if menu.hasIcon {
                ZStack {
                    (menu.iconColor ?? .white)
                        .aspectRatio(1, contentMode: .fit)
                        .frame(width: 27)
                        .cornerRadius(5)
                    
                    Image("sprites-person")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                        .frame(width: 13.78)
                }
            } else {
                Spacer()
                    .frame(width: 28.5)
            }
            
            Text(menu.title)
                .font(.system(size: 14))
            
            Spacer()
            
            self.arrow
        }
        .padding(EdgeInsets(top: 0, leading: 14, bottom: 0, trailing: 20))
        .frame(height: 40)
    }
    
    private var bottomMenu: some View {
        let icons = ["list-bullet", "list-check", "wallet",  "person-circle"]
        let iconWidths = [26, 27, 24, 24].map { CGFloat($0) }
        
        return ZStack {
            Color.white
                .cornerRadius(10)
            
            
            HStack (alignment: .bottom, spacing: 0) {
                ForEach (Array(icons.enumerated()), id: \.element) { index, icon in
                    Group {
                        NavigationLink(destination: Text(icon)) {
                            Image("sprites-\(icon)")
                                .resizable()
                                .scaledToFit()
                                .frame(width: iconWidths[index])
                            
                            if index < icons.count - 1 {
                                Spacer()
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }.padding(EdgeInsets(top: 0, leading: 35, bottom: 0, trailing: 36))
        }
        .frame(height: 57)
        .padding(EdgeInsets(top: 0, leading: 33, bottom: 34, trailing: 31))
    }
    
    private var border: some View  {
        Self.borderColor.frame(height: 0.5)
    }
    
    
    private var arrow: some View {
        Image("sprites-arrow-right")
            .resizable()
            .scaledToFit()
            .frame(height: 13)
            .padding(.top, 2)
    }
    
    // MARK: - Model
    
    struct Person {
       var image: Image
       var firstName: String
       var lastName: String
       var mail: String
       var money: Int
    }
       
   struct Menu: Identifiable, Hashable {
       let id = UUID()
       
       var title: String
       var hasIcon = true
       var iconColor: Color?
   }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach (["iPhone 11 Pro Max", "iPhone 8", "iPhone SE (1st generation)"], id: \.self) { model in
            AccountView(person: .init(image: Image("example-avatar"),
                                       firstName: "Ishxan",
                                       lastName: "Aslanyan",
                                       mail: "Ishxan.aslanyan@mail.ru",
                                       money: 15))
                .previewDevice(PreviewDevice(rawValue: model))
                .previewDisplayName(model)
            
        }
    }
}
