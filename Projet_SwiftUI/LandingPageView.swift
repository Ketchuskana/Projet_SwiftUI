//
//  LandingPageView.swift
//  Projet_SwiftUI
//
//  Created by SON ESSOME MOUKOURI Ketchuskana on 17/10/2024.
//

import SwiftUI

struct LandingPageView: View {
    var userName: String
    
    var body: some View {
        ZStack {
            Image("fond")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                Text("Bienvenue, \(userName)!")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.top, 40)
                
                NavigationLink(destination: MenuAppView()) {
                    Text("Découvrir les applications")
                        .padding()
                        .font(.title2)
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.black)
                                .shadow(radius: 10)
                        )
                        .padding(.horizontal, 20)
                        .scaleEffect(1.1)
                        .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: 1.1)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    LandingPageView(userName: "Jean")
}

