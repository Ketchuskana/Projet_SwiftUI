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
            ZStack {
                Image("fond")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    if !viewModel.isValid {
                        VStack {
                            Text("Connectez-vous")
                                .padding(.leading, 20)
                                .font(.largeTitle)
                                .foregroundColor(.white)

                            TextField("Login", text: $login)
                                .frame(width: 246, height: 44)
                                .background(.white)
                                .textFieldStyle(RoundedBorderTextFieldStyle())

                            SecureField("Password", text: $password)
                                .frame(width: 246, height: 44)
                                .background(.white)
                                .textFieldStyle(RoundedBorderTextFieldStyle())

                            Button {
                                viewModel.checkConnection(login: login, password: password)
                            } label: {
                                Text("Se connecter")
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .padding(.top, 20)
                        }
                        .padding()
                        
                    } else {
                        NavigationLink(destination: MenuAppView()) {
                            MenuAppView()
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, 20)
            }
        }
    }
}

#Preview {
    MainView()
}
