//
//  HistorySuggestion.swift
//  tripper-ios
//
//  Created by Ang Chun Yang on 20/9/23.
//

import Foundation

struct HistorySuggestion: Codable, Identifiable {
    let id: String
    let content: String
    let createdDate: TimeInterval
}
