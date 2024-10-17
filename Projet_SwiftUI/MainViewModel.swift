//
//  MainViewModel.swift
//  Projet_SwiftUI
//
//  Created by SON ESSOME MOUKOURI Ketchuskana on 16/10/2024.
//

import Foundation
import SwiftUI

class MainViewModel: ObservableObject {
    @Published var isValid = false
    @Published var userName: String = ""
    
    private let dataController = DataController()
    func checkConnection(login: String, password: String) {
        if dataController.checkUser(login: login, password: password) {
            userName = login
            isValid = true
        } else {
            isValid = false
        }
    }
}


