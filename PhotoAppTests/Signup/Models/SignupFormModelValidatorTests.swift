//
//  SignupFormModelValidatorTests.swift
//  PhotoAppTests
//
//  Created by Jorge Garcia Mateos on 13/9/22.
//

import XCTest
@testable import PhotoApp

final class SignupFormModelValidatorTests: XCTestCase {
    
    var sut: SignupFormModelValidator!

    override func setUpWithError() throws {
        sut = SignupFormModelValidator()
    }

    ///
    /// If a new instance of the system under test (`sut`) is created during the `setUp()` method,
    /// you hace to released it inside of the `tearDown()` method. This is because for each unit test
    /// method, Xcode will create a new instance of a test case class and it won't release resources
    /// until the last unit test method completes.
    ///
    override func tearDownWithError() throws {
        sut = nil
    }
    
    // MARK: - First Name Validation Unit Tests
    
    func testSignupFormModelValidator_WhenValidFirstNameProvided_ShouldReturnTrue() {
        // Arrange
        // Act
        let isFirstNameValid = sut.isFirstNameValid(firstName: "Sergey")
        
        // Assert
        XCTAssertTrue(isFirstNameValid,
                      "The isFirstNameValid(firstName:) should have returned TRUE for a valid first name but returned \(isFirstNameValid)")
    }
    
    func testSignupFormModelValidator_WhenTooShortFirstNameProvided_ShouldReturnFalse() {
        // Arrange
        // Act
        let isFirstNameValid = sut.isFirstNameValid(firstName: "Fo")
        
        // Assert
        XCTAssertFalse(isFirstNameValid,
                       "The isFirstNameValid(firstName:) should have returned FALSE for a short first name but returned \(isFirstNameValid)")
    }
    
    func testSignupFormModelValidator_WhenTooLongFirstNameProvided_ShouldReturnFalse() {
        // Arrange
        // Act
        let isFirstNameValid = sut.isFirstNameValid(firstName: "SergeySergeySergey")
        
        // Assert
        XCTAssertFalse(isFirstNameValid,
                       "The isFirstNameValid(firstName:) should have returned FALSE for a long first name but returned \(isFirstNameValid)")
    }
    
    // MARK: - Last Name Validation Unit Tests
    
    func testSignupFormModelValidator_WhenLastNameProvided_ShouldReturnTrue() {
        // Arrange
        // Act
        let isLastNameValid = sut.isLastNameValid(lastName: "Sanchez")
        
        // Assert
        XCTAssertTrue(isLastNameValid,
                      "The isLastNameValid(lastName:) method should have returned TRUE for a valid last name but returned \(isLastNameValid)")
    }
    
    func testSignupFormModelValidator_WhenTooShortLastNameProvided_ShouldReturnFalse() {
        // Arrange
        // Act
        let isLastNameValid = sut.isLastNameValid(lastName: "Sa")
        
        // Assert
        XCTAssertFalse(isLastNameValid,
                       "The isLastNameValid(lastName:) method should have returned FALSE for a short last name but returned \(isLastNameValid)")
    }
    
    func testSignupFormModelValidator_WhenTooLongLastNameProvided_ShouldReturnFalse() {
        // Arrange
        // Act
        let isLastNameValid = sut.isLastNameValid(lastName: "SanchezSanchezSanchez")
        
        // Assert
        XCTAssertFalse(isLastNameValid,
                       "The isLastNameValid(lastName:) method should have returned FALSE for a short last name but returned \(isLastNameValid)")
    }
    
    // MARK: - Email Validation Unit Tests
    
    func testSignupFormModelValidator_WhenValidEmailProvided_ShouldReturnTrue() {
        // Arrange
        // Act
        let isEmailValid = sut.isEmailValid(email: "test@test.test")
        
        // Assert
        XCTAssertTrue(isEmailValid,
                      "The isEmailValid(email:) method should return TRUE for a valid email but returned \(isEmailValid) ")
    }
    
    func testSignupFormModelValidator_WhenInvalidEmailProvided_ShouldReturnFalse() {
        // Arrange
        // Act
        let isEmailValid = sut.isEmailValid(email: "test.test")
        
        // Assert
        XCTAssertFalse(isEmailValid,
                       "The isEmailValid(email:) method should return FALSE for an invalid email but returned \(isEmailValid)")
    }
    
    // MARK: - Password Validation Unit Tests
    
    func testSignupFormModelValidator_WhenValidPasswordProvided_ShouldReturnTrue() {
        // Arrange
        // Act
        let isPasswordValid = sut.isPasswordValid(password: "123456789")
        
        // Assert
        XCTAssertTrue(isPasswordValid,
                      "The isPasswordValid(password:) method should return TRUE for a valid password but returned \(isPasswordValid)")
    }
    
    func testSignupFormModelValidator_WhenTooShortPasswordProvided_ShouldReturnFalse() {
        // Arrange
        // Act
        let isPasswordValid = sut.isPasswordValid(password: "12")
        
        // Assert
        XCTAssertFalse(isPasswordValid,
                       "The isPasswordValid(password:) method should return FALSE for a short password but returned \(isPasswordValid)")
    }
    
    func testSignupFormModelValidator_WhenTooLongPasswordProvided_ShouldReturnFalse() {
        // Arrange
        // Act
        let isPasswordValid = sut.isPasswordValid(password: "123456789123456789")
        
        // Assert
        XCTAssertFalse(isPasswordValid,
                       "The isPasswordValid(password:) method should return FALSE for a long password but returned \(isPasswordValid)")
    }
    
    func testSignupFormModelValidator_WhenEqualPasswordsProvided_ShouldReturnTrue() {
        // Arrange
        // Act
        let doPasswordsMatch = sut.doPasswordsMatch(password: "12345678", repeatPassword: "12345678")
        
        // Assert
        XCTAssertTrue(doPasswordsMatch,
                      "The doPasswordsMatch(password:repeatPassword:) should return TRUE for matching passwords but returned \(doPasswordsMatch)")
    }
    
    func testSignupFormModelValidator_WhenNotEqualPasswordsProvided_ShouldReturnFalse() {
        // Arrange
        // Act
        let doPasswordsMatch = sut.doPasswordsMatch(password: "12345678", repeatPassword: "12345677")
        
        // Assert
        XCTAssertFalse(doPasswordsMatch,
                       "The doPasswordsMathc(password:repeatPassword) should return FALSE for not matching passwords but returned \(doPasswordsMatch)")
    }

}
