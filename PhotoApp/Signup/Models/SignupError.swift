//
//  SignupError.swift
//  PhotoApp
//
//  Created by Jorge Garcia Mateos on 19/9/22.
//

import Foundation

enum SignupError: LocalizedError, Equatable {
    case invalidResponseModel
    case invalidRequestURLString
    case failedRequest(description: String)
    case invalidFirstName
    case invalidLastName
    case invalidEmail
    case invalidPassword
    case passwordsDoNotMatch
    
    var errorDescription: String? {
        switch self {
        case .invalidResponseModel, .invalidRequestURLString:
            return ""
        case .failedRequest(let description):
            return description
        default:
            return ""
        }
    }
}
