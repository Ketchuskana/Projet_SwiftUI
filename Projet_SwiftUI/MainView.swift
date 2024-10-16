//
//  MainView.swift
//  Projet_SwiftUI
//
//  Created by SON ESSOME MOUKOURI Ketchuskana on 16/10/2024.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    
    @State var login: String = ""
    @State var password: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                if !viewModel.isValid {
                    VStack {
                        Text("Connectez-vous")
                            .padding(.leading, 20)
                        
                        TextField("Login", text: $login)
                            .frame(width: 246, height: 44)
                            .background(.white)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        TextField("Password", text: $password)
                            .frame(width: 246, height: 44)
                            .background(.white)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button {
                            viewModel.checkConnection(login: login, password: password)
                        } label: {
                            Text("Se connecter")
                        }
                    }
                } else {
                    
                    NavigationLink(destination: MenuAppView()) {
                        MenuAppView()
//                        Text("Menu")
//                            .padding()
//                            .background(.blue)
                            
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    MainView()
}
