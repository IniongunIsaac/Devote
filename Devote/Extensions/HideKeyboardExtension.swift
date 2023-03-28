//
//  HideKeyboardExtension.swift
//  Devote
//
//  Created by Isaac Iniongun on 28/03/2023.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
