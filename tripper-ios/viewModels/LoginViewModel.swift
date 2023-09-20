//
//  LoginViewModel.swift
//  tripper-ios
//
//  Created by Ang Chun Yang on 20/9/23.
//

import FirebaseAuth
import Foundation

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""

    init() {}

    private func validate() -> Bool {
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty, !password.isEmpty else {
            errorMessage = "Please fill in all fields"
            return false
        }
        guard StringUtils.isValidEmail(email) else {
            errorMessage = "Please enter a valid email"
            return false
        }
        return true
    }

    func login() {
        guard validate() else {
            return
        }
        Auth.auth().signIn(withEmail: email, password: password)
    }
}
