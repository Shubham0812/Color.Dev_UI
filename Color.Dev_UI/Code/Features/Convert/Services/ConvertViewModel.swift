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
    @Published var rgbField: String = "" {
        didSet {
            guard rgbField.isEmpty, rgbFocused else { return }
            self.rgbField += "rgb("
        }
    }
    @Published var contrastChangeNeeded = false
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
        
        enableClearButton = true
        let hexValue = hexField
        if (hexValue.count == 3) {
            var color = ""
            for ch in hexValue{
                color += String(repeating: ch, count: 2)
            }
            print("COLOR", color)
            self.generateRGB(rgbValue: UInt32(String(color), radix: 16)!)
            withAnimation(.easeInOut(duration: 0.3)) {
                self.backgroundColor = Color(UIColor.fromHex(rgbValue: UInt32(String(color), radix: 16)!, alpha: 1.0))
            }
            validColor = true
        } else if (hexValue.count == 6) {
            self.generateRGB(rgbValue: UInt32(String(hexValue), radix: 16)!)
            withAnimation(.easeInOut(duration: 0.3)) {
                self.backgroundColor = Color(UIColor.fromHex(rgbValue: UInt32(String(hexValue), radix: 16)!, alpha: 1.0))
            }
            validColor = true
        } else {
            resetBackgroundColor()
            withAnimation(.easeInOut(duration: 0.25)) {
                self.rgbField = ""
            }
        }
        validColor = false
    }
    
    
    func rgbFieldChanged(newValue: String, focused: Bool = false) {
        guard rgbField.count > 0 else { enableClearButton = false; return }
        guard acceptedRgb.contains(newValue) else {
            rgbField.removeLast()
            return
        }
        
        enableClearButton = true
        let rgbValue = rgbField
        var colorComponents = rgbValue.replacingOccurrences(of: "rgb(", with: "").replacingOccurrences(of: ")", with: "").components(separatedBy: ",").map({$0.replacingOccurrences(of: " ", with: "")})
        if ((rgbValue.hasSuffix(")"))) {
            if (colorComponents.count < 3 ) {
                colorComponents.append("0")
            }
            let r = Int(colorComponents[0]) ?? 0
            let g = Int(colorComponents[1]) ?? 0
            let b = Int(colorComponents[2]) ?? 0
            
            if !(r > 255 || g > 255 || b > 255) {
                self.generateHexFromRGB(red: Double(r), green: Double(g), blue: Double(b), focused: focused)
                validColor = true
                withAnimation(.easeInOut(duration: 0.3)) {
                    self.backgroundColor = Color(UIColor(red: r, green: g, blue: b))
                }
            }
        } else {
            resetBackgroundColor()
            withAnimation(.default) {
                self.hexField = ""
            }
            validColor = false
        }
    }
    
    
    func generateRGB(rgbValue:UInt32){
        let red = Int((rgbValue & 0xFF0000) >> 16)
        let green = Int((rgbValue & 0xFF00) >> 8)
        let blue = Int(rgbValue & 0xFF)
        
        rgbField = "rgb(\(red), \(green), \(blue))"
        
        let r = Double((rgbValue & 0xFF0000) >> 16) * 0.299
        let g = Double((rgbValue & 0xFF00) >> 8) * 0.587
        let b = Double((rgbValue & 0xFF)) * 0.114
        
        if ((r + g + b) > 186) {
            changeContrastValue(enable: true)
        } else {
            changeContrastValue(enable: false)
        }
        rgbField = "rgb(\(red),\(green),\(blue))"
    }
    
    func generateHexFromRGB(red: Double , green: Double, blue: Double, focused: Bool = false) {
        let hexString = red.convertToHex() + green.convertToHex() + blue.convertToHex()
        
        if (focused) {
            hexField = hexString
        }
        
        let r = red * 0.299
        let g = green * 0.587
        let b = blue * 0.114
        if ((r + g + b) > 186){
            changeContrastValue(enable: true)
        } else {
            changeContrastValue(enable: false)
        }
        validColor = true
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
            changeContrastValue(enable: false)
        }
    }
    
    func closeKeyboard() {
        UIApplication.shared.endEditing()
    }
    
    func changeContrastValue(enable: Bool = false) {
        withAnimation(.easeInOut(duration: contrastDuration)) {
            self.contrastChangeNeeded = enable
        }
    }
}
