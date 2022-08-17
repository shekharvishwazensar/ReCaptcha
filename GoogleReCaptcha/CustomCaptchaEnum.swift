//
//  CustomCaptchaEnum.swift
//  GoogleReCaptcha
//
//  Created by SV59349 on 16/08/22.
//

import Foundation

public enum CaptchaType: String {
    case numeric
    case alphaNumeric
    case alpha
    case expression
    
    func selectedCaptcha() -> String {
        switch self {
        case .numeric:
            return "0123456789"
        case .alphaNumeric:
            return "abcdefghjkmnpqrstuvwxyzABCDEFGHJKMNPQRSTUVWXYZ0123456789"
        case .alpha:
            return "abcdefghjkmnpqrstuvwxyzABCDEFGHJKMNPQRSTUVWXYZ"
        case .expression:
            return Expression.allCases.map({ "\($0.rawValue)" }).joined(separator: "")
        }
    }
}

public enum Expression: String, CaseIterable {
    case addition = "+"
    case substraction = "-"
    case multipication = "x"
}
