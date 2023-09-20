//
//  HistorySuggestionView.swift.swift
//  tripper-ios
//
//  Created by Ang Chun Yang on 20/9/23.
//

import SwiftUI

struct HistorySuggestionView: View {
    @State var historySuggestion: HistorySuggestion

    var body: some View {
        ScrollView(.vertical) {
            VStack {
                Text("Generated on \(Date(timeIntervalSince1970: historySuggestion.createdDate).formatted(date: .abbreviated, time: .shortened))")
                    .foregroundColor(.pink)
                    .bold()
                    .padding(.bottom, 25)
                Text(.init(historySuggestion.content))
            }
            .padding(.horizontal, 10)
        }
    }
}

struct HistorySuggestionView_Previews: PreviewProvider {
    static var previews: some View {
        HistorySuggestionView(historySuggestion: HistorySuggestion(id: UUID().uuidString, content: "ahhasd had hau dh ud a", createdDate: Date().timeIntervalSince1970))
    }
}
