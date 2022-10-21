//
//  SavedView.swift
//  Color.Dev_UI
//
//  Created by Shubham Singh on 21/10/22.
//

import SwiftUI

struct SavedView: View {
    
    // MARK: - Variables
    
    
    // MARK: - Views
    var body: some View {
        ZStack {
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
                Color.background
                    .edgesIgnoringSafeArea(.all)
                
                RoundedRectangle(cornerRadius: 44)
                    .stroke(style: StrokeStyle(lineWidth: 1.5, lineCap: .round, lineJoin: .round))
                    .opacity(0.3)
                    .rotationEffect(.degrees(240))
                VStack(alignment: .leading) {
                    Text("Color.Dev")
                        .font(TypefaceTwo.bold.font(size: 34))
                }
                .padding(24)
            }
            ZStack {
                Text("Saved Colors")
                    .font(TypefaceTwo.medium.font(size: 24))
            }
        }
    }
}

struct SavedView_Previews: PreviewProvider {
    static var previews: some View {
        SavedView()
    }
}
