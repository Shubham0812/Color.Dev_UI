//
//  ImageView.swift
//  Color.Dev_UI
//
//  Created by Sai Nikhit Gulla on 10/22/22.
//

import SwiftUI

struct ImageView: View {
    
    // MARK:- variables
    var content: Image
    var imageName: String
    var lineWidth: CGFloat
    var borderColor: Color
    
    // MARK:- View
    var body: some View {
        content
            .resizable()
            .clipShape(Circle())
            .shadow(radius: lineWidth)
            .overlay(Circle().stroke(borderColor, lineWidth: lineWidth))
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 25) {
            ImageView(content: Image(systemName: "chevron.right"), imageName: "chevron", lineWidth: 5, borderColor: .yellow)
                .frame(width: 40, height: 40)
            
            ImageView(content: Image(systemName: "chevron.right"), imageName: "chevron", lineWidth: 5, borderColor: .green)
                .frame(width: 40, height: 40)
        }
       
    }
}


