//
//  MenuAppView.swift
//  Projet_SwiftUI
//
//  Created by SON ESSOME MOUKOURI Ketchuskana on 16/10/2024.
//

import SwiftUI

struct MenuAppView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Menu des applications")
                    .font(.largeTitle)
                    .padding()
                
                NavigationLink(destination: ContentView()) {
                    ZStack {
                        // Image de fond
                        Image("JACKPOT")
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width - 40, height: 250)
                            .clipped()
                        
                        // Dégradé
                        LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.7)]), startPoint: .top, endPoint: .bottom)
                            .frame(height: 250)
                            .frame(maxWidth: .infinity)
                            .alignmentGuide(.bottom) { _ in 0 }

                        // Nom du jeu
                        VStack {
                            Spacer()
                            Text("Jackpot")
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                                .padding(.bottom, 10)
                        }
                        .frame(width: UIScreen.main.bounds.width - 40, height: 250, alignment: .bottom)
                    }
                    .cornerRadius(10)
                    .padding([.leading, .trailing], 20)
                }

                NavigationLink(destination: DevineChiffreView()) {
                    ZStack {
                        // Image de fond
                        Image("DEVINE CHIFFRE")
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width - 40, height: 250)
                            .clipped()
                        
                        // Dégradé
                        LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.7)]), startPoint: .top, endPoint: .bottom)
                            .frame(height: 250)
                            .frame(maxWidth: .infinity)
                            .alignmentGuide(.bottom) { _ in 0 }

                        // Nom du jeu
                        VStack {
                            Spacer()
                            Text("Devine chiffre")
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                                .padding(.bottom, 10)
                        }
                        .frame(width: UIScreen.main.bounds.width - 40, height: 250, alignment: .bottom)
                    }
                    .cornerRadius(10)
                    .padding([.leading, .trailing], 20)
                }
            }
            
            .padding(.top)
        }
    }
}

#Preview {
    MenuAppView()
}
