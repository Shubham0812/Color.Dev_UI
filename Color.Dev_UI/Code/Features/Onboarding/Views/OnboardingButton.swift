//
//  OnboardingButton.swift
//  Color.Dev_UI
//
//  Created by Marshall  on 10/31/22.
//

import SwiftUI

struct OnboardingButton: View {
    @State var buttonPressCount = 0
    @State var buttonScale = 1.0
    var width, height: CGFloat
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: width/5)
                .frame(width: width, height: height)
                .foregroundColor(buttonPressCount == 2 ? .primary : .gray)
                .scaleEffect(buttonScale < 1 ? buttonScale * 1.5 : buttonScale )
            RoundedRectangle(cornerRadius: width/5)
                .foregroundColor(.background)
                .frame(width: width*0.9, height: height*0.9)
            RoundedRectangle(cornerRadius: width/5)
                .foregroundColor((buttonPressCount >= 1 ? .primary : .gray))
                .frame(width: width*0.8, height: height*0.8)
                .scaleEffect(buttonScale)
            Image(systemName:"chevron.forward")
                .resizable()
                .foregroundColor(.background)
                .scaledToFit()
                .frame(width: width*0.3, height: height*0.3)
        }
        .scaleEffect(buttonScale)
        .onTapGesture {
            withAnimation {
                
                if buttonPressCount < 2 { buttonPressCount += 1
                } else {
                    buttonPressCount = 0
                }
                
                buttonScale = 0.9
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation {
                        buttonScale = 1.0
                    }
                }
            }
        }
        .frame(width: width, height: height)
    }
}

struct OnboardingButton_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingButton(width: 200, height: 200)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
