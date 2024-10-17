//
//  MatchingGameView.swift
//  Projet_SwiftUI
//
//  Created by SON ESSOME MOUKOURI Ketchuskana on 17/10/2024.
//

import SwiftUI

// Modèle pour représenter une carte de jeu avec son contenu, son état (face visible ou cachée) et si elle a été associée.
struct Card: Identifiable {
    let id = UUID()
    let content: String
    var isFaceUp: Bool = false
    var isMatched: Bool = false
}

struct MatchingGameView: View {
    @State private var cards: [Card] = []
    @State private var firstSelectedCardIndex: Int? = nil
    @State private var secondSelectedCardIndex: Int? = nil
    @State private var matchesFound: Int = 0
    @State private var attempts: Int = 0
    @State private var timeRemaining: Int = 0
    @State private var timer: Timer?
    @State private var gameEnded: Bool = false
    @State private var gameStarted: Bool = false

    let cardContents = ["🍎", "🍊", "🍌"]

    var body: some View {
        VStack {
            // Si le jeu est terminé
            if gameEnded {
                Text("Vous avez trouvé tous les matchs!")
                    .font(.largeTitle)
                    .padding()
                    .multilineTextAlignment(.center)

                Text("Temps total : \(timeRemaining) secondes")
                    .font(.title)
                    .padding()
                    .multilineTextAlignment(.center)
                
                Text("Nombre d'essais: \(attempts)")
                    .font(.title)
                    .padding()
                    .multilineTextAlignment(.center)
                
                // Bouton pour recommencer une nouvelle partie
                Button(action: restartGame) {
                    Text("Recommencer")
                        .font(.title)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            } else {
                // Si le jeu n'a pas encore commencé
                if !gameStarted {
                    Button(action: startGame) {
                        Text("Démarrer le jeu")
                            .font(.title)
                            .padding()
                            .background(Color.cyan)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.bottom)
                } else {
                    // Affichage du temps écoulé et du nombre de tentatives
                    Text("Temps écoulé : \(timeRemaining) s")
                        .font(.title)
                        .padding()
                    
                    Text("Tentatives : \(attempts)")
                        .font(.title2)
                        .padding()

                    // Grille des cartes, en 2 colonnes
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(cards.indices, id: \.self) { index in
                            CardView(card: cards[index])
                                .onTapGesture {
                                    handleCardTap(at: index)
                                }
                                .disabled(cards[index].isMatched || firstSelectedCardIndex != nil && secondSelectedCardIndex != nil)
                        }
                    }
                    .padding()
                }
            }
        }
        .onAppear(perform: setupGame)
        .onDisappear {
            timer?.invalidate()
        }
    }

    func setupGame() {
        // Préparer les cartes et les mélanger
        let pairedCards = cardContents.flatMap { [Card(content: $0), Card(content: $0)] }
        cards = pairedCards.shuffled()
        matchesFound = 0
        attempts = 0
        gameEnded = false
    }

    func handleCardTap(at index: Int) {
        // Si c'est la première carte sélectionnée
        if firstSelectedCardIndex == nil {
            firstSelectedCardIndex = index
            cards[index].isFaceUp = true
        } else if secondSelectedCardIndex == nil && index != firstSelectedCardIndex {
            // Si c'est la deuxième carte sélectionnée
            secondSelectedCardIndex = index
            cards[index].isFaceUp = true
            checkForMatch()
        }
    }

    // Fonction vérification de match
    func checkForMatch() {
        attempts += 1
        guard let firstIndex = firstSelectedCardIndex, let secondIndex = secondSelectedCardIndex else { return }

        if cards[firstIndex].content == cards[secondIndex].content {
            // Si les deux cartes correspondent
            cards[firstIndex].isMatched = true
            cards[secondIndex].isMatched = true
            matchesFound += 1
        } else {
            // Si les cartes ne correspondent pas, les retourner après une petite pause
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                cards[firstIndex].isFaceUp = false
                cards[secondIndex].isFaceUp = false
            }
        }

        firstSelectedCardIndex = nil
        secondSelectedCardIndex = nil

        checkGameEnd()
    }

    // Fonction vérification de fin de jeu et arrêt du timer
    func checkGameEnd() {
        if matchesFound == cardContents.count {
            timer?.invalidate()
            gameEnded = true
        }
    }

    // Fonction commencer le jeu en lançant le timer
    func startGame() {
        gameStarted = true
        timeRemaining = 0
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            timeRemaining += 1
        }
    }

    // Fonction (re)commencer le jeu
    func restartGame() {
        setupGame()
        startGame()
    }
}

struct CardView: View {
    let card: Card

    var body: some View {
        ZStack {
            // Affichage de la carte selon son état
            if card.isFaceUp || card.isMatched {
                // Si il y a match
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .frame(width: 130 , height: 200)
                    .shadow(radius: 5)

                Text(card.content)
                    .font(.system(size: 50))
            } else {
                // Si il y a mismatch
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue)
                    .frame(width: 130, height: 200)
                    .shadow(radius: 5)
            }
        }
    }
}

#Preview {
    MatchingGameView()
}
