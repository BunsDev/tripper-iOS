//
//  ContentView.swift
//  tripper-ios
//
//  Created by Ang Chun Yang on 19/9/23.
//
import Combine
import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()

    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            AuthenticatedView
        } else {
            LoginView()
        }
    }

    @ViewBuilder
    var AuthenticatedView: some View {
        TabView {
            GetSuggestionsView().tabItem { Label("", systemImage: "airplane.departure")
            }
            HistoryView(userId: viewModel.currentUserId).tabItem { Label("", systemImage: "list.bullet")
            }

        }.tint(.pink)
    }

    struct NotAuthenticatedView: View {
        var body: some View {
            Text("Hello")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
