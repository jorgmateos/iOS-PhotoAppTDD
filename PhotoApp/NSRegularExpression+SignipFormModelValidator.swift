//
//  NSRegularExpression+SignipFormModelValidator.swift
//  PhotoApp
//
//  Created by Jorge Garcia Mateos on 16/9/22.
//

import Foundation

extension NSRegularExpression {
    convenience init(_ pattern: String) {
        do {
            try self.init(pattern: pattern)
        } catch {
            preconditionFailure("Illegal regular expression: \(pattern).")
        }
    }
}
