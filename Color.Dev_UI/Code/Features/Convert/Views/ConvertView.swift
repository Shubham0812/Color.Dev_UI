//
//  MainView.swift
//  Color.Dev_UI
//
//  Created by Shubham Singh on 18/10/22.
//

import SwiftUI

struct MainView: View {
    
    // MARK: - Variables
    
    
    // MARK: - Views
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            Color.homeBlue
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Color.Dev")
                    .font(.system(size: 34, weight: .semibold, design: .monospaced))
                    .tracking(-2)
                    .foregroundColor(.white)
            }
            .padding(24)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
