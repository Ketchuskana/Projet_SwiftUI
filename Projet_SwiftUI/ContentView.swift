//
//  ContentView.swift
//  Projet_SwiftUI
//
//  Created by SON ESSOME MOUKOURI Ketchuskana on 16/10/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var appui1: String = "🍒"
    @State private var appui2: String = "🍀"
    @State private var appui3: String = "💰"
    @State private var score: Int = 0
    @State private var attempts: Int = 0
    @State private var gameStatus: String = ""
    @State private var isButtonDisabled: Bool = false
    @State private var reelColor1: Color = Color.gray.opacity(0.8)
    @State private var reelColor2: Color = Color.gray.opacity(0.8)
    @State private var reelColor3: Color = Color.gray.opacity(0.8)
    @State private var buttonScale: CGFloat = 1.0 // État pour l'animation de bouton
    @State private var showPulseAnimation: Bool = false // Contrôle de l'animation de pulsation

    let winColor = Color.green
    let emojis = ["💰", "🍒", "🍀"]
    
    var body: some View {
        VStack {
            Text("🎰 Jackpot 🎰")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.yellow)
                .padding(.bottom, 10)
            
            Text("Score: \(score)")
                .padding()
                .foregroundColor(.white)
            
            // Affichage des vies sous forme de cœurs
            HStack {
                ForEach(0..<5, id: \.self) { index in
                    Image(systemName: "heart.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(index < 5 - attempts ? .red : .gray.opacity(0.5))
                }
            }
            .padding(.bottom)

            VStack {
                
                HStack(spacing: 10) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(reelColor1)
                            .frame(width: 100, height: 120)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.yellow, lineWidth: 4)
                            )
                        Text(appui1)
                            .font(.system(size: 48))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(reelColor2)
                            .frame(width: 100, height: 120)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.yellow, lineWidth: 4)
                            )
                        Text(appui2)
                            .font(.system(size: 48))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(reelColor3)
                            .frame(width: 100, height: 120)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.yellow, lineWidth: 4)
                            )
                        Text(appui3)
                            .font(.system(size: 48))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                }
                .padding()
                .background(Color.black.opacity(0.8))
                .cornerRadius(15)
                .shadow(color: .black, radius: 10, x: 0, y: 5)
                
                Button(action: {
                    if attempts >= 5 {
                        resetGame()
                    } else {
                        playGameWithDelay()
                    }
                }) {
                    Text(attempts >= 5 ? "Recommencer" : "Lancer")
                        .padding()
                        .background(isButtonDisabled ? Color.gray : Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .font(.title)
                        .scaleEffect(showPulseAnimation ? buttonScale : 1.0)
                        .animation(
                            showPulseAnimation ? .easeInOut(duration: 0.6).repeatForever(autoreverses: true) : .default,
                            value: buttonScale
                        )
                        .onAppear {
                            if attempts >= 5 || gameStatus == "Gagné !" {
                                buttonScale = 1.2
                                showPulseAnimation = true
                            }
                        }
                }
                .disabled(isButtonDisabled)
                .padding(.top, 20)
            }
            
            Text(gameStatus)
                .font(.title)
                .padding()
                .foregroundColor(gameStatus == "Gagné !" ? .green : .black)
        }
        .padding()
        .background(Color.black)
    }

    func playGameWithDelay() {
        appui1 = emojis.randomElement() ?? "💰"
        appui2 = emojis.randomElement() ?? "💰"
        appui3 = emojis.randomElement() ?? "💰"
        gameStatus = ""
        reelColor1 = Color.gray.opacity(0.8)
        reelColor2 = Color.gray.opacity(0.8)
        reelColor3 = Color.gray.opacity(0.8)

        attempts += 1
        isButtonDisabled = true

        animateRandomNumbers(for: $appui1, delay: 1)
        animateRandomNumbers(for: $appui2, delay: 2)
        animateRandomNumbers(for: $appui3, delay: 3)

        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            if appui1 == appui2 && appui2 == appui3 {
                score += 1
                gameStatus = "Gagné !"
                reelColor1 = winColor
                reelColor2 = winColor
                reelColor3 = winColor
                attempts = 0
            } else if attempts >= 5 {
                gameStatus = "Perdu !"
                buttonScale = 1.2
                showPulseAnimation = true // Active l'animation de pulsation
            } else {
                gameStatus = "Essayez encore !"
            }
            isButtonDisabled = false
        }
    }

    func resetGame() {
        appui1 = emojis.randomElement() ?? "💰"
        appui2 = emojis.randomElement() ?? "💰"
        appui3 = emojis.randomElement() ?? "💰"
        attempts = 0
        gameStatus = ""
        reelColor1 = Color.gray.opacity(0.8)
        reelColor2 = Color.gray.opacity(0.8)
        reelColor3 = Color.gray.opacity(0.8)
        isButtonDisabled = false
        buttonScale = 1.0
        showPulseAnimation = false // Désactive l'animation de pulsation
    }

    func animateRandomNumbers(for appui: Binding<String>, delay: Double) {
        let maxAnimations = 10
        for i in 0..<maxAnimations {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay + (Double(i) * 0.1)) {
                appui.wrappedValue = emojis.randomElement() ?? "💰"
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + delay + (Double(maxAnimations) * 0.1)) {
            appui.wrappedValue = emojis.randomElement() ?? "💰"
        }
    }
}

#Preview {
    ContentView()
}
