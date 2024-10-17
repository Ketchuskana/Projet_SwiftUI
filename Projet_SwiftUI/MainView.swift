//
//  MainView.swift
//  Projet_SwiftUI
//
//  Created by SON ESSOME MOUKOURI Ketchuskana on 16/10/2024.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    
    @State private var login: String = ""
    @State private var password: String = ""
    @State private var isHovering = false
    
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
                                .padding(.bottom, 30)
                            
                            TextField("", text: $login, prompt: Text("Login").foregroundColor(.white.opacity(0.8)).font(.system(size: 18, weight: .semibold)))
                                .multilineTextAlignment(TextAlignment.center)
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(10)
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white, lineWidth: 1))
                                .foregroundColor(.purple)
                                .padding(.horizontal, 20)
                            
                            SecureField("", text: $password, prompt: Text("Password").foregroundColor(.white.opacity(0.8)).font(.system(size: 18, weight: .semibold)))
                                .multilineTextAlignment(TextAlignment.center)
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(10)
                                .overlay(RoundedRectangle(cornerRadius:10)
                                    .stroke(Color.white,lineWidth: 1) )
                                .foregroundColor(.purple)
                                .padding(.horizontal, 20)
                            
                            Button(action: {
                                viewModel.checkConnection(login: login, password: password)
                            }) {
                                Text("Se connecter")
                                    .font(.headline)
                                    .padding()
                                    .frame(width: 300, height: 50)
                                    .background(isHovering ? Color.green : Color.blue.opacity(0.8))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .scaleEffect(isHovering ? 1.1 : 1.0)
                                    .animation(.easeInOut(duration: 0.2), value: isHovering)
                            }
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                            .onHover { hovering in
                                isHovering = hovering
                            }}
                        .padding()
                        
                    } else {
                        NavigationLink(destination: LandingPageView(userName: viewModel.userName)) {
                            LandingPageView(userName: viewModel.userName)
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
