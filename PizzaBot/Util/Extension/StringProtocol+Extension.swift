//
//  StringProtocol+Extension.swift
//  PizzaBot
//
//  Created by Julio Collado on 10/9/21.
//

import Foundation

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
