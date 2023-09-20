//
//  RegisterView.swift
//  tripper-ios
//
//  Created by Ang Chun Yang on 20/9/23.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewModel()

    var body: some View {
        VStack {
            Image("TripperLogo").resizable()
                .cornerRadius(30)
                .frame(width: 250, height: 200)
            Form {
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage).foregroundColor(.red)
                }
                TextField("Full name", text: $viewModel.name).textFieldStyle(DefaultTextFieldStyle())
                TextField("Email", text: $viewModel.email).textFieldStyle(DefaultTextFieldStyle())
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                SecureField("Password", text: $viewModel.password).textFieldStyle(DefaultTextFieldStyle())
                HStack {
                    Spacer()
                    TripperButton(backgroundColor: .green, title: "Create Account") {
                        viewModel.register()
                    }
                    Spacer()
                }
                .padding(.top, 50)
            }.scrollContentBackground(.hidden)
                .offset(y: -50)
            Spacer()
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
