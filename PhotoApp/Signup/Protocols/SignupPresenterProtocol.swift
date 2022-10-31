//
//  SignupPresenterProtocol.swift
//  PhotoApp
//
//  Created by Jorge Garcia Mateos on 12/10/22.
//

import Foundation

protocol SignupPresenterProtocol: AnyObject {
    init(formModelValidator: SignupModelValidatorProtocol,
         webService: SignupWebServiceProtocol,
         delegate: SignupViewDelegateProtocol)
    func processUserSignup(formModel: SignupFormModel)
}
