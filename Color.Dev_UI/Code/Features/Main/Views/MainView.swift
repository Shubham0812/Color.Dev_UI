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
            Color.background
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Hello, world!")
            }.padding(24)
        }
        .padding()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
