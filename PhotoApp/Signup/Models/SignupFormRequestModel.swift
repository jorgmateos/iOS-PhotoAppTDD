//
//  SignupFormRequestModel.swift
//  PhotoApp
//
//  Created by Jorge Garcia Mateos on 19/9/22.
//

import Foundation

struct SignupFormRequestModel: Encodable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
}
