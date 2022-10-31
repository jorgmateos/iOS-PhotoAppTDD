//
//  MockSignupViewDelegate.swift
//  PhotoAppTests
//
//  Created by Jorge Garcia Mateos on 12/10/22.
//

import Foundation
import XCTest
@testable import PhotoApp

class MockSignupViewDelegate: SignupViewDelegateProtocol {
    var expectation: XCTestExpectation?
    
    var successfulSignupCounter = 0
    var errorHandlerCounter = 0
    
    var signupError: SignupError?
    
    func sucessfulSignup() {
        successfulSignupCounter += 1
        expectation?.fulfill()
    }
    
    func errorHandler(error: SignupError) {
        errorHandlerCounter += 1
        signupError = error
        expectation?.fulfill()
    }
}
