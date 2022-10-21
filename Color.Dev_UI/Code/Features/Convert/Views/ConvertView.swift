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
                            
                            TextField("hex", text: $convertViewModel.hexField)
                                .onChange(of: convertViewModel.hexField, perform: { newValue in
                                    if let lastChar = newValue.last {
                                        let newCharString = String(lastChar)
                                        convertViewModel.hexFieldChanged(newValue: newCharString)
                                    }
                                })
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
                            TextField("rgb", text: $convertViewModel.rgbField, onEditingChanged: { editingChanged in
                                guard editingChanged else { self.convertViewModel.rgbFocused = false; return }
                                self.convertViewModel.rgbFocused = true
                            })
                            .onChange(of: convertViewModel.rgbField, perform: { newValue in
                                if let lastChar = newValue.last {
                                    let newCharString = String(lastChar)
                                    convertViewModel.rgbFieldChanged(newValue: newCharString, focused: focusedField == .rgb)
                                }
                            })
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
                            .padding(5)
                            .padding(.horizontal, 14)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(style: StrokeStyle(lineWidth: 2))
                                    .foregroundColor(.background)
                                    .blur(radius: 1)
                                    .colorMultiply(convertViewModel.contrastChangeNeeded ? .label : .background)
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
                .colorMultiply(convertViewModel.contrastChangeNeeded ? .background : .label) 
                .padding(24)
            }
        }
        .onAppear() {
            withAnimation(.default) {
                self.focusedField = .hex
            }
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
