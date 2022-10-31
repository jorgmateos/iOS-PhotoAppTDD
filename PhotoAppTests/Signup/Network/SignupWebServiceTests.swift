//
//  SignupWebServiceTests.swift
//  PhotoAppTests
//
//  Created by Jorge Garcia Mateos on 19/9/22.
//

import XCTest
@testable import PhotoApp

final class SignupWebServiceTests: XCTestCase {
    var sut: SignupWebService!
    var signFormRequestModel: SignupFormRequestModel!
    
    override func setUp() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        
        sut = SignupWebService(urlString: SignupConstants.signupURLString, urlSession: urlSession)
        signFormRequestModel = SignupFormRequestModel(firstName: "Sergey",
                                                          lastName: "Sanchez",
                                                          email: "jorgegmateos@gmail.com",
                                                          password: "123456789")
    }
    
    override func tearDown() {
        sut = nil
        signFormRequestModel = nil
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.error = nil
    }
    
    func testSignupWebService_WhenGivenSuccessfullResponse_ReturnSuccess() {
        // Arrange
        let jsonString = "{\"status\":\"ok\"}"
        MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)
        
        let expectation = self.expectation(description: "Signup Web Service Response Expectation")
        
        // Act
        sut.signup(withForm: signFormRequestModel) { signupResponseModel, error in
            
            // Assert
            XCTAssertEqual(signupResponseModel?.status, "ok")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testSignupWebService_WhenReceivedDifferentJSONResponse_ErrorTookPlace() {
        // Arrange
        let jsonString = "{\"path\": \"/users\", \"error\": \"Internal Server Error\"}"
        MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)
        
        let expectation = expectation(description:
                                        "Signup() method expectation for a response that contains a different JSON structure")
        
        // Act
        sut.signup(withForm: signFormRequestModel) { signupResponseModel, error in
            
            // Assert
            XCTAssertNil(signupResponseModel,
                         "The response model for a request containing unknown JSON response should have been nil but was \(signupResponseModel!)")
            XCTAssertEqual(error, SignupError.invalidResponseModel,
                           "The signup(withForm:) method did not return expected error")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testSignupWebService_WhenEmptyURLStringProvided_ReturnsError() {
        // Arrange
        sut = SignupWebService(urlString: "")
        
        let expectation = expectation(description: "An empty request URL string expectation")
        
        // Act
        sut.signup(withForm: signFormRequestModel) { signupResponseModel, error in
            // Assert
            XCTAssertEqual(error, SignupError.invalidRequestURLString,
                           "The signup(withform:completionHandler) method did not return and expected error an invalidRequestURLString error")
            XCTAssertNil(signupResponseModel,
                         "When an invalidRequestURLString takes place, the response model must be nil")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testSignupWebService_WhenURLRequestFails_ReturnsErrorMessageDescription(){
        // Arrange
        let expectation = expectation(description: "A failed Request expectation")
        let errorDescription = "A localized description of an error"
        MockURLProtocol.error = SignupError.failedRequest(description: errorDescription)
        
        // Act
        sut.signup(withForm: signFormRequestModel) { signupResponseModel, error in
            XCTAssertEqual(error, SignupError.failedRequest(description: errorDescription),
                           "The signup(withForm:completionHandler:) method did not return an expected error for the failed request")
//            XCTAssertEqual(error?.localizedDescription, errorDescription)
            
            expectation.fulfill()
        }
        
        // Assert
        wait(for: [expectation], timeout: 2)
    }
}
