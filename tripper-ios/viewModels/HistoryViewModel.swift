//
//  HistoryViewModel.swift
//  tripper-ios
//
//  Created by Ang Chun Yang on 20/9/23.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

final class HistoryViewModel: ObservableObject {
    private let userId: String

    init(userId: String) {
        self.userId = userId
    }
}
