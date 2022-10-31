//
//  SignupFlowUITests.swift
//  SignupFlowUITests
//
//  Created by Jorge Garcia Mateos on 30/8/22.
//

import XCTest

class SignupFlowUITests: XCTestCase {
    private var app: XCUIApplication!

    private var firstName: XCUIElement!
    private var lastName: XCUIElement!
    private var email: XCUIElement!
    private var password: XCUIElement!
    private var repeatPassword: XCUIElement!

    private var signupButton: XCUIElement!
    private var registerButton: XCUIElement!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()

        app = XCUIApplication()

        /// Testing launch arrguments and enviroment arguments can be replaced by **Test Plans**
//        app.launchArguments = ["-skipSurvey", "-debugServer"] // test launch arguments
//        app.launchEnvironment = ["signupUrl": "testSignupUrl.com", // test launch enviroments
//                                 "inAppPurchasesEnabled": "true",
//                                 "inAppAdsEnabled": "true"]
        app.launch()

        firstName = app.textFields["firstNameTextField"]
        lastName = app.textFields["lastNameTextField"]
        email = app.textFields["emailTextField"]
        password = app.secureTextFields["passwordTextField"]
        repeatPassword = app.secureTextFields["repeatPasswordTextField"]

        signupButton = app.buttons["signupButton"]
        registerButton = app.buttons["registerButton"]


        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try super.tearDownWithError()

        firstName = nil
        lastName = nil
        email = nil
        password = nil
        repeatPassword = nil

        signupButton = nil
        registerButton = nil

        app = nil
    }

    func testSignupViewController_WhenViewLoaded_RequiredUIElementsAreEnabled() throws {
        // Arrange
        // Act

        // Assert
        XCTAssertTrue(firstName.isEnabled, "First name UITextField is not enabled for user interactions")
        XCTAssertTrue(lastName.isEnabled, "Last name UITextField is not enabled for user interactions")
        XCTAssertTrue(email.isEnabled, "Email UITextField is not enabled for user interactions")
        XCTAssertTrue(password.isEnabled, "Password UISecureTextField is not enabled for user interactions")
        XCTAssertTrue(repeatPassword.isEnabled, "First name UISecureTextField is not enabled for user interactions")
        XCTAssertTrue(signupButton.isEnabled, "Signup button is not enabled for user interactions")
    }

    func testViewController_WhenInvalidFormIsSubmited_PresentsErrorAlertDialog() {
        // Arrange
        // Act
        firstName.tap()
        firstName.typeText("S")

        lastName.tap()
        lastName.typeText("S")

        email.tap()
        email.typeText("S")

        password.tap()
        password.typeText("S")

        repeatPassword.tap()
        repeatPassword.typeText("S")

        signupButton.tap()

        // Assert
        XCTAssertTrue(app.alerts["errorAlertDialog"].waitForExistence(timeout: 1),
                      "An eror alert dialog was not presented when invalid signup form was submited")
    }

    func testViewController_WhenInvalidFormIsSubmited_PresentsSuccessAlertDialog() {
        // Arrange
        // Act
        firstName.tap()
        firstName.typeText("Jorge")

        lastName.tap()
        lastName.typeText("García")

        email.tap()
        email.typeText("test@test.test")

        password.tap()
        password.typeText("123456789")

        repeatPassword.tap()
        repeatPassword.typeText("123456789")

        /// To take custom screenshots of UI elements or entire screen; first disable the *Delete when each test succeds*
        /// option in the `Edit Scheme > Test > Option` configuration.
        /// Then, check for the screenshots on the tests report panel

        /// **Screenshot of UI element**
//        let emailScreenshot = email.screenshot()
//        let emailAttatchment = XCTAttachment(screenshot: emailScreenshot)
//        emailAttatchment.name = "Screenshot of email UITextField"
//        emailAttatchment.lifetime = .keepAlways
//        add(emailAttatchment)

        /// **Screenshot of entire screen using XCUIApplication**
//        let currentAppWindow = app.screenshot()
//        let currentAppAttatchment = XCTAttachment(screenshot: currentAppWindow)
//        currentAppAttatchment.name = "Signup page screenshot"
//        currentAppAttatchment.lifetime = .keepAlways
//        add(currentAppAttatchment)

        /// **Screenshot of entire screen using XCUIScreen**
//        let currentAppWindow = XCUIScreen.main.screenshot()
//        let currentAppAttatchment = XCTAttachment(screenshot: currentAppWindow)
//        currentAppAttatchment.name = "Signup page screenshot"
//        currentAppAttatchment.lifetime = .keepAlways
//        add(currentAppAttatchment)

        signupButton.tap()

        // Assert
        XCTAssertTrue(app.alerts["successAlertDialog"].waitForExistence(timeout: 1),
                      "An success alert dialog was not presented when invalid signup form was submited")
    }

    func testRegisterButton_WhenTapped_PresentsRegisterViewController() {
        // Arrange
        // Act
        registerButton.tap()

        // Assert
        XCTAssertTrue(app.otherElements["RegisterViewController"].waitForExistence(timeout: 1),
                      "The RegisterViewController was not presented when register button was tapped")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
