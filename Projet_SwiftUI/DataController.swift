//
//  DataController.swift
//  Projet_SwiftUI
//
//  Created by SON ESSOME MOUKOURI Ketchuskana on 16/10/2024.
//

import Foundation

class DataController {
    static var registeredUsers: [String: String] = [
        "Jean": "12345",
        "Anne": "54321"
    ]
    
    func checkUser(login: String, password: String) -> Bool {
        if let storedPassword = DataController.registeredUsers[login] {
            return storedPassword == password
        }
        return false
    }
    
    let tableau = [1, 2, 23]
    
    func checkTableau() {
        for number in tableau {
            // Traitement des éléments du tableau
        }
    }
    
    func checkDico(dico: [String: EleveTest]) {
        for element in dico {
            print("\(element.key) s'appelle \(element.value.name) et a \(element.value.age)")
        }
    }
}

struct EleveTest {
    var name: String
    var age: Int
}
