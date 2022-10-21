//
//  MainViewModel.swift
//  Color.Dev_UI
//
//  Created by Shubham Singh on 20/10/22.
//

import SwiftUI

class ConvertViewModel: ObservableObject {
    
    // MARK: - Variables
    @Published var hexField: String = "" 
    @Published var rgbField: String = ""
    
    @Published var validColor = false
    
    @Published var backgroundColor: Color = .homeBlue
    @Published var rgbFocused = false
    
    @Published var enableClearButton = false
    
    let acceptedHex = "abcdefABCDEF0123456789"
    let acceptedRgb = "(),0123456789rgbRGB"
    
    let contrastDuration: TimeInterval = 0.35
    
    // MARK: - Inits
    init() {
        
    }
    
    // MARK: - Functions
    
    // Detects a change in the HEX Text Field
    // Validate if it's a proper HEX
    // Call the function to Convert it into RGB
    /// don't forget to set the `backGroundColor` property as well to change the color of the View
    func hexFieldChanged(newValue: String) {
        guard hexField.count > 0 else { enableClearButton = false; return }
        guard acceptedHex.contains(newValue) else {
            hexField.removeLast()
            return
        }
        
        guard hexField.count <= 6 else {
            hexField.removeLast()
            return
        }
    }
    
    // write the Code to Generate RGB
    func generateRGB(rgbValue:UInt32) {
       
    }

    func saveColor() {
        /// write the code for saving Colors here
    }
    
    func clearColor() {
        withAnimation(.easeInOut(duration: 0.3)) {
            self.hexField = ""
            self.rgbField = ""
        }
        self.validColor = false
        self.enableClearButton = false
        
        resetBackgroundColor()
    }
    
    // MARK: - Utliity Functions
    func resetBackgroundColor() {
        withAnimation(.spring()) {
            self.backgroundColor = .homeBlue
        }
    }
    
    func closeKeyboard() {
        UIApplication.shared.endEditing()
    }
    
   
}
