//
//  RGBFormatter.swift
//  Color.Dev_UI
//
//  Created by Amit Samant on 30/10/22.
//

import Foundation
import UIKit.UIColor

class RGBFormatter: Formatter {
    
    let rgbRegex = try! NSRegularExpression(pattern: #"^\s*?(?>rgb|RGB\s*)?(?>\()?([01]?\d\d?|2[0-4]\d|25[0-5])\s*?,\s*?([01]?\d\d?|2[0-4]\d|25[0-5])\s*?,\s*?([01]?\d\d?|2[0-4]\d|25[0-5])\s*?(?>\)\s*)?$"#)
    let rgbaCharacterSet = CharacterSet(charactersIn: "(),0123456789rgbRGB")
    
    func isValidRGBA(_ value: String) -> Bool {
        rgbRegex.firstMatch(in: value, range: NSRange(location: 0, length: value.utf16.count)) != nil
    }
    
    func uiColor(forString string: String) -> UIColor? {
        guard let rgbaComponents = getRGBAComponents(fromString: string),
        let red = Int(rgbaComponents.red),
              let green = Int(rgbaComponents.green),
              let blue = Int(rgbaComponents.blue)
        else {
            return nil
        }
        return UIColor(red: red, green: green, blue: blue)
    }
    
    private func getRGBAComponents(fromString string: String) -> (red: String, green: String, blue: String)? {
        guard let match = rgbRegex.firstMatch(in: string, range: NSRange(location: 0, length: string.utf16.count)) else {
            return nil
        }
        var groups = [String]()
        for rangeIndex in 0..<match.numberOfRanges {
            let matchRange = match.range(at: rangeIndex)
            
            // Ignore matching the entire username string
            if matchRange == NSRange(location: 0, length: string.utf16.count) { continue }
            
            // Extract the substring matching the capture group
            if let substringRange = Range(matchRange, in: string) {
                let capture = String(string[substringRange])
                groups.append(capture)
            }
        }
        guard groups.count == 3 else {
            return nil
        }
        return (groups[0],groups[1],groups[2])
    }
    
    override func string(for obj: Any?) -> String? {
        
        guard let string = obj as? String,
              let rgbaComponents = getRGBAComponents(fromString: string) else {
            return nil
        }
        
        return "rgb(\(rgbaComponents.red),\(rgbaComponents.green),\(rgbaComponents.blue))"
    }
    
    override func getObjectValue(
        _ obj: AutoreleasingUnsafeMutablePointer<AnyObject?>?,
        for string: String,
        errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?
    ) -> Bool {
        obj?.pointee = string as AnyObject
        return true
    }
    
    override func isPartialStringValid(
        _ partialString: String,
        newEditingString newString: AutoreleasingUnsafeMutablePointer<NSString?>?,
        errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?
    ) -> Bool {
        guard let invalidRGBARange = partialString.rangeOfCharacter(from: rgbaCharacterSet.inverted) else {
            return true
        }
        return invalidRGBARange.isEmpty
    }
}
