//
//  SignupPresenter.swift
//  PhotoApp
//
//  Created by Jorge Garcia Mateos on 11/10/22.
//

import Foundation

class SignupPresenter: SignupPresenterProtocol {
    private var formModelValidator: SignupModelValidatorProtocol
    private var webService: SignupWebServiceProtocol
    private weak var delegate: SignupViewDelegateProtocol?
    
    required init(formModelValidator: SignupModelValidatorProtocol,
         webService: SignupWebServiceProtocol,
         delegate: SignupViewDelegateProtocol) {
        self.formModelValidator = formModelValidator
        self.webService = webService
        self.delegate = delegate
    }
    
    func processUserSignup(formModel: SignupFormModel) {
        
        let firstName = formModel.firstName
        let lastName = formModel.lastName
        let email = formModel.email
        let password = formModel.password
        let repeatPassword = formModel.repeatPassword
        
        if !formModelValidator.isFirstNameValid(firstName: firstName) {
            delegate?.errorHandler(error: .invalidFirstName)
            return
        }
        
        if !formModelValidator.isLastNameValid(lastName: lastName) {
            delegate?.errorHandler(error: .invalidLastName)
            return
        }
        
        if !formModelValidator.isEmailValid(email: email) {
            delegate?.errorHandler(error: .invalidEmail)
            return
        }
        
        if !formModelValidator.isPasswordValid(password: password) {
            delegate?.errorHandler(error: .invalidPassword)
            return
        }
        
        if !formModelValidator.doPasswordsMatch(password: password, repeatPassword: repeatPassword) {
            delegate?.errorHandler(error: .passwordsDoNotMatch)
            return
        }
        
        let requestModel = SignupFormRequestModel(firstName: firstName,
                                                  lastName: lastName,
                                                  email: email,
                                                  password: password)
        
        webService.signup(withForm: requestModel) { [weak self] (responseModel, error) in
            if let error = error {
                self?.delegate?.errorHandler(error: error)
                return
            }
            
            if let _ = responseModel {
                self?.delegate?.sucessfulSignup()
            }
        }
    }
}
