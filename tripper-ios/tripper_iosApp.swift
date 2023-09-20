//
//  tripper_iosApp.swift
//  tripper-ios
//
//  Created by Ang Chun Yang on 19/9/23.
//

import FirebaseCore
import SwiftUI

@main
struct tripper_iosApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
