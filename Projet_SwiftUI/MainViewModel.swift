//
//  MainViewModel.swift
//  Projet_SwiftUI
//
//  Created by SON ESSOME MOUKOURI Ketchuskana on 16/10/2024.
//

import Foundation

class MainViewModel: ObservableObject {
    
    @Published var isValid = false


    func checkConnection(login: String, password: String) {
        let passwordTest = DataController.registeredUsers[login]
        if let realPassword = DataController.registeredUsers[login] { // L'index existe-t-il ?
            if realPassword == password { // Le mot de passe est-il bon ?
                isValid = true
            } else {
                isValid = false
                // TODO: Messages d'erreur
            }
        } else {
            isValid = false
            // TODO: Messages d'erreurs
        }
    }
}

