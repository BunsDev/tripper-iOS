//
//  FirebaseService.swift
//  tripper-ios
//
//  Created by Ang Chun Yang on 20/9/23.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class FirebaseService {
    init() {}

    func addSuggestionToHistory(_ content: String) {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }

        // create model
        let newId = UUID().uuidString
        let newItem = HistorySuggestion(id: newId, content: content, createdDate: Date().timeIntervalSince1970)

        // save model to db
        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
            .collection("historySuggestions")
            .document(newId)
            .setData(newItem.asDictionary())
    }
}
