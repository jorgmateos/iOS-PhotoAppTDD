//
//  MockSignupPresenter.swift
//  PhotoAppTests
//
//  Created by Jorge Garcia Mateos on 12/10/22.
//

import Foundation
@testable import PhotoApp

class MockSignupPresenter: SignupPresenterProtocol {
    var processUserSignupCalled = false
    
    required init(formModelValidator: SignupModelValidatorProtocol, webService: SignupWebServiceProtocol, delegate: SignupViewDelegateProtocol) {
        // TODO:
    }
    
    func processUserSignup(formModel: SignupFormModel) {
        processUserSignupCalled = true
    }
}
