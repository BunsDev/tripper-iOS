//
//  HistoryListItemView.swift
//  tripper-ios
//
//  Created by Ang Chun Yang on 20/9/23.
//

import SwiftUI

struct HistoryListItemView: View {
    @State var historySuggestion: HistorySuggestion

    var body: some View {
        HStack {
            Text(.init(StringUtils.shortenString(historySuggestion.content)))
            Spacer()
        }
    }
}

struct HistoryListItemView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryListItemView(historySuggestion: HistorySuggestion(id: UUID().uuidString, content: "String", createdDate: Date().timeIntervalSince1970))
    }
}
