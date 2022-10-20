//
//  FontManager.swift
//  Color.Dev_UI
//
//  Created by Shubham Singh on 20/10/22.
//

import SwiftUI

enum TypefaceOne {
    case regular
    case medium
    case semibold
    case bold
    
    func font(size: CGFloat) -> Font {
        switch self {
        case .regular:
            return .custom("Ubuntu-Light", size: size)
        case .medium:
            return .custom("Ubuntu-Regular", size: size)
        case .semibold:
            return .custom("Ubuntu-Medium", size: size)
        case .bold:
            return .custom("Ubuntu-Bold", size: size)
            
        }
    }
}

enum TypefaceTwo {
    case regular
    case medium
    case semibold
    case bold
    
    func font(size: CGFloat) -> Font {
        switch self {
        case .regular:
            return .custom("NocturneSerif-Regular", size: size)
        case .medium:
            return .custom("NocturneSerif-Medium", size: size)
        case .semibold:
            return .custom("NocturneSerif-SemiBold", size: size)
        case .bold:
            return .custom("NocturneSerif-Bold", size: size)
            
        }
    }
}
