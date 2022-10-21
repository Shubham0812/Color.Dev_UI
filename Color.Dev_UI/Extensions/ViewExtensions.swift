//
//  ViewExtensions.swift
//  Color.Dev_UI
//
//  Created by Shubham Singh on 20/10/22.
//

import SwiftUI

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
