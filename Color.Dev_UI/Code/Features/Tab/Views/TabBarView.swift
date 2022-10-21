//
//  TabBarView.swift
//  Color.Dev_UI
//
//  Created by Shubham Singh on 21/10/22.
//

import SwiftUI

struct TabBarView: View {
    
    // MARK:- variables
    @EnvironmentObject var tabState: TabState
    
    let animation: Animation = Animation.spring(response: 0.4, dampingFraction: 0.8, blendDuration: 0)
        .speed(0.5).delay(0.2)
    
    let tabIconSize: CGFloat = 38
    
    // MARK:- views
    var body: some View {
        ZStack {
            HStack(spacing: 84) {
                Spacer()
                Button {
                    withAnimation(.spring()) {
                        self.tabState.selectedTab = 0
                    }
                } label: {
                    VStack {
                        Image("convert")
                            .resizable()
                            .frame(width: tabIconSize, height: tabIconSize)
                        Text("Convert")
                            .font(TypefaceTwo.medium.font(size: 14))
                            .fixedSize()
                    }
                }
                .buttonStyle(.plain)
                .opacity(self.tabState.selectedTab == 0 ? 1 : 0.55)
                .animation(.easeIn(duration: 0.25), value: self.tabState.selectedTab)
                .frame(width: 58)
                
                Spacer()
                
                Button {
                    withAnimation(.spring()) {
                        self.tabState.selectedTab = 1
                    }
                } label: {
                    VStack {
                        Image("saved")
                            .resizable()
                            .frame(width: tabIconSize, height: tabIconSize)
                        Text("Saved")
                            .font(TypefaceTwo.medium.font(size: 14))
                    }
                }
                .buttonStyle(.plain)
                .opacity(self.tabState.selectedTab == 1 ? 1 : 0.55)
                .animation(.easeIn(duration: 0.25), value: self.tabState.selectedTab)
                .frame(width: 58)
                Spacer()
            }
            .scaleEffect(0.9)
        }
        .frame(width: UIScreen.main.bounds.width, height: 70)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(hex: "fffcff")
                .edgesIgnoringSafeArea(.all)
            TabBarView()
                .environmentObject(TabState())
        }
    }
}
