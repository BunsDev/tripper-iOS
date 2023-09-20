//
//  RegisterViewModel.swift
//  tripper-ios
//
//  Created by Ang Chun Yang on 20/9/23.
//

import Foundation

import FirebaseAuth
import FirebaseFirestore
import Foundation

final class RegisterViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""

    init() {}

    func register() {
        print("registering")
        guard validate() else {
            print("fail validation")
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) {
            [weak self] result, _ in

            guard let userId = result?.user.uid else {
                return
            }
            self?.insertUserRecord(id: userId)
        }
    }

    private func insertUserRecord(id: String) {
        let newUser = User(id: id, name: name, email: email, joined: Date().timeIntervalSince1970)
        let db = Firestore.firestore()
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
    }

    private func validate() -> Bool {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty, !email.trimmingCharacters(in: .whitespaces).isEmpty, !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in all fields"
            return false
        }

        guard StringUtils.isValidEmail(email) else {
            errorMessage = "Please enter a valid email"
            return false
        }
        return true
    }
}
