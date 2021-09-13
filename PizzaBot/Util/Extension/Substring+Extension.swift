//
//  Substring+Extension.swift
//  PizzaBot
//
//  Created by Julio Collado on 13/9/21.
//

import Foundation

extension Substring {
    subscript (safe index: Int) -> Element? {
        0 <= index && index < count ? self[index] : nil
    }
}
