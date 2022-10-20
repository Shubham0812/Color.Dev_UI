//
//  ConvertView.swift
//  Color.Dev_UI
//
//  Created by Shubham Singh on 18/10/22.
//

import SwiftUI

struct ConvertView: View {
    
    // MARK: - Variables
    @State var trimEnd: CGFloat = 0
    @State var viewAppeared = false
    
    let animationDuration: TimeInterval = 2.5
    
    
    // MARK: - Views
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            Color.homeBlue
                .edgesIgnoringSafeArea(.all)
            
            RoundedRectangle(cornerRadius: 44)
                .stroke(style: StrokeStyle(lineWidth: 1.5, lineCap: .round, lineJoin: .round))
                .opacity(0.3)
                .rotationEffect(.degrees(240))
                .colorInvert()
            VStack {
                Text("Color.Dev")
                    .font(TypefaceTwo.bold.font(size: 34))
                    .foregroundColor(.white)
            }
            .padding(24)
        }
    }
}

struct ConvertView_Previews: PreviewProvider {
    static var previews: some View {
        ConvertView()
    }
}
