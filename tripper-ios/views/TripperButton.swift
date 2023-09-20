//
//  TripperButton.swift
//  tripper-ios
//
//  Created by Ang Chun Yang on 19/9/23.
//

import SwiftUI

// A general button for user to click actions to decide wheter he like or dont like
//
struct TripperButton: View {
    let backgroundColor: Color
    let title: String
    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            Text(title).bold()
                .frame(width: 170, height: 40, alignment: .center)

        }.background(backgroundColor)
            .foregroundColor(Color.white)
            .cornerRadius(20)
    }
}

struct TripperButton_Previews: PreviewProvider {
    static var previews: some View {
        TripperButton(backgroundColor: .blue, title: "Hello World") {}
    }
}
