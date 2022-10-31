//
//  SignupViewDelegateProtocol.swift
//  PhotoApp
//
//  Created by Jorge Garcia Mateos on 12/10/22.
//

import Foundation

protocol SignupViewDelegateProtocol: AnyObject {
    func sucessfulSignup()
    func errorHandler(error: SignupError)
}
