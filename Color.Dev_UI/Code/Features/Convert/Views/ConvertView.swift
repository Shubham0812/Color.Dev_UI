//
//  ConvertView.swift
//  Color.Dev_UI
//
//  Created by Shubham Singh on 18/10/22.
//

import SwiftUI
import Combine

struct ConvertView: View {
    
    enum FocusField: Hashable {
        case hex
        case rgb
    }
    
    // MARK: - Variables
    @State var trimEnd: CGFloat = 0
    @State var viewAppeared = false
    
    @EnvironmentObject var convertViewModel: ConvertViewModel
    @FocusState private var focusedField: FocusField?
    
    let animationDuration: TimeInterval = 2.5
    
    
    // MARK: - Views
    var body: some View {
        GeometryReader { proxy in
            let height: CGFloat = proxy.size.height
            
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
                convertViewModel.backgroundColor
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        convertViewModel.closeKeyboard()
                    }
                VStack(alignment: .leading) {
                    Text("Color.Dev")
                        .font(TypefaceTwo.bold.font(size: 34))
                    VStack(alignment: .leading) {
                        Spacer()
                        HStack {
                            Spacer()
                            Image("hash")
                                .resizable()
                                .frame(width: 26, height: 26)
                            ValidatedTextField(
                                "hex",
                                value: $convertViewModel.hexField,
                                formatter: convertViewModel.hexFormatter
                            )
                                .textCase(.lowercase)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .accentColor(.label)
                                .focused($focusedField, equals: .hex)
                                .font(TypefaceOne.medium.font(size: 24))
                                .background {
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(style: StrokeStyle(lineWidth: self.focusedField == .hex ? 1.2 : 0.8, lineCap: .round, lineJoin: .round))
                                        .frame(height: 1)
                                        .offset(y: 24)
                                        .opacity(self.focusedField == .hex ? 1 : 0.6)
                                        .animation(.default, value: self.focusedField)
                                }
                                .textSelection(.disabled)
                                .offset(y: -4)
                                .padding(.leading, 4)
                            Spacer()
                        }
                        
                        HStack {
                            Spacer()
                            Image("bucket")
                                .resizable()
                                .frame(width: 28, height: 28)
                            ValidatedTextField("rgb", value: $convertViewModel.rgbField, formatter: convertViewModel.rgbFormatter)
                            .textCase(.lowercase)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .accentColor(.label)
                            .focused($focusedField, equals: .rgb)
                            .font(TypefaceOne.medium.font(size: 24))
                            .background {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(style: StrokeStyle(lineWidth: self.focusedField == .rgb ? 1.2 : 0.8, lineCap: .round, lineJoin: .round))
                                    .frame(height: 1)
                                    .offset(y: 24)
                                    .opacity(self.focusedField == .rgb ? 1 : 0.6)
                                    .animation(.default, value: self.focusedField)
                            }
                            .padding(.leading, 4)
                            Spacer()
                        }
                        .padding(.top, 20)
                        Spacer()
                        
                        HStack(spacing: 4) {
                            Spacer()
                            Button {
                                //TODO: Write the logic in ViewModel to Save the Color
                                convertViewModel.saveColor()
                            } label: {
                                Text("Save")
                                    .font(TypefaceTwo.semibold.font(size: 24))
                            }
                            .padding(7)
                            .padding(.horizontal, 14)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(style: StrokeStyle(lineWidth: 2))
                                    .foregroundColor(convertViewModel.backgroundColor)
                                    .contrast(0.5)
                                    .opacity(convertViewModel.validColor ? 1 : 0.1)
                            )
                            .buttonStyle(.plain)
                            .disabled(!convertViewModel.validColor)
                            .frame(width: 100)

                            Button {
                                convertViewModel.clearColor()
                            } label: {
                                Text("Clear")
                                    .font(TypefaceTwo.medium.font(size: 24))
                            }
                            .padding(10)
                            .buttonStyle(.plain)
                            .disabled(!convertViewModel.enableClearButton)
                            .frame(width: 100)
                            
                            Spacer()
                        }
                        .offset(y: height * 0.04)
                    }
                    .padding(.horizontal, 34)
                    .padding(.bottom, height * 0.15)
                }
                .padding(24)
            }
        }
        .ignoresSafeArea(.keyboard, edges: .vertical)
        .onAppear() {
            withAnimation(.default) {
                self.focusedField = .hex
            }
        }
        .onChange(of: focusedField) { newValue in
            self.convertViewModel.rgbFocused = newValue == .rgb
            self.convertViewModel.hexFocused = newValue == .hex
        }
    }
}

struct ConvertView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ConvertView()
                .colorScheme(.dark)
                .environmentObject(ConvertViewModel())
        }
    }
}


/// Closes Keyboard
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
