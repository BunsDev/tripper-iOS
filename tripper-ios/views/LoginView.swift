//
//  LoginView.swift
//  tripper-ios
//
//  Created by Ang Chun Yang on 20/9/23.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()

    var body: some View {
        NavigationView {
            VStack {
                // header
                Image("TripperLogo").resizable()
                    .cornerRadius(30)
                    .frame(width: 250, height: 200)
                // login form
                Form {
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage).foregroundColor(.red)
                    }
                    TextField("Email Address", text: $viewModel.email).textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                    SecureField("Password", text: $viewModel.password).textFieldStyle(RoundedBorderTextFieldStyle())
                    HStack {
                        Spacer()
                        TripperButton(backgroundColor: .blue, title: "Log In", action: {
                            viewModel.login()
                        })
                        Spacer()
                    }.padding(.top, 30)

                }.scrollContentBackground(.hidden)

                // create an account
                VStack {
                    Text("New around here?")
                    NavigationLink("Create An Account", destination: RegisterView())
                }
                .padding(.bottom, 50)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
