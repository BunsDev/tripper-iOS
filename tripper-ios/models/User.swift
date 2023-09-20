//
//  User.swift
//  tripper-ios
//
//  Created by Ang Chun Yang on 20/9/23.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}
