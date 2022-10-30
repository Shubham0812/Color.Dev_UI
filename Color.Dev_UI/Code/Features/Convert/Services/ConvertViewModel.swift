//
//  MainViewModel.swift
//  Color.Dev_UI
//
//  Created by Shubham Singh on 20/10/22.
//

import SwiftUI
import Combine

class ConvertViewModel: ObservableObject {
    
    // MARK: - Variables
    @Published var hexField: String = "" 
    @Published var rgbField: String = ""
    
    @Published var validColor = false
    
    @Published var backgroundColor: Color = .homeBlue
    @Published var rgbFocused = false
    @Published var hexFocused = true
    
    @Published var enableClearButton = false
        
    let contrastDuration: TimeInterval = 0.35
    
    let hexFormatter = HexFormatter()
    let rgbFormatter = RGBFormatter()
    var cancellable = Set<AnyCancellable>()
    
    // MARK: - Inits
    init() {
        setUpHexFieldChangeObservation()
        setUpRgbFieldChangeObservation()
    }
    
    func setUpHexFieldChangeObservation() {
        _hexField.projectedValue.sink { newValue in
            self.validColor = newValue.count == 6
            self.updateClearButtonStatus()
            guard self.hexFocused else { return }
            self.setCurrentHexColor()
        }.store(in: &cancellable)
        
    }
    
    func setUpRgbFieldChangeObservation() {
        _rgbField.projectedValue.sink { newValue in
            self.validColor = self.rgbFormatter.isValidRGBA(newValue)
            self.updateClearButtonStatus()
            guard self.rgbFocused else { return }
            self.setCurrentRGBAColor()
        }.store(in: &cancellable)
    }
    
    func updateClearButtonStatus() {
        self.enableClearButton = !hexField.isEmpty || !rgbField.isEmpty
    }
    
    func setCurrentHexColor() {
        guard hexField.count == 6 else {
            resetBackgroundColor()
            resetRGBAText()
            return
        }
                
        let rgba = UIColor.getRGBA(forHex: hexField)
        let uiColor = UIColor(rgba: rgba)
        let color = Color(uiColor: uiColor)
        withAnimation(.spring()) {
            self.backgroundColor = color
        }
        setRGBAText(withRGBA: rgba)
    }
    
    func setCurrentRGBAColor() {
        guard !rgbField.isEmpty,
              let uiColor = rgbFormatter.uiColor(forString: rgbField)
        else {
            resetBackgroundColor()
            resetHexText()
            return
        }
        let color = Color(uiColor: uiColor)
        withAnimation {
            self.backgroundColor = color
        }
        
        let hexCode = uiColor.getHex()
        setHexText(withHex: hexCode)
    }
    
    func setRGBAText(withRGBA rgba: RGBA) {
        self.rgbField = "rgb(\(Int(rgba.red * 255)),\(Int(rgba.green * 255)),\(Int(rgba.blue * 255)))"
    }
    
    func resetRGBAText() {
        self.rgbField = ""
    }
    
    func setHexText(withHex hex: String) {
        self.hexField = hex
    }
    
    func resetHexText() {
        self.hexField = ""
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
