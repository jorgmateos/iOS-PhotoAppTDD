//
//  SignupViewControllerTests.swift
//  PhotoAppTests
//
//  Created by Jorge Garcia Mateos on 12/10/22.
//

import XCTest
@testable import PhotoApp

final class SignupViewControllerTests: XCTestCase {
    var sut: SignupViewController!

    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "SignupViewController") as SignupViewController
        sut.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
        
    func testSignupViewController_WhenCreated_HasRequiredTextFieldsEmpty() throws {
        // Arrange
        
        // Act
        
        // Assert
        let firstNameTextField = try XCTUnwrap(sut.firstNameTextField, "The First Name text field is not connected to an IBOutlet")
        let lastNametextField = try XCTUnwrap(sut.lastNameTextField, "The Last Name text field is not connected to an IBOutlet")
        let emailTextField = try XCTUnwrap(sut.emailTextField, "The Email text field is not connected to an IBOutlet")
        let passwordTextField = try XCTUnwrap(sut.passwordTextField, "The Password text field is not connected to an IBOutlet")
        let repeatPasswordTextField = try XCTUnwrap(sut.repeatPasswordTextField, "The Repeat Password text field is not connected to an IBOutlet")

        XCTAssertEqual(firstNameTextField.text,
                       "",
                       "First Name text field is not empty when the ViewController initialy loaded")
        XCTAssertEqual(lastNametextField.text,
                       "",
                       "Last Name text field is not empty when the ViewController initialy loaded")
        XCTAssertEqual(emailTextField.text,
                       "",
                       "Email text field is not empty when the ViewController initialy loaded")
        XCTAssertEqual(passwordTextField.text,
                       "",
                       "Password text field is not empty when the ViewController initialy loaded")
        XCTAssertEqual(repeatPasswordTextField.text,
                       "",
                       "Repeat Password text field is not empty")
    }
        
    func testSignupViewController_WhenCreated_HasSignupButtondAndAction() throws {
        // Arrange
        let signupButton = try XCTUnwrap(sut.signupButton,
                                         "Signup button does not hace referencing outlet")
        
        // Act
        let signupButtonActions = try XCTUnwrap(signupButton.actions(forTarget: sut, forControlEvent: .touchUpInside),
                                                "Signup button does not have any actions assigned to it")
        
        // Assert
        XCTAssertEqual(signupButtonActions.count,
                       1,
                       "Signup button have \(signupButtonActions.count) action(s)")
        XCTAssertTrue(signupButtonActions.contains("signupButtonTapped:"), "There is no action with a name signupButtonTapped: assigned to signup button")
    }
    
    func testSignupViewController_WhenSignupButtonTapped_InvokesSignupProcess() {
        // Arrange
        let mockSignupModelValidator = MockSignupModelValidator()
        let mockSignupWebService = MockSignupWebService()
        let mockSignupViewDelegate = MockSignupViewDelegate()
        
        let mockSignupPresenter = MockSignupPresenter(formModelValidator: mockSignupModelValidator,
                                                      webService: mockSignupWebService,
                                                      delegate: mockSignupViewDelegate)
        
        sut.signupPresenter = mockSignupPresenter
        
        // Act
        sut.signupButton.sendActions(for: .touchUpInside)
        
        // Assert
        XCTAssertTrue(mockSignupPresenter.processUserSignupCalled,
                      "The processUserSignup() method was not called on a Presenter object when the signup button was tapped in a SignupViewController")
    }
    
    // MARK: - Unit Test UITextField Attributes
    
    func testEmailTextField_WhenCreated_HasEmailAddressContentTypeSet() throws {
        let emailTextField = try XCTUnwrap(sut.emailTextField, "Email address UITextField is not connected")
        XCTAssertEqual(emailTextField.textContentType,
                       UITextContentType.emailAddress,
                       "Email address UITextField does not have a email address content type, it has \(String(describing: emailTextField.textContentType))")
    }
    
    func testEmailTextField_WhenCreated_HasEmailKeyboardTypeSet() throws {
        let emailTextField = try XCTUnwrap(sut.emailTextField, "Email address UITextField is not connected")
        XCTAssertEqual(emailTextField.keyboardType,
                       UIKeyboardType.emailAddress,
                       "Email address UITextField does not have a email address content type, it has \(String(describing: emailTextField.textContentType))")
    }
    
    func testPasswordTextField_WhenCreated_IsSecureTextEntryTextField() throws {
        let passwordTextField = try XCTUnwrap(sut.passwordTextField, "Password UITextField is not connected")
        XCTAssertTrue(passwordTextField.isSecureTextEntry)
    }
    
    // MARK: - Navigation Testing
    
    func testRegistrationViewButton_WhenTapped_RegistrationViewControllerIsPushed() {
        // Arrange
        let navigationController = UINavigationController(rootViewController: sut)
        let predicate = NSPredicate { input, _ in
            (input as? UINavigationController)?.topViewController is RegisterViewController
        }
        expectation(for: predicate, evaluatedWith: navigationController)
        
        // Act
        sut.registerButton.sendActions(for: .touchUpInside)
        
        // Assert
        waitForExpectations(timeout: 2)
    }
    
    func testRegistrationViewButton_WhenTapped_RegistrationViewControllerIsPushed_V2() {
        // Arrange
        let navigationController = UINavigationController(rootViewController: sut)
        
        // Act
        sut.registerButton.sendActions(for: .touchUpInside)
        
        RunLoop.current.run(until: Date())
        
        // Assert
        guard let _ = navigationController.topViewController as? RegisterViewController else {
            XCTFail()
            return
        }
        
        // if it reaches the end, the test pass 🎉
    }
    
    func testRegistrationViewButton_WhenTapped_RegistrationViewControllerIsPushed_V3() {
        // Using a SPYING OBJECT
        
        // Arrange
        let spyNavigationController = SpyNavigationController(rootViewController: sut)
        
        // Act
        sut.registerButton.sendActions(for: .touchUpInside)
        
        // Assert
        guard let _ = spyNavigationController.pushedViewController as? RegisterViewController else {
            XCTFail()
            return
        }
        
        // if it reaches the end, the test pass 🎉
    }
}
