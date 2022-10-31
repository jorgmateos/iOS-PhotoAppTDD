//
//  SignupViewController.swift
//  PhotoApp
//
//  Created by Jorge Garcia Mateos on 12/10/22.
//

import UIKit

class SignupViewController: UIViewController {
    var signupPresenter: SignupPresenterProtocol?
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .light

        /// Test launch argument reading from `SignupFlowUITests`
        //#if DEBUG
        //        if CommandLine.arguments.contains("-skipSurvey") {
        //            print("-skipSurvey")
        //        }
        //#endif
        //
        //#if DEBUG
        //        if ProcessInfo.processInfo.arguments.contains("-skipSurvey") {
        //            print("-skipSurvey")
        //        }
        //#endif

        if signupPresenter == nil {
            let signupModelValidator = SignupFormModelValidator()

            /// Test enviroment argument reading from `SignupFlowUITests`
            //            let signupUrl = ProcessInfo.processInfo.environment["signupUrl"]

            let webService = SignupWebService(urlString: SignupConstants.signupURLString)
            
            signupPresenter = SignupPresenter(formModelValidator: signupModelValidator,
                                              webService: webService,
                                              delegate: self)
            
            // Set text fields attributes for Unit Test UITextField Attributes section
            emailTextField.textContentType = .emailAddress
            emailTextField.keyboardType = .emailAddress
            
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    @IBAction func signupButtonTapped(_ sender: Any) {
        let signupFormModel = SignupFormModel(firstName: firstNameTextField.text ?? "",
                                              lastName: lastNameTextField.text ?? "",
                                              email: emailTextField.text ?? "",
                                              password: passwordTextField.text ?? "",
                                              repeatPassword: repeatPasswordTextField.text ?? "")
        signupPresenter?.processUserSignup(formModel: signupFormModel)
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        let vc = RegisterViewController()
        vc.view.accessibilityIdentifier = "RegisterViewController"
        
        // TODO: change and give responsabilities to the Presenter and maybe a Coordinator
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - SignupViewDelegateProtocol
extension SignupViewController: SignupViewDelegateProtocol {
    func sucessfulSignup() {
        let alert = UIAlertController(title: "Success",
                                      message: "The signup operation was successful",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        DispatchQueue.main.async {
            alert.view.accessibilityIdentifier = "successAlertDialog"
            self.present(alert, animated: true)
        }
    }
    
    func errorHandler(error: SignupError) {
        let alert = UIAlertController(title: "Error",
                                      message: "Your request could not be processed at this time",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        DispatchQueue.main.async {
            alert.view.accessibilityIdentifier = "errorAlertDialog"
            self.present(alert, animated: true)
        }
    }
}
