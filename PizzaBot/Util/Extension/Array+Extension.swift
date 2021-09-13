//
//  Array+Extension.swift
//  PizzaBot
//
//  Created by Julio Collado on 12/9/21.
//

import Foundation

extension Array where Element == GridPoint {
    var plainDescription: String {
        return self.reduce("") { result, gridPoint in
            result + gridPoint.xPoint.description + gridPoint.yPoint.description
        }
    }
}
