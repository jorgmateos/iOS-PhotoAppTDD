//
//  SignupPresenterTests.swift
//  PhotoAppTests
//
//  Created by Jorge Garcia Mateos on 11/10/22.
//

import XCTest
@testable import PhotoApp

final class SignupPresenterTests: XCTestCase {
    var signupFormModel: SignupFormModel!
    
    var mockSignupModelValidator: MockSignupModelValidator!
    var mockSignupWebService: MockSignupWebService!
    var mockSignupViewDelegate: MockSignupViewDelegate!
    
    var sut: SignupPresenter!

    override func setUpWithError() throws {
        signupFormModel = SignupFormModel(firstName: "Jorge",
                                              lastName: "García",
                                              email: "jorgegmateos@gmail.com",
                                              password: "123456789",
                                              repeatPassword: "123456789")
        
        mockSignupModelValidator = MockSignupModelValidator()
        mockSignupWebService = MockSignupWebService()
        mockSignupViewDelegate = MockSignupViewDelegate()
        
        sut = SignupPresenter(formModelValidator: mockSignupModelValidator,
                              webService: mockSignupWebService,
                              delegate: mockSignupViewDelegate)
    }

    override func tearDownWithError() throws {
        signupFormModel = nil
        
        mockSignupModelValidator = nil
        mockSignupWebService = nil
        mockSignupViewDelegate = nil
        
        sut = nil
    }

    func testSignupPresenter_WhenInformationProvided_WillValidateEachProperty() {
        // Arrange
        // Act
        sut.processUserSignup(formModel: signupFormModel)
        
        // Assert
        XCTAssertTrue(mockSignupModelValidator.isFirstNameValidated, "First name was not validated")
        XCTAssertTrue(mockSignupModelValidator.isLastNameValidated, "Last name was not validated")
        XCTAssertTrue(mockSignupModelValidator.isEmailValidated, "Email was not validated")
        XCTAssertTrue(mockSignupModelValidator.isPasswordValidated, "Password was not validated")
        XCTAssertTrue(mockSignupModelValidator.isPasswordEqualityValidated, "Did not validate if passwords match")
    }
    
    func testSignupPresenter_WhenGivenValidFormModel_ShouldCallSignupMethod() {
        // Arrange
        // Act
        sut.processUserSignup(formModel: signupFormModel)
        
        // Assert
        XCTAssertTrue(mockSignupWebService.isSignupMethodCalled,
                      "The signup(withForm:completionHandler:) method was not called in the SignupWebService class")
    }
    
    func testSignupPresenter_WhenSignupOperationSuccessful_CallSuccessOnViewDelegate() {
        // Arrange
        let expectation = expectation(description: "Expected the successfulSignup(formModel:) method to be called")
        mockSignupViewDelegate.expectation = expectation
        
        // Act
        sut.processUserSignup(formModel: signupFormModel)
        wait(for: [expectation], timeout: 5)
        
        // Assert
        XCTAssertEqual(mockSignupViewDelegate.successfulSignupCounter,
                       1,
                       "The successfulSignup(formModel:) method was called more than one time")
    }
    
    func testSignupPresenter_WhenSignupOperationError_CallErrorHandlerOnViewDelegate() {
        // Arrange
        let expectation = expectation(description: "Expected the errorHandler(error:) method to be called")
        mockSignupViewDelegate.expectation = expectation
        mockSignupWebService.shouldReturnError = true
        
        // Act
        sut.processUserSignup(formModel: signupFormModel)
        wait(for: [expectation], timeout: 5)
        
        // Assert
        XCTAssertEqual(mockSignupViewDelegate.successfulSignupCounter,
                       0,
                       "The successfulSignup(formModel:) method was called \(mockSignupViewDelegate.successfulSignupCounter) time(s)")
        XCTAssertEqual(mockSignupViewDelegate.errorHandlerCounter,
                       1,
                       "The errorHandler(error:) method was called more than one time")
        XCTAssertNotNil(mockSignupViewDelegate.signupError)
    }
}
