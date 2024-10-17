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
            ZStack {
                // Image de fond pour l'ensemble de la vue
                Image("fond_menu")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack() {
                    
                    Text("Nos minis jeux")
                        .font(.largeTitle)
                        .padding()
                    
                    // Bouton de navigation vers le jeu "Jackpot"
                    NavigationLink(destination: ContentView()) {
                        ZStack {
                            // Image de fond pour le bouton
                            Image("JACKPOT")
                                .resizable()
                                .scaledToFill()
                                .frame(width: UIScreen.main.bounds.width - 40, height: 250)
                                .clipped()
                            
                            // Dégradé pour améliorer la lisibilité du texte
                            LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.8)]), startPoint: .top, endPoint: .bottom)
                                .frame(width: UIScreen.main.bounds.width - 40, height: 250)
                                .cornerRadius(10)

                            // Texte pour le nom du jeu
                            Text("Jackpot")
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                                .padding(.bottom, 10)
                                .frame(width: UIScreen.main.bounds.width - 40, height: 250, alignment: .bottom)
                        }
                        .cornerRadius(10)
                        .padding([.leading, .trailing], 20)
                    }

                    // Bouton de navigation vers le jeu "Devine chiffre"
                    NavigationLink(destination: DevineChiffreView()) {
                        ZStack {
                            // Image de fond pour le bouton
                            Image("DEVINE CHIFFRE")
                                .resizable()
                                .scaledToFill()
                                .frame(width: UIScreen.main.bounds.width - 40, height: 220)
                                .clipped()
                            
                            // Dégradé pour améliorer la lisibilité du texte
                            LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.8)]), startPoint: .top, endPoint: .bottom)
                                .frame(width: UIScreen.main.bounds.width - 40, height: 220)
                                .cornerRadius(10)

                            // Texte pour le nom du jeu
                            Text("Devine chiffre")
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                                .padding(.bottom, 10)
                                .frame(width: UIScreen.main.bounds.width - 40, height: 220, alignment: .bottom)
                        }
                        .cornerRadius(10)
                        .padding([.leading, .trailing], 20)
                    }
                    
                    // Bouton de navigation vers le jeu "Matching de carte"
                    NavigationLink(destination: MatchingGameView()) {
                        ZStack {
                            // Image de fond pour le bouton
                            Image("Matching cart")
                                .resizable()
                                .scaledToFill()
                                .frame(width: UIScreen.main.bounds.width - 40, height: 250)
                                .clipped()
                            
                            // Dégradé pour améliorer la lisibilité du texte
                            LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.8)]), startPoint: .top, endPoint: .bottom)
                                .frame(width: UIScreen.main.bounds.width - 40, height: 250)
                                .cornerRadius(10)

                            // Texte pour le nom du jeu
                            Text("Matching de carte")
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                                .padding(.bottom, 10)
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
}

#Preview {
    MenuAppView()
}
