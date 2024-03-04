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
    @State var toRomanNumeral: Bool = false
    @State var conversion = Conversion.toRomanNumeral
    
    let romanNumerals = ["I","V","X","L","C","D","M"]
    let digits = ["1","2","3","4","5","6","7","8","9","0"]
    let conversionOptions = ["to RomanNumeral", "to Arabic"]
    
    private var gridItemLayout = [GridItem(.adaptive(minimum: 100)),
                                  GridItem(.adaptive(minimum: 100)),
                                  GridItem(.adaptive(minimum: 100)),
                                  GridItem(.adaptive(minimum: 100))]
    
    var body: some View {
        
        NavigationStack{
            ZStack {
            
                LinearGradient(colors: [.backgroundStart, .backgroundEnd], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
            
                VStack(alignment: .leading) {
                    
                    //MARK: - Picker -
                    
                    Picker("Conversion", selection: $conversion) {
                        ForEach(Conversion.allCases, id: \.self) { conversion in
                            Text("\(conversion.rawValue)")
                        }
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: conversion) {
                        enteredNumber = ""
                    }
                    
                    //MARK: --

                    Spacer()
                    
                    //MARK: - Entered Number and Line -
                    
                    VStack(alignment: .leading, spacing: 0){
                        Text(enteredNumber)
                            .font(.title.weight(.semibold))
                            .foregroundStyle(.white)

                        RoundedRectangle(cornerRadius: 5)
                            .frame(maxWidth: .infinity, maxHeight: 5)
                            .foregroundColor(.white)
                            .containerRelativeFrame(.horizontal, count: 5, span: 3, spacing: 10)
                    }
                    
                    //MARK: - Keyboard -
                    
                    VStack {
                        
                        // rows with enough
                        LazyVGrid(columns: gridItemLayout, alignment: .center) {
                            ForEach(conversion == Conversion.toRomanNumeral ? digits : romanNumerals, id: \.self) { rN in
                                
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundStyle(.keyBackground)
                                        .aspectRatio(1, contentMode: .fit)
                                        .onTapGesture {
                                            enteredNumber += rN
                                        }
                                    
                                    Text("\(rN)")
                                        .font(.system(size: 24))
                                        .bold()
                                }
                            }
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundStyle(.keyBackground)
                                    .aspectRatio(1, contentMode: .fit)
                                    .onTapGesture {
                                        enteredNumber = String(enteredNumber.dropLast(1))
                                    }
                                
                                Image(systemName: "delete.left.fill")
                                    .tint(.white)
                            }
                        }
                        .padding()
                        
                        
//                        HStack {
//                            ForEach(conversion == Conversion.toRomanNumeral ? digits.suffix(digits.count % 4) : romanNumerals.suffix(romanNumerals.count % 4), id: \.self) { rN in
//                                ZStack {
//                                    RoundedRectangle(cornerRadius: 10)
//                                        .foregroundStyle(.keyBackground)
//                                        .aspectRatio(1, contentMode: .fit)
//                                        .onTapGesture {
//                                            enteredNumber += rN
//                                        }
//                                    
//                                    Text("\(rN)")
//                                        .font(.system(size: 24))
//                                        .bold()
//                                }
//                            }
//                            
//                            ZStack {
//                                RoundedRectangle(cornerRadius: 10)
//                                    .foregroundStyle(.keyBackground)
//                                    .aspectRatio(1, contentMode: .fit)
//                                    .onTapGesture {
//                                        enteredNumber = String(enteredNumber.dropLast(1))
//                                    }
//                                
//                                Image(systemName: "delete.left.fill")
//                                    .tint(.white)
//                            }
//                        }
//                        .padding([.horizontal])
                    }
                    .background {
                        Color.keyboardBackground.opacity(0.5)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                .padding()
                
                //MARK: - Conversion Text -
                
                VStack {
                    Spacer()
                    Text(conversion == Conversion.toRomanNumeral ? RomanNumeral.shared.convertToRomanNumeral(from: enteredNumber) ?? "" : RomanNumeral.shared.convertToArabicNumber(from: enteredNumber) ?? "")
                        .font(.custom("Times", size: 76))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .lineLimit(1)
                        .minimumScaleFactor(0.1)
                        .padding(.horizontal)
                    Spacer()
                    Spacer()
                }
            }
            .navigationTitle("Number Converter")

        }
    }
    
    enum Conversion: String, CaseIterable {
        case toRomanNumeral = "to Roman Numeral"
        case toArabic = "to Arabic"
    }
}

#Preview {
    ContentView()
}
