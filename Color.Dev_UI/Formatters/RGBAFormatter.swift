//
//  RGBAFormatter.swift
//  Color.Dev_UI
//
//  Created by Amit Samant on 30/10/22.
//

import Foundation

class RGBAFormatter: Formatter {
    
    let rgbRegex = try! NSRegularExpression(pattern: #"^\s*?(?>rgb|RGB\s*)?(?>\()?([01]?\d\d?|2[0-4]\d|25[0-5])\s*?,\s*?([01]?\d\d?|2[0-4]\d|25[0-5])\s*?,\s*?([01]?\d\d?|2[0-4]\d|25[0-5])\s*?(?>\)\s*)?$"#)
    let rgbaCharacterSet = CharacterSet(charactersIn: "(),0123456789rgbRGB")
    
    private func isValidRGBA(_ value: String) -> Bool {
        rgbRegex.firstMatch(in: value, range: NSRange(location: 0, length: value.utf16.count)) != nil
    }
    
    override func string(for obj: Any?) -> String? {
        
        guard let string = obj as? String,
              let match = rgbRegex.firstMatch(in: string, range: NSRange(location: 0, length: string.utf16.count)) else {
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
        return "rgb(\(groups[0]),\(groups[1]),\(groups[2]))"
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
