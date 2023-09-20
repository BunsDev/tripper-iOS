//
//  HistoryView.swift
//  tripper-ios
//
//  Created by Ang Chun Yang on 20/9/23.
//

import FirebaseFirestoreSwift
import SwiftUI

struct HistoryView: View {
    @StateObject var viewModel: HistoryViewModel
    @FirestoreQuery var historySuggestions: [HistorySuggestion]

    private let userId: String

    // firestore has functionality to observe
    // all items from a particular path
    // users/<id>/todos/<entries>
    init(userId: String) {
        self.userId = userId
        // _ because convention for property wrappers
        self._historySuggestions = FirestoreQuery(
            collectionPath: "users/\(userId)/historySuggestions", predicates: [.order(by: "createdDate", descending: true)]
        )
        self._viewModel = StateObject(wrappedValue: HistoryViewModel(userId: userId))
    }

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("History")
                        .font(.title)
                        .bold()
                        .padding(.leading, 20)
                    Spacer()
                    LogoutButton()
                        .padding(.trailing, 15)
                }
                .padding(.top, 15)
                List {
                    ForEach(historySuggestions, id: \.id) { suggestion in
                        NavigationLink {
                            HistorySuggestionView(historySuggestion: suggestion)
                        } label: {
                            HistoryListItemView(historySuggestion: suggestion)
                        }
                    }
                }
                .navigationBarHidden(true)
            }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(userId: "MhoDyDMHVxbg7lXOqmsnKCa0Un22")
    }
}
