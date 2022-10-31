//
//  MockSignupWebService.swift
//  PhotoAppTests
//
//  Created by Jorge Garcia Mateos on 11/10/22.
//

import Foundation
@testable import PhotoApp

class MockSignupWebService: SignupWebServiceProtocol {
    var isSignupMethodCalled = false
    var shouldReturnError = false
    
    func signup(withForm form: SignupFormRequestModel, completionHandler: @escaping (SignupResponseModel?, SignupError?) -> Void) {
        isSignupMethodCalled = true
        
        if shouldReturnError {
            completionHandler(nil, SignupError.failedRequest(description: "Signup request was not successful"))
        } else {
            let responseModel = SignupResponseModel(status: "OK")
            completionHandler(responseModel, nil)
        }
    }
}
