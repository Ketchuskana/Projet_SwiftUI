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
            // Affichage du temps restant
            Text("Temps restant : \(timeRemaining) s")
                .font(.system(size: 18, weight: .semibold))
                .padding()
                .foregroundColor(timeRemaining > 15 ? .black : .red)
            
            HStack{
                // Affichage du score
                Text("Score: \(score)")
                    .padding()

                // Affichage du nombre d'essais (décroissant)
                Text("Essais restants: \(attempts)")
                    .padding()
            }

            TextField("Entrer un nombre entre 1 et 10", text: $numTest)
                .keyboardType(.numberPad)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 40)
                .font(.system(size: 15, weight: .semibold))
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
                    .frame(width: 100, height: 20)
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.top, 20)
                    .scaleEffect(showPulseAnimation ? buttonScale : 1.0)
            }
            .disabled(gameEnded)

            // Message de statut du jeu
            Text(gameStatus)
                .padding()
                .foregroundColor(gameStatus == "Gagné !" ? .green : .black)

            // Affichage du bouton "Rejouer" si le jeu est terminé
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
    }
    // Fonction pour deviner le nombre
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

    // Fonction le round suivant après 3 essais
    func resetRound() {
        numDevine = Int.random(in: 1...10)
        attempts = 3
    }

    // Fonction recommencer le jeu après le temps écoulé
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

    // Fonction pour vérifier que le jeu à commencer
    func startGame() {
        gameStarted = true
        startTimer()
    }

    // Fonction de lancement et arrêt de timer
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

