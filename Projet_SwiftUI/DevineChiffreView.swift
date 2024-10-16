//
//  DevineChiffreView.swift
//  Projet_SwiftUI
//
//  Created by SON ESSOME MOUKOURI Ketchuskana on 16/10/2024.
//

import SwiftUI

struct DevineChiffreView: View {
    @State private var numTest: String = ""
    @State private var numDevine: Int = Int.random(in: 1...10)
    @State private var score: Int = 0
    @State private var attempts: Int = 3
    @State private var gameStatus: String = ""
    @State private var timeRemaining: Int = 90
    @State private var timer: Timer?
    @State private var gameEnded: Bool = false
    @State private var gameStarted: Bool = false
    @State private var buttonScale: CGFloat = 1.0
    @State private var showPulseAnimation: Bool = false

    var body: some View {
        VStack {
            Text("Temps restant : \(timeRemaining) secondes")
                .font(.title)
                .padding()
                .foregroundColor(timeRemaining > 10 ? .black : .red)

            // Affichage du score
            Text("Score: \(score)")
                .font(.largeTitle)
                .padding()

            // Affichage du nombre d'essais (décroissant)
            Text("Essais restants: \(attempts)")
                .font(.title2)
                .padding()

            TextField("Entrer un nombre entre 1 et 10", text: $numTest)
                .keyboardType(.numberPad)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 40)
                .font(.title2)
                .disabled(!gameStarted)

            // Bouton "Commencer" ou "Tester"
            Button(action: {
                if !gameStarted {
                    startGame()
                } else {
                    checkGuess()
                }
            }) {
                Text(gameStarted ? "Tester" : "Commencer")
                    .font(.title)
                    .padding()
                    .background(Color.pink)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.top, 20)
                    .scaleEffect(showPulseAnimation ? buttonScale : 1.0)
                    .animation(
                        showPulseAnimation ? .easeInOut(duration: 0.6).repeatForever(autoreverses: true) : .default,
                        value: buttonScale
                    )
            }
            .disabled(gameEnded)

            // Message de statut du jeu
            Text(gameStatus)
                .font(.title)
                .padding()
                .foregroundColor(gameStatus == "Gagné !" ? .green : .black)

            // Bouton "Rejouer" si le jeu est terminé
            if gameEnded {
                Button(action: {
                    resetGame()
                }) {
                    Text("Rejouer")
                        .font(.title)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.top, 20)
                }
            }
        }
        .padding()
        .onAppear {
            showPulseAnimation = !gameStarted
        }
    }

    func checkGuess() {
        guard let guess = Int(numTest), (1...10).contains(guess) else {
            gameStatus = "Veuillez entrer un nombre valide entre 1 et 10."
            return
        }

        if guess == numDevine {
            score += 1
            gameStatus = "Gagné !"
            resetRound()
        } else if abs(guess - numDevine) == 1 {
            attempts -= 1
            gameStatus = "Vous y êtes presque !"
        } else {
            attempts -= 1
            gameStatus = guess < numDevine ? "Trop petit !" : "Trop grand !"
        }

        if attempts == 0 && guess != numDevine {
            gameStatus = "Perdu ! Le bon numéro était \(numDevine)."
            resetRound()
        }

        numTest = ""
    }

    func resetRound() {
        numDevine = Int.random(in: 1...10)
        attempts = 3
    }

    func resetGame() {
        score = 0
        attempts = 3
        timeRemaining = 90
        gameEnded = false
        gameStarted = false
        showPulseAnimation = true
        numTest = ""
        gameStatus = ""
        numDevine = Int.random(in: 1...10) // Recommencer le jeu
    }

    func startGame() {
        gameStarted = true
        startTimer()
        showPulseAnimation = false
    }

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                gameEnded = true
                timer?.invalidate()
                gameStatus = "Temps écoulé ! Vous avez marqué \(score) points."
            }
        }
    }
}

#Preview {
    DevineChiffreView()
}

