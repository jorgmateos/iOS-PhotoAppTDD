//
//  SignupConstants.swift
//  PhotoApp
//
//  Created by Jorge Garcia Mateos on 13/9/22.
//

import Foundation

struct SignupConstants {
    
    // MARK: - First Name Length
    static let firstNameMinLength = 2
    static let firstNameMaxLength = 10
    
    // MARK: - Last Name Length
    static let lastNameMinLength = 2
    static let lastNameMaxLength = 12
    
    // MARK: - Email RegEx
    static let emailPredicateRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    // MARK: - Password Length
    static let passwordMinLength = 8
    static let passwordMaxLength = 16
    
    // MARK: - WebService
    static let signupURLString = "https://tlyqhtlbn8.execute-api.us-east-1.amazonaws.com/prod/signup-mock-service/users"
}
