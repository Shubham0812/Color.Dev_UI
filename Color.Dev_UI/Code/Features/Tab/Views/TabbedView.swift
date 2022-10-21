//
//  TabbedView.swift
//  Color.Dev_UI
//
//  Created by Shubham Singh on 21/10/22.
//

import SwiftUI

struct TabbedView: View {
    
    // MARK:- variables
    @StateObject var tabState: TabState = TabState(selectedTab: 0)
    @StateObject var convertViewModel: ConvertViewModel = ConvertViewModel()

    let tabAnimationDuration: TimeInterval = 0.22
    
    // MARK:- views
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            ZStack {
                ConvertView()
                    .environmentObject(convertViewModel)
            }
            .opacity(self.tabState.selectedTab == 0 ? 1 : 0)
          
            ZStack {
                SavedView()
            }
            .opacity(self.tabState.selectedTab == 1 ? 1 : 0)
            
            
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    TabBarView()
                        .environmentObject(convertViewModel)
                        .environmentObject(tabState)
//                        .padding(.bottom, 4)
                        .zIndex(5)
                    
                }
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}

struct TabbedView_Previews: PreviewProvider {
    static var previews: some View {
        TabbedView()
    }
}


class TabState: ObservableObject {
    @Published var selectedTab: Int
    
    init(selectedTab: Int  = 0) {
        self.selectedTab = selectedTab
    }
}






