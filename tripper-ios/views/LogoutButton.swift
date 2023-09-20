//
//  LogoutButton.swift
//  tripper-ios
//
//  Created by Ang Chun Yang on 20/9/23.
//

import FirebaseAuth
import FirebaseFirestore
import SwiftUI

struct LogoutButton: View {
    @State private var showConfirmation = false

    var body: some View {
        Button {
            showConfirmation = true
        } label: {
            Image(systemName: "rectangle.portrait.and.arrow.right")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .padding(.trailing, 20)
        }
        .confirmationDialog("Logout", isPresented: $showConfirmation) {
            Button("Logout", role: .destructive, action: {
                logout()
                showConfirmation = false
            })
            Button("Cancel", role: .cancel, action: {
                showConfirmation = false
            })
        }
    }

    func logout() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
}

struct LogoutButton_Previews: PreviewProvider {
    static var previews: some View {
        LogoutButton()
    }
}
