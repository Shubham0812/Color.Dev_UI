//
//  ValidatedTextField.swift
//  Color.Dev_UI
//
//  Created by Amit Samant on 30/10/22.
//

import Foundation
import SwiftUI

struct ValidatedTextField: View {
    
    @Binding var text: String
    let title: String
    let formatter: Formatter
    
    public init(_ title: String, value: Binding<String>, formatter: Formatter) {
        self.title = title
        self._text = value
        self.formatter = formatter
    }
    
    var body: some View {
        let textProxy = Binding<String> {
            return self.text
        } set: { newValue, _ in
            guard formatter.isPartialStringValid(newValue, newEditingString: nil, errorDescription: nil) else {
                return
            }
            self.text = newValue
        }
        TextField(title, text: textProxy) { isEditing in
            DispatchQueue.main.async {
                if let text = formatter.string(for: self.text as AnyObject) {
                    self.text = text
                }
            }
        }
    }
}
