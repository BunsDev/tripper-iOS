//
//  MainViewModel.swift
//  tripper-ios
//
//  Created by Ang Chun Yang on 20/9/23.
//

import FirebaseAuth
import Foundation

class MainViewModel: ObservableObject {
    @Published var currentUserId: String = ""
    private var handler: AuthStateDidChangeListenerHandle?

    init() {
        self.handler = Auth.auth().addStateDidChangeListener { [weak self]
            _, user in DispatchQueue.main.async {
                    self?.currentUserId = user?.uid ?? ""
                }
        }
    }

    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
}
