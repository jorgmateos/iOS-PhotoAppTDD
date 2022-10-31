//
//  MockSignupModelValidator.swift
//  PhotoAppTests
//
//  Created by Jorge Garcia Mateos on 11/10/22.
//

import Foundation
@testable import PhotoApp

class MockSignupModelValidator: SignupModelValidatorProtocol {
    var isFirstNameValidated: Bool = false
    var isLastNameValidated: Bool = false
    var isEmailValidated: Bool = false
    var isPasswordValidated: Bool = false
    var isPasswordEqualityValidated: Bool = false

    func isFirstNameValid(firstName: String) -> Bool {
        isFirstNameValidated = true
        return true
    }
    
    func isLastNameValid(lastName: String) -> Bool {
        isLastNameValidated = true
        return true
    }
    
    func isEmailValid(email: String) -> Bool {
        isEmailValidated = true
        return true
    }
    
    func isPasswordValid(password: String) -> Bool {
        isPasswordValidated = true
        return true
    }
    
    func doPasswordsMatch(password: String, repeatPassword: String) -> Bool {
        isPasswordEqualityValidated = true
        return true
    }
}
