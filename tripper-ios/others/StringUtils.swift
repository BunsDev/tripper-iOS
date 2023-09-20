//
//  StringUtils.swift
//  tripper-ios
//
//  Created by Ang Chun Yang on 20/9/23.
//

import Foundation

class StringUtils {
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegex = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    static func shortenString(_ input: String) -> String {
        let firstLine = String(input.split(separator: "\n")[0])
        var splitted = firstLine.split(separator: " ")
        splitted.removeFirst()
        let country = String(splitted.joined(separator: " "))
        let output = "Ideas to \(country) and more"
        return output
    }
}
