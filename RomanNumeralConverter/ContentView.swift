//
//  ContentView.swift
//  RomanNumeralConverter
//
//  Created by Johnny O on 2/18/24.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var enteredNumber: String = ""
    @State var toRomanNumeral: Bool = true
    
    var romanNumeral: String = ""
    
    var body: some View {
        
        NavigationStack{
            
            ZStack {
                
                LinearGradient(colors: [.backgroundStart, .backgroundEnd], startPoint: .top, endPoint: .bottom)
                
                VStack(alignment: .leading){
                    Spacer()
                    
                    ZStack(alignment: .center) {
                        
                        VStack {
                            Toggle(toRomanNumeral ? "to Roman Numerals" : "to Arabic", isOn: $toRomanNumeral)
                                .padding([.horizontal, .top], 10)
                            
                            Divider()
                                .padding(.horizontal, 30)
                            
                            TextField("Enter an integer", text: $enteredNumber)
                                .textFieldStyle(.automatic)
                                .keyboardType(.numberPad)
                                .frame(width: 200)
                                .multilineTextAlignment(.center)
                                .font(.custom("system", size: 20))
                                .padding([.bottom], 10)
                        }
                    }
                    .background(.stackBackground)
                    .cornerRadius(20)
                    .padding([.horizontal], 30)
                    Spacer()
                    Spacer()
                }
                
                VStack(alignment: .center) {
                    Text(toRomanNumeral ? RomanNumeralConverter.convert(Int(enteredNumber) ?? 0) : "to Arabic")
                        .font(.custom("Times", size: 76))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .lineLimit(1)
                        .minimumScaleFactor(0.1)
                        .padding(.horizontal)
                }
            }
            .ignoresSafeArea()
            .navigationTitle("Number Converter")
        }
    }
}

#Preview {
    ContentView()
}
