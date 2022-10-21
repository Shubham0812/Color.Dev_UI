//
//  FoundationExtension.swift
//  Color.Dev_UI
//
//  Created by Shubham Singh on 18/10/22.
//

import UIKit

extension Int {
    func appendZeros() -> String {
        if (self < 10) {
            return "0\(self)"
        } else {
            return "\(self)"
        }
    }
    
    func degreeToRadians() -> CGFloat {
        return  (CGFloat(self) * .pi) / 180
    }
}

extension Double {
    func convert(fromRange: (Double, Double), toRange: (Double, Double)) -> Double {
        var value = self
        value -= fromRange.0
        value /= Double(fromRange.1 - fromRange.0)
        value *= toRange.1 - toRange.0
        value += toRange.0
        return value
    }
    func clean(places: Int) -> String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.\(places)f", self)
    }
    
    func convertToHex() -> String{
        var colorCode = ""
        let hexDict: [Int: String] = [0: "0", 1: "1",2: "2", 3: "3", 4: "4", 5: "5",6: "6", 7: "7", 8: "8", 9: "9", 10: "A", 11: "B", 12: "C", 13: "D", 14: "E", 15: "F"]
        let rem = self / 16.0
        var decimal = 0.0
        var round = 0
        if let value = hexDict[Int(rem)] {
            colorCode += value
        }
        decimal = rem.truncatingRemainder(dividingBy: 1)
        round = Int(decimal * 16)
        if let value = hexDict[round] {
            colorCode += value
        }
        return colorCode.lowercased()
    }
    func convertToInt() -> Int {
        return Int(self)
    }
}
