//
//  Validator.swift
//  PizzaBot
//
//  Created by Julio Collado on 10/9/21.
//

import Foundation

protocol Validatable {
    func isValid(instruction text: String, regex: String) -> Bool
}

class InstructionValidator: Validatable {
    func isValid(instruction text: String, regex: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: text)
    }
}

