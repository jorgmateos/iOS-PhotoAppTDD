//
//  SignupWebServiceProtocol.swift
//  PhotoApp
//
//  Created by Jorge Garcia Mateos on 11/10/22.
//

import Foundation

protocol SignupWebServiceProtocol {
    func signup(withForm form: SignupFormRequestModel,
                completionHandler: @escaping (SignupResponseModel?, SignupError?) -> Void )
}
