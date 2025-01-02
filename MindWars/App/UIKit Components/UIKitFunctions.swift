//
//  UIKitFunctions.swift
//  MindWars
//
//  Created by Yiğit Tilki on 22.12.2024.
//

import Foundation
import UIKit

class UIKitFunctions {
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
