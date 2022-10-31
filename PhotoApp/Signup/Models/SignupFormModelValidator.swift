//
//  SignupFormModelValidator.swift
//  PhotoApp
//
//  Created by Jorge Garcia Mateos on 13/9/22.
//

import Foundation

class SignupFormModelValidator: SignupModelValidatorProtocol {
    func isFirstNameValid(firstName: String) -> Bool {
        let length = firstName.count
        return (!firstName.isEmpty &&
                length > SignupConstants.firstNameMinLength &&
                length < SignupConstants.firstNameMaxLength)
    }
    
    func isLastNameValid(lastName: String) -> Bool {
        let length = lastName.count
        return (!lastName.isEmpty
                && length > SignupConstants.lastNameMinLength
                && length < SignupConstants.lastNameMaxLength)
    }
    
    func isEmailValid(email: String) -> Bool {
        NSPredicate(format:"SELF MATCHES %@", SignupConstants.emailPredicateRegEx).evaluate(with: email)
    }
    
    func isPasswordValid(password: String) -> Bool {
        let length = password.count
        return (!password.isEmpty &&
                length > SignupConstants.passwordMinLength &&
                length < SignupConstants.passwordMaxLength)
    }
    
    func doPasswordsMatch(password: String, repeatPassword: String) -> Bool {
        password == repeatPassword
    }
    
}
